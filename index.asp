<%@  language="VBScript" %>
<!-- #include virtual=/assets/lib/utils.asp -->
<!-- #include virtual=/assets/lib/header2.asp -->
<!--#include virtual="/adovbs.inc"-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css" type="text/css" / >
<style type="text/css">
    .datalist {
    }
    .divider{
        width:5px;
        height:auto;
        display:inline-block;
    }
    .modal-body {
    max-height: 520px;
    padding: 15px;
    overflow-y: auto;
}
    .modal {
    position: fixed;
    width:50%;
    top: 50%;
    left: 50%;
    margin: -300px 0 0 -400px;   
}
   .nav-pills a[href="#IPs"] {
       background-color:aquamarine;
   }

   .nav-pills a[href="#Reg"] {
       background-color:lime;
   }

   .nav-pills a[href="#Mining"] {
       background-color:aqua;
   }

   .nav-pills a[href="#ISO"] {
       background-color:burlywood;
   }

   .nav-pills a[href="#Convergence"] {
       background-color:gold;
   }

   tr td.col-md-2:nth-child(3),td.col-md-2:nth-child(4),td.col-md-2:nth-child(5) {
        cursor: pointer;
    }

    /* Start by setting display:none to make this hidden.
   Then we position it in relation to the viewport window
   with position:fixed. Width, height, top and left speak
   for themselves. Background we set to 80% white with
   our animation centered, and no-repeating */
    .loadmodal {
        display:    none;
        position:   fixed;
        z-index:    1000;
        top:        0;
        left:       0;
        height:     100%;
        width:      100%;
        background: rgba( 255, 255, 255, .8 ) 
                    url('../assets/img/ajax-loader.gif') 
                    50% 50% 
                    no-repeat;
    }

    /* When the body has the loading class, we turn
       the scrollbar off with overflow:hidden */
    body.loading {
        overflow: hidden;   
    }

    /* Anytime the body has the loading class, our
       modal element will be visible */
    body.loading .loadmodal {
        display: block;
    }

</style>

