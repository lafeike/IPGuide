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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>

<% 
    clientID = Request.QueryString("client")
    iptype = Request.QueryString("iptype")
    
    strSQL = "select ip.ipName ipName, isnull(ipcount.iprecordnum, 0) num, ip.id ip_id " &_
                "from ipguide ip " &_
                "left join ( " &_
                "select ip_id, count(*) iprecordnum " &_
                "from IPGuideRequestRecord " &_
                "where client_id=" & clientID &_            
                " and IPType='" & iptype &_
                "' group by ip_id) ipcount " &_
                "on ip.id=ipcount.ip_id " &_
                "where ip.iptype='" & iptype & "'" &_
                "order by num desc, ipName"
    'response.Write(strSQL)
    set clientRS = conn.execute(strSQL)

    if  not (clientRS.EOF and clientRS.BOF)  then %>
        <div class="container2">
            <p><span id="hintmessage" ></span></p>
            <h4 style="text-align:center;"><strong>Edit IP Guide Request</strong></h4>
            <p>&nbsp;</p>
            <table class="table table-striped table-bordered table-hover no-margin-bottom no-border-top" style="width: 100%;">
                <thead>
                    <tr>
                        <th>IP Name</th>
                        <th>Confirm Request</th>                
                    </tr>
                </thead>
                <tbody>
                    <% While Not clientRS.EOF %>
                    <tr>
                        <td><%=clientRS("ipname") %></td>
                        <td><input type="checkbox" data-iptype="<%= iptype %>" data-clientID="<%= clientID %>" data-ipID="<%= clientRS("ip_id") %>" name="<%= clientRS("ipname")  %>"
                                <% if clientRS("num") = 0 then %> 
                                    >
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

            // when user click the checkbox after the ip name, call updateIPGuideRecord.asp to update the database.
            $('input:checkbox').change(function (e) { 
                e.preventDefault();
                var ip_name = $(this).attr("name");
                var ip_type = $(this).attr("data-iptype");
                var client_id = $(this).attr("data-clientID");
                var ip_id = $(this).attr("data-ipID");            

                var data = {
                    ip_name: ip_name,
                    client_id: client_id,
                    ip_type: ip_type,
                    ip_id: ip_id
                };

                $.ajax({
                    type: 'post',
                    url: 'updateIPGuideRecord.asp',
                    data: data,
                    success: function (data) {
                        $("#hintmessage").html("<div>");
                        $("#hintmessage").html(data);
                        $("#hintmessage").html("</div>");
                    }
                });
            });                
        });  
    </script>
