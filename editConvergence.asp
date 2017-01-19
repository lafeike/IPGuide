<%@  language="VBScript" %>

<!--
    date: 2016-12-09
    author: Rafy Zhao
    description: 
        - when user clicks the 'Edit' button in the IPGuideRequest page, pop up a new window to enable the client to edit Convergence.
        - to be called by /IPGuideRequest/index.asp
-->

<!-- #include virtual=/assets/lib/utils.asp -->

<link rel="stylesheet" href="/assets/js/guidely/guidely.css" type="text/css">
<link rel="stylesheet" href="/assets/css/countryform.css" type="text/css">

<% 
    clientID = Request.QueryString("client")
    strSQL = "select ip.id ip_id,ip.ipName ipName, " &_
                "CASE WHEN (ipcount.dual_language= 1) THEN 1 ELSE 0 END AS legal, " &_
                "CASE WHEN (legal.dual_language = 0) THEN 1 ELSE 0 END AS checklist " &_
                "from ipguide ip " &_
                "left join (select dual_language,ip_id from IPGuideRequestRecord " &_
                "where client_id='" & clientID &_
                "' and IPType='Convergence' and dual_language=1 ) ipcount " &_
                "on ip.id=ipcount.IP_id " &_
                "left join (select dual_language,ip_id from IPGuideRequestRecord " &_
                "where client_id='" & clientID &_
                "' and IPType='Convergence' and dual_language=0 ) legal " &_
                "on ip.id=legal.IP_id " &_
                "where ip.IPType='Convergence' " &_
                "order by legal desc, checklist desc, ipname; "

    set clientRS = conn.execute(strSQL)

    if  not (clientRS.EOF and clientRS.BOF)  then %>
        <div class="container2">
            <h4 style="text-align:center;"><strong>Office Health & Safety</strong></h4>
            <p>&nbsp;</p>
            <table class="table table-striped table-bordered table-hover no-margin-bottom no-border-top" style="width: 100%;">
                <thead>
                    <tr>
                        <th>IP Name</th>
                        <th>Legal Register</th>
                        <th>Checklist</th>     
                    </tr>
                </thead>
                <tbody>
                    <% While Not clientRS.EOF %>
                    <tr>
                        <td><%=clientRS("ipname") %></td>
                        <td>
                            <input class="legal" type="checkbox"  data-clientID="<%= clientID %>" 
                                data-ipID="<%= clientRS("ip_id") %>" name="<%= clientRS("ipname")  %>"
                                    <% if clientRS("legal")  then %> 
                                        checked >
                                    <%else %>
                                         />
                                    <% end if %>                
                        </td>
                        <td>
                            <input class= "checklist" type="checkbox" data-clientID="<%= clientID %>" 
                                data-ipID="<%= clientRS("ip_id") %>" name="<%= clientRS("ipname")  %>"
                                <% if clientRS("checklist") = 1 then %> 
                                    checked />
                                <%else %>
                                     />
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
            // when user click the checkbox in 'Checklist'
            $('.checklist').change(function (e) { 
                e.preventDefault();
                var ip_name = $(this).attr("name");
                var client_id = $(this).attr("data-clientID");
                var ip_id = $(this).attr("data-ipID");                 
                
                var data = {
                    ip_name: ip_name,
                    client_id: client_id,
                    c_flag: 0, // dua_language = 0 --> for 'checklist'
                    ip_id: ip_id
                };

                $.ajax({
                    type: 'get',
                    url: 'updateConvergence.asp',
                    data: data,
                    success: function (data) {                       
                    }
                });
            });

            // when user click the checkbox in 'Legal Register'       
            $('.legal').change(function (e) {
                e.preventDefault();
                var ip_name = $(this).attr("name");
                var client_id = $(this).attr("data-clientID");
                var ip_id = $(this).attr("data-ipID");

                var data = {
                    ip_name: ip_name,
                    client_id: client_id,
                    c_flag: 1, // dua_language = 0 --> for 'legal register'
                    ip_id: ip_id
                };

                $.ajax({
                    type: 'post',
                    url: 'updateConvergence.asp',
                    data: data,
                    success: function (data) {
                    }
                });
            });

        });   
    </script>