<div class="container">
    <div class="row">
        <div class="span12">
            <% 
                dim objFileSystem
                Set objFileSystem=Server.CreateObject("Scripting.FileSystemObject")
                if(objFileSystem.FileExists(Server.MapPath("/" & session("stp_companyid") & "/logo.jpg"))) then
                    Response.Write("<img src='/assets/logo/" & session("stp_companyid") & "/logo.jpg' style='padding-top:15px;padding-bottom:7px;'>")
                else
             %>
            <h3>International Protocol (IP) Country Request</h3>
            <h4 class="countryh3"><%= Session("stp_companyname") %></h4>
            <%
                end if
            %>
        </div>
    </div>
    <hr />
    <div id="feedback_to_user" class="bg-warning text-warning"></div>
    <%  'SQL to get the IPGuideRequestRecord by the userid
        dim SQL
        dim UserID
        'UserID = 412 'for developing only, should be commented and use the next line when released.
        UserID = Session("stp_userid")
        SQL = "select " &_
            "ipclient.clientname client, ipclient.id clientid, ipclient.contact_firstname contact,ipclient.contact_lastname contact2,ipclient.rep rep, " &_
            "ipclient.contact_number contact_number,isnull(record_number,0) ip_request, ipclient.client_type ctype " &_
            "from IPGuideRequestClient ipClient " &_
            "left join(" &_
	        "select client_id, count(*) record_number from " &_
	        "IPGuideRequestRecord " &_
            "where iptype=? " &_
            "group by client_id " &_
            ") ipRecord " &_
            "on " &_
	        "ipClient.id=ipRecord.client_id " '&_
            '"where	ipClient.rep = " &_
            '"(select rep from ipGuideRep rep " &_
            '"where rep.UserID =" & UserID & ") "
        
        dim ipSQL, iptype
        ipSQL = "select row_number() over (order by client) as noo," &_
                                "client, clientid, contact, contact2,ip_request ,rep " &_
                                "from (" & SQL &_
                                ") ct " 
        iptype = Request.QueryString("iptype")
        if len(iptype) = 0 then
            iptype = "IPs" 'default value
        end if
    %>

    <ul class="nav nav-pills">
      <li class="active"><a class="btn btn-primary" data-toggle="pill" href="#IPs">IPs</a></li>
      <li><a  class="btn btn-primary" data-toggle="pill" href="#Reg">REG Tracking</a></li>
      <li><a  class="btn btn-primary" data-toggle="pill" href="#Mining">Mining</a></li>
      <li><a  class="btn btn-primary" data-toggle="pill" href="#ISO">ISO</a></li>
      <li><a  class="btn btn-primary" data-toggle="pill" href="#Convergence">Convergence</a></li>
    </ul>

    <div class="tab-content" data-ipactive="<%= iptype %>">        
        <div class="control-group">
                <div class="controls control-row">
                    <div class="span1 offset7">
                        <a href="search.asp?iptype=<%= iptype %>" class="btn" id="searchBtn">Search</a> 
                    </div>
                     <div class="span1">
                        <a href="report.asp?iptype=<%= iptype %>" class="btn" id="reportBtn">Report</a> 
                    </div>
                    <div class="span1">
                        <a href="add.asp?iptype=<%= iptype %>" class="btn" id="addBtn">Add</a> 
                    </div>               
                </div> 
        </div><br /><br />        
        
        <div id="IPs" class="tab-pane fade in active" data-userid="<%=UserID%>">       
            <table  id="ip" class="display" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th class="clientsort">Client</th>
                        <th>Contact</th>
                        <th>Contact 2</th>
                        <th>REP</th>
                        <th>IP Request</th>                   
                    </tr>
                </thead>
                <tbody id="ipTable">
                    <%
                        iptype = "IPs"                        
                        Set sqlcmd = Server.CreateObject("ADODB.command") 
                           sqlcmd.ActiveConnection = conn                       
                           sqlcmd.CommandText = ipSQL 
                           sqlcmd.CommandType = adCmdText
                           sqlcmd.Prepared = true
                        set prm1 = sqlcmd.CreateParameter("@prm1",adVarChar,adParamInput,20, iptype)                       
                        sqlcmd.Parameters.Append prm1
                        'response.Write sqlcmd.CommandText
                        set rs = server.CreateObject("ADODB.Recordset")
                        set rs = sqlcmd.Execute()
                        
                        While Not rs.EOF                                                   
                    %>
                    <tr>
                        <td class="col-md-1"><%=rs("noo")%></td>
                        <td class="col-md-3 client"><%=rs("client")%></td>
                        <td class="col-md-2"><%=rs("contact")%></td>
                        <td class="col-md-2"><%=rs("contact2")%></td>
                        <td class="col-md-2"><%=rs("rep")%> </td>                    
                        <td class="col-md-2">                                                        
                            <a href="#" data-client="<%=rs("clientid")%>" class="EditIPGuideRecord"><%= rs("ip_request") %></a>                            
                        </td>
                    </tr>
                    <% 
                        rs.MoveNext
                        Wend 
                    %>
                </tbody>
            </table>
             <div class="col-md-12 text-center">
                <ul class="pagination pagination-sm" id="ipPager"></ul>
            </div>  
        </div>
        <div id="Reg" class="tab-pane fade" data-userid="<%=UserID%>">       
            <table  id="reg" class="display">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th class="clientsort">Client</th>
                        <th>Contact</th>
                        <th>Contact 2</th>
                        <th>REP</th>
                        <th>REG Tracking</th>                   
                    </tr>
                </thead>
                <tbody id="regTable">
                    <%
                        iptype = "reg"                        
                        Set sqlcmd = Server.CreateObject("ADODB.command") 
                           sqlcmd.ActiveConnection = conn                       
                           sqlcmd.CommandText = ipSQL 
                           sqlcmd.CommandType = adCmdText
                           sqlcmd.Prepared = true
                        set prm1 = sqlcmd.CreateParameter("@prm1",adVarChar,adParamInput,20, iptype)                       
                        sqlcmd.Parameters.Append prm1
                        'response.Write sqlcmd.CommandText
                        set rs = server.CreateObject("ADODB.Recordset")
                        set rs = sqlcmd.Execute()
                        
                        While Not rs.EOF                                                   
                    %>
                    <tr>
                         <td class="col-md-1"><%=rs("noo")%></td>
                        <td class="col-md-3 client"><%=rs("client")%></td>
                        <td class="col-md-2"><%=rs("contact")%></td>
                        <td class="col-md-2"><%=rs("contact2")%></td>
                        <td class="col-md-2"><%=rs("rep")%> </td>                    
                        <td class="col-md-2">                              
                            <a href="#" data-client="<%=rs("clientid")%>" class="EditREGTracking" ><%= rs("ip_request") %></a>                            
                        </td>
                    </tr>
                    <% 
                        rs.MoveNext
                        Wend 
                    %>
                </tbody>
            </table>
             <div class="col-md-12 text-center">
                <ul class="pagination pagination-sm" id="regPager"></ul>
            </div>  
        </div>
        <div id="Mining" class="tab-pane fade"  data-userid="<%=UserID%>">
            <table  id="mining" class="display">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th class="clientsort">Client</th>
                        <th>Contact</th>
                        <th>Contact 2</th>
                        <th>REP</th>
                        <!--<th style="text-align: center">Contact number</th>-->
                        <th>IP Request</th>                   
                    </tr>
                </thead>
                <tbody id="miningTable">
                    <%  
                        iptype = "Mining"   
                        Set sqlcmd = Server.CreateObject("ADODB.command") 
                           sqlcmd.ActiveConnection = conn                       
                           sqlcmd.CommandText = ipSQL 
                           sqlcmd.CommandType = adCmdText
                           sqlcmd.Prepared = true
                         set prm1 = sqlcmd.CreateParameter("@prm1",adVarChar,adParamInput,20, iptype)                       
                        sqlcmd.Parameters.Append prm1
                        
                        'response.Write sqlcmd.CommandText
                        set rs = server.CreateObject("ADODB.Recordset")
                        set rs = sqlcmd.Execute()
                        
                        While Not rs.EOF                                                    
                    %>
                    <tr>
                        <td class="col-md-1"><%=rs("noo")%></td>
                        <td class="col-md-3 client"><%=rs("client")%></td>
                        <td class="col-md-2"><%=rs("contact")%></td>
                        <td class="col-md-2"><%=rs("contact2")%></td>
                        <td class="col-md-2"><%=rs("rep")%> </td>
                    
                        <td class="col-md-2">                                                        
                            <a href="#" data-client="<%=rs("clientid")%>" class="EditIPGuideRecord"><%= rs("ip_request") %></a>                            
                        </td>
                    </tr>
                    <% 
                        rs.MoveNext
                        Wend 
                    %>
                </tbody>
            </table>
           <div class="col-md-12 text-center">
                <ul class="pagination pagination-sm" id="miningPager"></ul>
            </div>  
        </div>
       
        <div id="ISO" class="tab-pane fade">
            <table  id="iso" class="display">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th class="clientsort">Client</th>
                        <th>Contact</th>
                        <th>Contact 2</th>
                        <th>REP</th>
                        <!--<th style="text-align: center">Contact number</th>-->
                        <th>IP Request</th>                   
                    </tr>
                </thead>
                <tbody id="isoTable">
                    <%  
                        iptype = "ISO"   
                        Set sqlcmd = Server.CreateObject("ADODB.command") 
                           sqlcmd.ActiveConnection = conn                       
                           sqlcmd.CommandText = ipSQL 
                           sqlcmd.CommandType = adCmdText
                           sqlcmd.Prepared = true
                         set prm1 = sqlcmd.CreateParameter("@prm1",adVarChar,adParamInput,20, iptype)                       
                        sqlcmd.Parameters.Append prm1
                        
                        'response.Write sqlcmd.CommandText
                        set rs = server.CreateObject("ADODB.Recordset")
                        set rs = sqlcmd.Execute()
                        
                        While Not rs.EOF
                    %>
                    <tr>
                        <td class="col-md-1"><%=rs("noo")%></td>
                        <td class="col-md-3 client"><%=rs("client")%></td>
                        <td class="col-md-2"><%=rs("contact")%></td>
                        <td class="col-md-2"><%=rs("contact2")%></td>
                        <td class="col-md-2"><%=rs("rep")%> </td>
                    
                        <td class="col-md-2">                                                        
                            <a href="#" data-client="<%=rs("clientid")%>" class="EditIPGuideRecord"><%= rs("ip_request") %></a>                            
                        </td>
                    </tr>
                    <% 
                        rs.MoveNext
                        Wend 
                    %>
                </tbody>
            </table>
           <div class="col-md-12 text-center">
                <ul class="pagination pagination-sm" id="isoPager"></ul>
            </div>  
        </div>
        <div id="Convergence" class="tab-pane fade">
               <table  id="convergence" class="display">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th class="clientsort">Client</th>
                        <th>Contact</th>
                        <th>Contact 2</th>
                        <th>REP</th>
                        <!--<th style="text-align: center">Contact number</th>-->
                        <th>IP Request</th>                   
                    </tr>
                </thead>
                <tbody id="convergenceTable">
                    <%  
                        iptype = "Convergence"   
                        Set sqlcmd = Server.CreateObject("ADODB.command") 
                           sqlcmd.ActiveConnection = conn                       
                           sqlcmd.CommandText = ipSQL 
                           sqlcmd.CommandType = adCmdText
                           sqlcmd.Prepared = true
                         set prm1 = sqlcmd.CreateParameter("@prm1",adVarChar,adParamInput,20, iptype)                       
                        sqlcmd.Parameters.Append prm1
                        
                        'response.Write sqlcmd.CommandText
                        set rs = server.CreateObject("ADODB.Recordset")
                        set rs = sqlcmd.Execute()
                        
                        While Not rs.EOF                                                   
                    %>
                    <tr>
                        <td class="col-md-1"><%=rs("noo")%></td>
                        <td class="col-md-3 client"><%=rs("client")%></td>
                        <td class="col-md-2"><%=rs("contact")%></td>
                        <td class="col-md-2"><%=rs("contact2")%></td>
                        <td class="col-md-2"><%=rs("rep")%> </td>
                    
                        <td class="col-md-2">                                                        
                            <a href="#" data-client="<%=rs("clientid")%>" class="EditConvergence"><%= rs("ip_request") %></a>                            
                        </td>
                    </tr>
                    <% 
                        rs.MoveNext
                        Wend 
                    %>
                </tbody>
            </table>
           <div class="col-md-12 text-center">
                <ul class="pagination pagination-sm" id="convergencePager"></ul>
            </div>  
        </div>
        <div id="warn-message" class="dialog-message" title="Failed to delete">
          <p>
            <span class="ui-icon ui-icon-circle-close" style="float:left; margin:0 7px 50px 0;"></span>
           <span id="fail"></span>
          </p>
        </div>
        <div id="success-message" class="dialog-message" title="Deleted!">
          <p>
            <span class="ui-icon ui-icon-check" style="float:left; margin:0 7px 50px 0;"></span>
            <span id="success"></span>
          </p>
        </div>
    </div>
     
