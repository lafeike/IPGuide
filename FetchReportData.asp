<!--
    date: 2016-5-24
    author: Rafy Zhao
    description: 
        - query the report data for ip guide request.
        - to be included in /IPGuideRequest/report.asp
-->

<%
    Set ReportConn = Server.CreateObject("ADODB.Connection")
    ReportConn.Open  "Driver={SQL Server};" & _ 
                     "Server=10.2.1.24;" & _ 
                     "Database=STP_Online;" & _
                     "DataTypeCompatibility=80;" & _
                     "Uid=stp.sqlsa;" & _ 
                     "Pwd=#STP2011?;" 
        
    dim SQL, o_cmd, responseHTML, clientSQL, clientRS, reportBy, iptype
   
    reportBy = request("reportType")
    iptype = request("iptype")    
    
    if len(reportBy) = 0 then
        reportBy = "country"
    end if
    
    If StrComp(reportBy, "country") = 0 Then       
        If StrComp(iptype, "IPs") = 0 Then
            responseHtml = "<section> " &_
                    "<table id='clientable' class='usertable table table-striped table-hover table-responsive display' cellspacing='0' width='100%'>" &_
                    "<thead>" &_
                    "<tr>" &_
                    "<th>No.</th>" &_
                    "<th class='clientsort'>Country</th>" &_
                    "<th>Sum</th>" &_
                    "<th>Dual Lang</th>" &_
                    "<th>Client List</th>" &_
                    "</tr>" &_
                    "</thead>" &_
                    "<tbody id='myTable'>" 
            SQL =  "select top 100 percent ip.id, ip.ipname ipname, record.requests number, " &_
                        "case when dual.requests is null then 0 else dual.requests end as du " &_
                            "from IPGuide ip " &_
                            "right join(" &_
                            "select ip_id, count(*) requests " &_
                            "from IPGuideRequestRecord " &_
                            "where IPType= '" &iptype &"'" &_
                            " group by ip_id) record " &_
                            "on ip.id=record.ip_id " &_
                            "left join(" &_
                            "select ip_id, count(*) requests " &_
                            "from IPGuideRequestRecord " &_
                            "where IPType='IPs' and dual_language=1 " &_
                            "group by ip_id) dual " &_
                            "on ip.id=dual.ip_id " &_
                            "where record.requests >= 0" 
       
            ipSQL = "select row_number() over (order by number desc, ipname asc) as noo," &_
                            "r.ipname, r.number, r.du, r.id as ip_id " &_
                            "from (" & SQL & ") r"
        Else
            responseHtml = "<section> " &_
                    "<table id='clientable' class='usertable table table-striped table-hover table-responsive display' cellspacing='0' width='100%'>" &_
                    "<thead>" &_
                    "<tr>" &_
                    "<th>No.</th>" &_
                    "<th class='clientsort'>Country</th>" &_
                    "<th>Sum</th>" &_
                    "<th>Client List</th>" &_
                    "</tr>" &_
                    "</thead>" &_
                    "<tbody id='myTable'>" 
            SQL =  "select top 100 percent ip.id, ip.ipname ipname, record.requests number " &_
                            "from IPGuide ip " &_
                            "right join(" &_
                            "select ip_id, count(*) requests " &_
                            "from IPGuideRequestRecord " &_
                            "where IPType= '" &iptype &"'" &_
                            " group by ip_id) record " &_
                            "on ip.id=record.ip_id " &_
                            "where record.requests >= 0" 
            ipSQL = "select row_number() over (order by number desc, ipname asc) as noo," &_
                            "r.ipname, r.number, r.id as ip_id " &_
                            "from (" & SQL & ") r"  
        End If
        
    Else        
        responseHtml = "<section> " &_                    
                    "<table id='clientable' class='usertable table table-striped table-hover table-responsive display' cellspacing='0' width='100%'>" &_
                    "<thead>" &_
                    "<tr>" &_
                    "<th>No.</th>" &_
                    "<th class='clientsort'>Client</th>" &_
                    "<th>Sum</th>" &_
                    "<th>Country List</th>" &_
                    "</tr>" &_
                    "</thead>" &_
                    "<tbody id='myTable'>" 
        SQL =  "select top 100 percent client.id, client.ClientName clientname, record.requests number " &_
                            "from IPGuideRequestClient client " &_
                            "right join(" &_
                            "select client_id, count(*) requests " &_
                            "from IPGuideRequestRecord " &_
                            "where IPType= '" &iptype &"'" &_
                            " group by client_id) record " &_
                            "on client.id=record.client_id " &_
                            "where record.requests >= 0" 
        ipSQL = "select row_number() over (order by number desc, clientname asc) as noo," &_
                            "r.clientname, r.number, r.id as client_id " &_
                            "from (" & SQL & ") r"  
    End If    
    set rs = ReportConn.execute(ipSQL)
    if rs.eof and rs.bof then
        responseHtml = responseHtml & "<p class='bg-warning text-warning'>No result. Please choose another query condition and try again.</p>"    
    else
        dim firstRecord                                                     
        
        While Not rs.EOF
            If StrComp(reportBy, "country") = 0 Then
                If StrComp(iptype, "IPs") = 0 Then
                    responseHtml = responseHtml & "<tr =trclass >" &_
                            "<td>" & rs("noo") & "</td>" &_
                            "<td>" & rs("ipname") & "</td>" &_
                            "<td>" & rs("number") & "</td>" &_
                            "<td>" & rs("du") & "</td>" 
                                                   
                Else
                    responseHtml = responseHtml & "<tr =trclass >" &_
                            "<td>" & rs("noo") & "</td>" &_
                            "<td>" & rs("ipname") & "</td>" &_
                            "<td>" & rs("number") & "</td>"                     
                End If
                clientSQL = "select b.ClientName name, a.dual_language dual " &_
                            "from IPGuideRequestRecord a " &_
                            "right join IPGuideRequestClient b " &_
                            "on a.client_id=b.id " &_
                            "where a.ip_id=" & rs("ip_id") &_
                             " and a.iptype='" & iptype &"'" &_
                            " order by name"
            Else 'report by client
                responseHtml = responseHtml & "<tr =trclass >" &_
                            "<td>" & rs("noo") & "</td>" &_
                            "<td>" & rs("clientname") & "</td>" &_
                            "<td>" & rs("number") & "</td>" 
                clientSQL = "select b.IPName name, a.dual_language dual " &_
                            "from IPGuideRequestRecord a " &_
                            "right join IPGuide b " &_
                            "on a.ip_id=b.id " &_
                            "where a.client_id=" & rs("client_id")&_
                            " and a.iptype='" & iptype &"'" &_
                            " order by name"
            End If
            
            set clientRS = ReportConn.Execute(clientSQL)
            responseHtml = responseHtml & "<td>" 
       
            firstRecord = true   
            Do While Not clientRS.EOF
                if not firstRecord then
                    responseHtml = responseHtml & "; &nbsp;"
                end if
               
                If StrComp(clientRS("dual"), "True") = 0 Then
                    responseHtml = responseHtml & "&nbsp;<b>" & clientRS("name") & "</b>"
                Else
                    responseHtml = responseHtml & "&nbsp;" & clientRS("name")
                End If
                
                firstRecord = false
                clientRS.MoveNext
            Loop
            responseHtml = responseHtml & "</td></tr>"  
            rs.MoveNext
        Wend             
        responseHtml = responseHtml & "</tbody>" &_
                    "</table>" &_
                    "</section>"
        clientRS.Close : Set ClientRS = Nothing
   
    end if
    response.Write(responseHtml)
    
    rs.Close : Set rs = Nothing : ReportConn.Close : Set ReportConn = Nothing    
    'response.End
%>