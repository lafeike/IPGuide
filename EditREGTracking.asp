<%@  language="VBScript" %>

<!--
    date: 2016-11-10
    author: Rafy Zhao
    description: 
        - when user clicks the 'Edit' button in the IPGuideRequest - REG Tracker page, pop up a new window to enable the client to edit the REG Tracking.
        - to be called by /IPGuideRequest/index.asp
-->

<!-- #include virtual=/assets/lib/utils.asp -->

<link rel="stylesheet" href="/assets/js/guidely/guidely.css" type="text/css">
<link rel="stylesheet" href="/assets/css/countryform.css" type="text/css">


<% 
    clientID = Request.QueryString("client")
    
    strSQL = "select ip.ipName ipName, " &_
                 "CASE WHEN (dual_language IS NULL) THEN 0 ELSE 1 END AS ipNumber, " &_
                "ip.id ip_id  , ipcount.dual_language " &_
                "from ipguide ip " &_
                "left join ( " &_
                "select ip_id , dual_language " &_
                "from IPGuideRequestRecord " &_
                "where client_id=" & clientID &_            
                " and IPType='reg' ) ipcount " &_
                "on ip.id=ipcount.ip_id " &_
                "where ip.iptype='ips'" &_
                 " order by ipNumber desc, ipName"
    'response.Write(strSQL)
    set clientRS = conn.execute(strSQL)

    if  not (clientRS.EOF and clientRS.BOF)  then %>
        <div class="container2">
            <h4 style="text-align:center;"><strong>Edit REG Tracking Request</strong></h4>
            <p>&nbsp;</p>
            <table class="table table-striped table-bordered table-hover no-margin-bottom no-border-top" style="width: 100%;">
                <thead>
                    <tr>
                        <th>Country</th>
                        <th>REG Tracking</th>                
                    </tr>
                </thead>
                <tbody>
                    <% While Not clientRS.EOF %>
                    <tr>
                        <td><%=clientRS("ipname") %></td>                           
                        <td>
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
            $('.ipedit').change(function (e) { 
                e.preventDefault();
                var ip_name = $(this).attr("name");
                var ip_type = "reg";
                var client_id = $(this).attr("data-clientID");
                var ip_id = $(this).attr("data-ipID");            
                var dualLanguage = 0;

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

       
    </script>