</div>
<div id="delete-client" title="Delete the client?">
  <p><span class="ui-icon ui-icon-alert" style="float:left; margin:12px 12px 20px 0;"></span><span style="color:blue;font-weight:bold" id="clientname"></span> will be permanently deleted and cannot be recovered. Are you sure?</p>
</div>
<div id="dialog-form" title="Edit Contact & REP">
  <p class="validateTips">Only contact and rep can be edited.</p>
 
  <form>
    <fieldset>
       <table  class="usertable table">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Client</th>
                        <th>Contact</th>
                        <th>Contact 2</th>
                        <th>REP</th>                                         
                    </tr>
                </thead>
                <tbody>                    
                    <tr >
                        <td></td>
                        <td data-clientid=""></td>
                        <td><input data-focus="" id="input_contact" name="contact" type="text"/></td>
                        <td><input id="input_contact2" name="contact2" type="text"/></td>
                        <td><input id="input_rep" name="rep" type="text" /></td>                    
                    </tr>
                </tbody>
           </table>
        
      <!-- Allow form submission with keyboard without duplicating the dialog button -->
      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    </fieldset>
  </form>
</div>
<div class="loadmodal"><!-- Place at bottom of page --></div>
<!-- /container -->
<!-- #include virtual=/assets/lib/footer.asp -->
<%
    set cmd = nothing
    checkSession.Close
    conn.Close
    set checkSession = nothing
    set conn = nothing
