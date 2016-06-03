<%@  language="VBScript" %>
<!-- #include virtual=/assets/lib/utils.asp -->
<!-- #include virtual=/assets/lib/header2.asp -->
<!--#include virtual="/adovbs.inc"-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
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

    <%  'SQL to get the IPGuideRequestRecord by the userid
        dim SQL
        dim UserID
        'UserID = 438 'for developing only, should be commented and use the next line when released.
        UserID = Session("stp_userid")
        SQL = "select " &_
            "ipclient.clientname client, ipclient.id clientid, ipclient.contact_firstname contact, " &_
            "ipclient.contact_number contact_number,isnull(record_number,0) ip_request, ipclient.client_type ctype " &_
            "from IPGuideRequestClient ipClient " &_
            "left join(" &_
	        "select client_id, count(*) record_number from " &_
	        "IPGuideRequestRecord " &_
            "where iptype=? " &_
            "group by client_id " &_
            ") ipRecord " &_
            "on " &_
	        "ipClient.id=ipRecord.client_id " &_
            "where	ipClient.rep = " &_
            "(select rep from ipGuideRep rep " &_
            "where rep.UserID =" & UserID & ") "
        
        dim ipSQL, iptype
        ipSQL = "select row_number() over (order by client) as noo," &_
                                "client, clientid, contact, contact_number,ip_request " &_
                                "from (" & SQL &_
                                ") ct " 
        Set sqlcmd = Server.CreateObject("ADODB.command") 
           sqlcmd.ActiveConnection = conn                       
           sqlcmd.CommandText = ipSQL 
           sqlcmd.CommandType = adCmdText
           sqlcmd.Prepared = true
       
    %>

    <ul class="nav nav-pills">
      <li class="active"><a data-toggle="pill" href="#ips">IP's</a></li>
      <li><a data-toggle="pill" href="#mining">Mining</a></li>
      <li><a data-toggle="pill" href="#iso">ISO</a></li>
      <li><a data-toggle="pill" href="#convergence">Convergence</a></li>
    </ul>

    <div class="tab-content">
        <div id="ips" class="tab-pane fade in active" data-userid="<%=UserID%>">       
            <div class="control-group">
                <div class="controls control-row">
                    <div class="span1 offset7">
                        <a href="search.asp" class="btn">Search</a> 
                    </div>
                     <div class="span1">
                        <a href="report.asp" class="btn">Report</a> 
                    </div>
                    <div class="span1">
                        <a href="add.asp" class="btn">Add</a> 
                    </div>               
                </div> 
            </div><br /><br />  
            <div id="feedback_to_user" class="bg-warning text-warning"></div>                
            <table  class="usertable table table-striped table-hover table-responsive">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th class="clientsort">Client</th>
                        <th>Contact</th>
                        <!--<th style="text-align: center">Contact number</th>-->
                        <th>IP request</th>                   
                    </tr>
                </thead>
                <tbody class="myTable">
                    <%
                         iptype = "IP's"                        
                        set prm1 = sqlcmd.CreateParameter("@prm1",adVarChar,adParamInput,20, iptype)                       
                        sqlcmd.Parameters.Append prm1
                        'response.Write sqlcmd.CommandText
                        set rs = server.CreateObject("ADODB.Recordset")
                        set rs = sqlcmd.Execute()
                        
                        While Not rs.EOF                        
                            if rs("ip_request") > 0 then 'if there is a ip request, make the background color of this row blue
                               trclass="class='info'"
                            else
                                trclass=""
                            end if
                    %>
                    <tr <%=trclass %>>
                        <td><%=rs("noo")%></td>
                        <td><%=rs("client")%></td>
                        <td><%=rs("contact")%></td>
                        <!--<td><%=rs("contact_number")%> </td>-->
                    
                        <td>
                            <select class="selectpicker" data-iptype="ip''s" 
                                data-clientid="<%=rs("clientid")%>" 
                                data-req_num="<%= rs("ip_request") %>" 
                                <% 
                                    if rs("ip_request") = 0 then
                                          Response.Write "disabled"
                                    end if  
                                %>
                             >
                              <option><%=rs("ip_request")%></option>                          
                            </select>&nbsp;
                            <a href="#" data-client="<%=rs("clientid")%>" data-iptype="ip''s" class="EditIPGuideRecord">Edit</a>
                            <a href="#" data-client="<%=rs("clientid")%>" data-iptype="ip''s" class="deleteClient">Delete client</a>
                            <div id="<%=rs("clientid")%>" title="Delete the Client?" class="dialog-confirm" >
                                <p>
                                    <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
                                    This item will be permanently deleted and cannot be recovered. Are you sure?
                                </p>
                            </div>
                            <div class="CustomerDetails"></div>
                        </td>
                    </tr>
                    <% 
                        rs.MoveNext
                        Wend 
                    %>
                </tbody>
            </table>
            
        </div>
        <div id="mining" class="tab-pane fade">
                <div class="control-group">
                <div class="controls control-row">
                    <div class="span1 offset7">
                        <a href="search.asp" class="btn">Search</a> 
                    </div>
                     <div class="span1">
                        <a href="report.asp" class="btn">Report</a> 
                    </div>
                    <div class="span1">
                        <a href="add.asp" class="btn">Add</a> 
                    </div>               
                </div> 
            </div><br /><br />  
            <div  class="bg-warning text-warning feedback_to_user"></div>                
            <table  class="usertable table table-striped table-hover table-responsive">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th class="clientsort">Client</th>
                        <th>Contact</th>
                        <!--<th style="text-align: center">Contact number</th>-->
                        <th>IP request</th>                   
                    </tr>
                </thead>
                <tbody class="myTable">
                    <%
                        
                        iptype = "Mining"
                        
                        prm1 = sqlcmd.CreateParameter("@prm1",adVarChar,adParamInput,20, iptype)
                       
                        sqlcmd.Parameters.Append prm1
                        'response.Write sqlcmd.CommandText
                        set rs = server.CreateObject("ADODB.Recordset")
                        set rs = sqlcmd.Execute()
                        
                        While Not rs.EOF                        
                            if rs("ip_request") > 0 then 'if there is a ip request, make the background color of this row blue
                               trclass="class=""info"""
                            else
                                trclass=""
                            end if
                    %>
                    <tr <%=trclass %>>
                        <td><%=rs("noo")%></td>
                        <td><%=rs("client")%></td>
                        <td><%=rs("contact")%></td>
                        <!--<td><%=rs("contact_number")%> </td>-->
                    
                        <td>
                            <select class="selectpicker" data-iptype="ip''s" 
                                data-clientid="<%=rs("clientid")%>" 
                                data-req_num="<%= rs("ip_request") %>" 
                                <% 
                                    if rs("ip_request") = 0 then
                                          Response.Write "disabled"
                                    end if  
                                %>
                             >
                              <option><%=rs("ip_request")%></option>                          
                            </select>&nbsp;
                            <a href="#" data-client="<%=rs("clientid")%>" data-iptype="ip''s" class="EditIPGuideRecord">Edit</a>
                            <a href="#" data-client="<%=rs("clientid")%>" data-iptype="ip''s" class="deleteClient">Delete client</a>
                            <div id="<%=rs("clientid")%>" title="Delete the Client?" class="dialog-confirm" >
                                <p>
                                    <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
                                    This item will be permanently deleted and cannot be recovered. Are you sure?
                                </p>
                            </div>
                            <div class="CustomerDetails"></div>
                        </td>
                    </tr>
                    <% 
                        rs.MoveNext
                        Wend 
                    %>
                </tbody>
            </table>
           
        </div>
        </div>
        <div id="iso" class="tab-pane fade">
                <h3>ISO</h3>
                <h4>In constructing...</h4>
        
        </div>
        <div id="convergence" class="tab-pane fade">
                <h3>Convergence</h3>
                  <h4>In constructing...</h4>
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
    <div class="col-md-12 text-center">
                <ul class="pagination pagination-sm" id="myPager"></ul>
    </div>
    
