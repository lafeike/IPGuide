<%@  language="VBScript" %>

<!--
    date: 2016-5-18
    author: Rafy Zhao
    description: 
        - when user clicks the 'Edit' button in the IPGuideRequest page, pop up a new window to enable the client to edit the IP request.
        - to be called by /IPGuideRequest/index.asp
-->

<!-- #include virtual=/assets/lib/utils.asp -->

<link rel="stylesheet" href="/assets/js/guidely/guidely.css" type="text/css">
<link rel="stylesheet" href="/assets/css/countryform.css" type="text/css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css" type="text/css" / >



<% 
    clientID = Request.QueryString("client")
    iptype = Request.QueryString("iptype")
    lastClient = ""
    
    strSQL = "select ip.ipName ipName, " &_
                "CASE WHEN (dual_language IS NULL) THEN 0 ELSE 1 END AS ipNumber, " &_
                "ip.id ip_id , ipcount.dual_language " &_
                "from ipguide ip " &_
                "left join ( " &_
                "select ip_id, dual_language " &_
                "from IPGuideRequestRecord " &_
                "where client_id=" & clientID &_            
                " and IPType='" & iptype &_
                "' ) ipcount " &_
                "on ip.id=ipcount.ip_id " &_
                "where ip.iptype='" & iptype & "'" &_
                " order by ipNumber desc, ipName"
    'response.Write(strSQL)
    set clientRS = conn.execute(strSQL)

    if  not (clientRS.EOF and clientRS.BOF)  then %>
        <div class="container2">        
            <% If (iptype = "IPs") Then %>
                <h4 style="text-align:center;"><strong>Edit IP Guide Request</strong></h4>
            <% ElseIf (iptype = "Mining") Then %>
                <h4 style="text-align:center;"><strong>Mining Request</strong></h4>
            <% ElseIf (iptype = "ISO") Then %>
                <h4 style="text-align:center;"><strong>ISO Request</strong></h4>
            <% End If %>
            
            
            <table class="display" id="ipguidetable" style="width:100%">              
                <thead>
                    <tr>
                        <% If (iptype = "ISO") Then %>
                            <th class="span6">ISO Standard</th>
                        <% Else %>
                            <th class="span6">IP Name</th>
                        <% End If %>
                        
                        <% If (iptype = "IPs") Then %>
                            <th class="span3">Dual Language</th>
                        <% End If %>
                       
                        <th class="span3">Confirm Request</th> 
                    </tr>
                </thead>
                <tbody>
                    
                    <% While Not clientRS.EOF %>
                    <tr>
                        <% If (lastClient <> clientRS("ipname")) Then %>
                            <td class="span6"><%=clientRS("ipname") %></td>
                        <% End If %>
                        <% If (iptype = "IPs") Then %>
                            <td class="span3">
                                 <input class="dualLanguage" type="checkbox"  name="<%= clientRS("ipname")  %>dual"
                                    <% if clientRS("dual_language")  then %> 
                                        checked >
                                    <%else %>
                                         >
                                    <% end if %>                
                            </td> 
                        <% End If %>                        
                        <td class="span3">  
                            <input class= "ipedit" type="checkbox" data-iptype="<%= iptype %>" data-clientID="<%= clientID %>" 
                                data-ipID="<%= clientRS("ip_id") %>" name="<%= clientRS("ipname")  %>"
                                <% if clientRS("ipNumber") = 0 then %> 
                                    />
                                <%else %>
                                    checked >
                                <% end if %> 
                        </td>                
                    </tr>
                    <%                          
                        lastClient = clientRS("ipname")
                        clientRS.MoveNext
                        wend
                    %>
                </tbody>
            </table>  
        </div>
    <% end if %>

    <script type="text/javascript">
        $(document).ready(function () {
           

            // when user click the checkbox in 'Confirm Request', call updateIPGuideRecord.asp to update the database.
            $('.ipedit').on('change', function (e) {                
                e.preventDefault();
                              
                var ip_name = $(this).attr("name");
                var ip_type = $(this).attr("data-iptype");
                var client_id = $(this).attr("data-clientID");
                var ip_id = $(this).attr("data-ipID");            
                var dualLanguage;
                
                if (!($(this).is(':checked'))) {
                    $(this).parent().parent().find('.dualLanguage').prop('checked', false);
                }

                if ($(this).parent().parent().find('.dualLanguage').is(':checked'))
                    dualLanguage = 1;
                else
                    dualLanguage = 0;
                
                var data = {
                    ip_name: ip_name,
                    client_id: client_id,
                    ip_type: ip_type,
                    ip_id: ip_id,
                    dual_language: dualLanguage
                };

                $.ajax({
                    type: 'post',
                    url: 'updateIPGuideRecord.asp',
                    data: data,
                    success: function (data) {                       
                    }
                });
            });                
        });

        // when user click the checkbox in 'Dual Language'
        // check if the checkbox in 'Dual Language' is checked.
        //      Yes: 
        //      No: 
       $('.dualLanguage').on('change', function(e) {       
            e.preventDefault();
          
            that = $(this).parent().parent().find('.ipedit');
            var client_id = that.attr("data-clientID");
            var ip_id = that.attr("data-ipID");
            var ip_name = that.attr("name");
            var ip_type = that.attr("data-iptype");

            if ($(this).is(':checked')) {            
                that.prop('checked', true);

                var data = {
                    ip_name: ip_name,
                    client_id: client_id,
                    ip_type: ip_type,
                    ip_id: ip_id,
                    dual_language: 1
                };
               
                $.ajax({
                    type: 'post',
                    url: 'updateIPGuideRecord.asp',
                    data: data,
                    success: function (data) {
                    }
                });                
            }                
            else {
                var data = {
                    client_id: client_id,
                    ip_id: ip_id,
                    dual_language: 0
                };

                $.ajax({
                    type: 'post',
                    url: 'updateDualLanguage.asp',
                    data: data,
                    success: function (data) {
                    }
                });
            }
        });
    </script>