%>

<script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        var userid = $("#IPs").attr("data-userid");
        var data;
        var activeTabName = $('.tab-content').attr("data-ipactive");
        activeTab(activeTabName);

        if (userid == 8622) { // Sasha was authroized to delete companies
            $('td.client').css('cursor', 'pointer')
        }

        $.get("checkRep.asp?userid=" + userid) // to check if the use has a Rep number
          .fail(function () {
              alert("Serve error. Please contact IT Department or try again.");
          })
        .done(function (data) {
            if (data != 0) {
                $('#feedback_to_user').html(data + "<hr>");               
            }
        });

        $('#ip, #reg, #mining, #iso, #convergence').DataTable({
            "order": [[1, "asc"]],
            "bPaginate": true,
            "dom": 'ftipr',
            "bFilter": true,
            "iDisplayLength": 12,
            "language": {"search": "Filter records:"}
        });       

        $("#delete-client").dialog({
            autoOpen: false,
            resizable: false,
            height: "auto",
            width: 400,
            modal: true,
            buttons: {
                "Delete": deleteClient,
                Cancel: function () {
                    $(this).dialog("close");
                }
            }
        });

        

        $body = $("body");
        $(document).on({
            ajaxStart: function () { $body.addClass("loading"); },
            ajaxStop: function () { $body.removeClass("loading"); }
        });

        $(".dialog-message").dialog({
            autoOpen: false,
            modal: true,
            buttons: {
                Ok: function () {
                    $(this).dialog("close");
                    // refresh page
                    window.location.replace("index.asp?iptype=" + activeTabName);
                }
            }
        });

       

        //form = dia.find("form").on("submit", function (event) {
        //    event.preventDefault();
        //    updateContact();
        //});
       
        // click on the 'Client' column in the table, pop up a dialog to delete the Client
        $('td.client').click(function () {
            if (userid == 8622) {  // Sasha was authroized to delete companies
                var client = $(this).text();
                var clientid = $(this).next().next().next().next().children('a').attr("data-client");           

                $('#delete-client').find('#clientname').html(client);
                $('#delete-client').find('#clientname').data('clientid', clientid);
                dia_delete.dialog("open");
            }
        });

        // click on the 'Contact' column in the table, pop up a dialog to edit Contact & Rep
        $('tr td.col-md-2:nth-child(3)').click(function () {
            var id = $(this).prev().prev().text();
            var ipType = $('.tab-content').attr("data-ipactive");
            var client = $(this).prev().text();
            var clientid = $(this).next().next().next().children('a').attr("data-client");
            var contact = $(this).text();
            var contact2 = $(this).next().text();
            var rep = $(this).next().next().text();
            
            $('#dialog-form').find('td:first-child').html(id);
            $('#dialog-form').find('td:nth-child(2)').html(client);
            $('#dialog-form').find('td:nth-child(2)').attr("data-clientid", clientid);
            $('#input_contact').data('focus', 1);
            $('#dialog-form').find('#input_rep').val(rep);
            $('#dialog-form').find('#input_contact').val(contact);
            $('#dialog-form').find('#input_contact2').val(contact2);
            dia.dialog("open");
        });

        // click on the 'Contact2' column in the table
        $('tr td.col-md-2:nth-child(4)').click(function () {
            var id = $(this).prev().prev().prev().text();
            var ipType = $('.tab-content').attr("data-ipactive");
            var client = $(this).prev().prev().text();
            var clientid = $(this).next().next().children('a').attr("data-client");
            var contact2 = $(this).text();
            var contact = $(this).prev().text();
            var rep = $(this).next().text();

            $('#dialog-form').find('td:first-child').html(id);
            $('#dialog-form').find('td:nth-child(2)').html(client);
            $('#dialog-form').find('td:nth-child(2)').attr("data-clientid", clientid);
            $('#input_contact').data('focus', 2);
            $('#dialog-form').find('#input_rep').val(rep);
            $('#dialog-form').find('#input_contact').val(contact);
            $('#dialog-form').find('#input_contact2').val(contact2);
            dia.dialog("open");
        });

        // click on the 'Rep' column in the table
        $('tr td.col-md-2:nth-child(5)').click(function () {
            //alert("hhhh");
            var id = $(this).prev().prev().prev().prev().text();
            var ipType = $('.tab-content').attr("data-ipactive");
            var client = $(this).prev().prev().prev().text();
            var clientid = $(this).next().children('a').attr("data-client");
            var contact = $(this).prev().prev().text().trim();
            var contact2 = $(this).prev().text().trim();
            var rep = $(this).text().trim();
           
            $('#dialog-form').find('td:first-child').html(id);
            $('#dialog-form').find('td:nth-child(2)').html(client);
            $('#dialog-form').find('td:nth-child(2)').attr("data-clientid", clientid);
            $('#input_contact').data('focus', 3);
            $('#dialog-form').find('#input_rep').val(rep);
            $('#dialog-form').find('#input_contact').val(contact);
            $('#dialog-form').find('#input_contact2').val(contact2);
            //alert("id=" + id + ", rep = " + rep);
            dia.dialog("open");
        });

    });

   
   

    $(document).on("click", "a.EditIPGuideRecord", function (e) {
        e.preventDefault();
        var client = $(this).data("client");
        var iptype = $('.tab-content').attr("data-ipactive");
        //alert("iptype is : " + iptype);
        $this = $(this);
        //alert("iptype: " + iptype + ", client: " + client);
        $.get("editIPGuideRecord.asp?client=" + client + "&iptype=" + iptype, function (data) {
            var div = bootbox.dialog(data,
                    [{
                        "label": "<i class='icon-zoom-in'></i> Close",
                        "class": "btn-small btn-info no-border",
                        "callback": function () {
                            // update the ip request dropdown list after editing
                            $.get("FetchIPGuideList.asp?client=" + client + "&iptype=" + iptype, function (da) {
                                $this.parent().parent().find('a').html(da);
                            });
                        }
                    }]);
            if (iptype == "IPs"){
                var oTable = $('#ipguidetable').DataTable({
                    "scrollY": "320px",
                    "order": [[2, "desc"]],
                    "scrollCollapse": true,                
                    "paging": false,
                });               
            }
            else {
                var oTable = $('#ipguidetable').DataTable({
                    "scrollY": "320px",
                    "order": [[1, "desc"]],
                    "scrollCollapse": true,
                    "paging": false,
                });
            }
            setTimeout(function () {
                $('#ipguidetable').DataTable().search('').draw();
            }, 200);
        });  
    });

    $(document).on("click", "a.EditConvergence", function (e) {
        e.preventDefault();
        var client = $(this).data("client");
        var iptype = 'Convergence';
        $this = $(this);
        //alert("iptype: " + iptype + ", client: " + client);
        $.get("editConvergence.asp?client=" + client + "&iptype=" + iptype, function (data) {
            var div = bootbox.dialog(data,
                    [{
                        "label": "<i class='icon-zoom-in'></i> Close",
                        "class": "btn-small btn-info no-border",
                        "callback": function () {
                            // update the ip request dropdown list after editing
                            $.get("FetchIPGuideList.asp?client=" + client + "&iptype=" + iptype, function (da) {
                                $this.parent().parent().find('a').html(da);
                            });
                        }
                    }]);
        });
    });

    $(document).on("click", "a.EditREGTracking", function (e) {
        e.preventDefault();
        var client = $(this).data("client");
        var iptype = 'reg';
        $this = $(this);
        $.get("EditREGTracking.asp?client=" + client, function (data) {
            var div = bootbox.dialog(data,
                    [{
                        "label": "<i class='icon-zoom-in'></i> Close",
                        "class": "btn-small btn-info no-border",
                        "callback": function () {                            
                            $.get("FetchIPGuideList.asp?client=" + client + "&iptype=" + iptype, function (da) {
                                //alert("return: " + da);
                                $this.parent().parent().find('a').html(da);
                            });
                        }
                    }],
                    {
                        "onEscape": function () { div.modal("hide"); }
                    });
        });
    });
        // when tab changed, set search button's link attribute.
        $('a[data-toggle="pill"]').on('shown.bs.tab', function (e) {
            var target = $(e.target).attr("href") // activated tab  
           $('#searchBtn').attr("href", "search.asp?iptype=" + target.substring(1)); // skip the '#'
            $('#addBtn').attr("href", "add.asp?iptype=" + target.substring(1)); // skip the '#'
            $('#reportBtn').attr("href", "report.asp?iptype=" + target.substring(1)); // skip the '#'           
            $('.tab-content').attr("data-ipactive", target.substring(1));
           // alert("tab changed to: " + target.substring(1));
        });

        function activeTab(tab) {
            $('.nav-pills a[href="#' + tab + '"]').tab('show');
        }

        var dia, dia_delete;

        dia = $("#dialog-form").dialog({
            autoOpen: false,
            height: 300,
            width: 850,
            modal: true,
            closeOnEscape: true,
            open: function () {
                var focus_on_contact = $('#input_contact').data('focus');
                if (focus_on_contact == 1)
                    $('#dialog-form').find('#input_contact').focus();
                else if (focus_on_contact == 2)
                    $('#dialog-form').find('#input_contact2').focus();
                else
                    $('#dialog-form').find('#input_rep').focus();
            },
            buttons: {
                "Save": updateContact,
                Cancel: function () {
                    dia.dialog("close");
                }
            },
            close: function () {
                // form[0].reset();
                //allFields.removeClass("ui-state-error");
            }
        });

        dia_delete = $("#delete-client").dialog({
            autoOpen: false,
            height: 300,
            width: 850,
            modal: true,
            closeOnEscape: true,
            buttons: {
                "Delete": deleteClient,
                Cancel: function () {
                    dia.dialog("close");
                }
            },
            close: function () {
                // form[0].reset();
                //allFields.removeClass("ui-state-error");
            }
        });

        function deleteClient() {
            var clientid = $('#delete-client').find('#clientname').data('clientid');
            $.ajax({
                url: "DelClientData.asp",
                type: "POST",
                data: { "clientid": clientid },
                error: function (xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert(err.Message);
                },
                success: function (dataFromServer) {
                    if (dataFromServer.indexOf("Error") == -1) {
                        $('a[data-client="' + clientid + '"]').parent().parent().remove();                       
                    }
                    else {                       
                        alert(dataFromServer);
                    }
                }
            })
            dia_delete.dialog("close");
        }

       

        function updateContact() {
            var clientid = $('#dialog-form').find('td:nth-child(2)').attr("data-clientid");
            var contact = $('#input_contact').val().trim();
            var contact2 = $('#input_contact2').val().trim();
            var rep = $('#input_rep').val().trim();
            var rowid = $('#dialog-form').find('td:first-child').html();
            
            $.ajax({
                url: "UpdateContact.asp",
                type: "POST",
                data: { clientid: clientid, contact: contact, contact2: contact2, rep: rep },
                error: function (xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert(err.Message);
                },
                success: function (dataFromServer) {
                    if (dataFromServer.indexOf("Error") == -1) {

                        var updateItem = $('div.tab-pane table tbody tr td:first-child').filter(function () {
                            return $(this).text() === rowid;
                        });
                        updateItem.next().next().html(contact);
                        updateItem.next().next().next().html(contact2);
                        updateItem.next().next().next().next().html(rep);
                    }
                    else {
                        alert("update faild");
                    }
                }
            })
            dia.dialog("close");
        }
</script>

</body>
</html>