</div>
<!-- /container -->
<!-- #include virtual=/assets/lib/footer.asp -->
<%
    set cmd = nothing
    checkSession.Close
    conn.Close
    set checkSession = nothing
    set conn = nothing
%>
<script type="text/javascript">
    $(document).ready(function () {
        var userid = $('#ips').attr("data-userid");
        var data;

        $.get("checkRep.asp?userid=" + userid) // to check if the use has a Rep number
          .fail(function () {
              alert("Serve error. Please contact IT Department or try again.");
          })
        .done(function (data) {
            console.log(data);
            if (data != 0) {
                $('#feedback_to_user').html(data);               
            }
        });

        $('.myTable').pageMe({
            pagerSelector: '#myPager', showPrevNext: true, hidePageNumbers: false, perPage: 10
        });
        
        $(".deleteClient").click(
            function () {
                $('#' + $(this).attr("data-client")).dialog('open');
                return false;
            }
        );

        $(".dialog-confirm").dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            buttons: {
                Cancel: function () {
                    $(this).dialog("close");
                },
                "Delete": function () {
                    $this = $(this);
                    var client = $this.attr("id");
                    $this.dialog("close");
                    $.ajax({
                        url: "DelClientData.asp",
                        type: "POST",
                        data: { "client": client },
                        error: function (xhr, status, error) {
                            var err = eval("(" + xhr.responseText + ")");
                            alert(err.Message);
                        },
                        success: function (dataFromServer) {
                            if (dataFromServer.indexOf("Error") == -1) {
                                $('#success').html(dataFromServer);
                                $('#success-message').dialog('open');
                            }
                            else {
                                $('#fail').html(dataFromServer);
                                $('#warn-message').dialog('open');
                            }
                        }
                    })
                }
            }
        });

        $(".dialog-message").dialog({
            autoOpen: false,
            modal: true,
            buttons: {
                Ok: function () {
                    $(this).dialog("close");
                    // refresh page
                   window.location.replace("index.asp");
                }
            }
        });
    });

    $.fn.pageMe = function (opts) {
        var $this = this,
            defaults = {
                perPage: 7,
                showPrevNext: false,
                hidePageNumbers: false
            },
            settings = $.extend(defaults, opts);

        var listElement = $this;
        var perPage = settings.perPage;
        var children = listElement.children();
        var pager = $('.pager');

        if (typeof settings.childSelector != "undefined") {
            children = listElement.find(settings.childSelector);
        }

        if (typeof settings.pagerSelector != "undefined") {
            pager = $(settings.pagerSelector);
        }

        var numItems = children.size();
        var numPages = Math.ceil(numItems / perPage);

        pager.data("curr", 0);

        if (settings.showPrevNext) {
            $('<li><a href="#" class="prev_link"><<</a></li>').appendTo(pager);
        }

        var curr = 0;
        while (numPages > curr && (settings.hidePageNumbers == false)) {
            $('<li><a href="#" class="page_link">' + (curr + 1) + '</a></li>').appendTo(pager);
            curr++;
        }

        if (settings.showPrevNext) {
            $('<li><a href="#" class="next_link">>></a></li>').appendTo(pager);
        }

        pager.find('.page_link:first').addClass('active');
        pager.find('.prev_link').hide();
        if (numPages <= 1) {
            pager.find('.next_link').hide();
        }
        pager.children().eq(1).addClass("active");

        children.hide();
        children.slice(0, perPage).show();

        pager.find('li .page_link').click(function () {
            var clickedPage = $(this).html().valueOf() - 1;
            goTo(clickedPage, perPage);
            return false;
        });
        pager.find('li .prev_link').click(function () {
            previous();
            return false;
        });
        pager.find('li .next_link').click(function () {
            next();
            return false;
        });

        function previous() {
            var goToPage = parseInt(pager.data("curr")) - 1;
            goTo(goToPage);
        }

        function next() {
            goToPage = parseInt(pager.data("curr")) + 1;
            goTo(goToPage);
        }

        function goTo(page) {
            var startAt = page * perPage,
                endOn = startAt + perPage;

            children.css('display', 'none').slice(startAt, endOn).show();

            if (page >= 1) {
                pager.find('.prev_link').show();
            }
            else {
                pager.find('.prev_link').hide();
            }

            if (page < (numPages - 1)) {
                pager.find('.next_link').show();
            }
            else {
                pager.find('.next_link').hide();
            }

            pager.data("curr", page);
            pager.children().removeClass("active");
            pager.children().eq(page + 1).addClass("active");
        }
    };
    
    $('.selectpicker').click(function (e) { // when click the dropdown list, populate it with the ipname that the client had recorded.
        e.preventDefault();
        var $this = $(this);
        var req_num = $this.attr("data-req_num");
        var client_id = $this.attr("data-clientid");
        var ip_type = $this.attr("data-iptype")
        if (req_num == 0) {
            $this.prop('disabled', 'disabled');
        } else {
            $.get(
                        "FetchIPGuideList.asp?client_id=" + client_id + "&ip_type=" + ip_type + "&req_num=" + req_num,
                        function (data) {
                            $this.html(data);
                            $this.simulate('mousedown');
                
                        });
                    $this.simulate('mousedown');
        }        
    });

    $(document).on("click", "a.EditIPGuideRecord", function (e) {
        e.preventDefault();
        var client = $(this).data("client");
        var iptype = $(this).data("iptype");
        $.get("editIPGuideRecord.asp?client=" + client + "&iptype=" + iptype, function (data) {
            var div = bootbox.dialog(data,
                    [{
                        "label": "<i class='icon-zoom-in'></i> Close",
                        "class": "btn-small btn-info no-border",
                        "callback": function () {
                            window.location.reload();
                        }
                    }],
                    {
                        "onEscape": function () { div.modal("hide"); }
                    });
        })
    });
</script>
<script src="/assets/js/jquery.simulate.js"></script>
</body>
</html>