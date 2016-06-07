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
        
    dim SQL, o_cmd, responseHTML, displayNum, clientSQL, clientRS
    displayNum = request.QueryString("displayNum")
    if len(displayNum) = 0 then
        displayNum = 2
    end if
    responseHtml = "<section> " &_
                    "<form method=""get"" action=""./report.asp""> <div class=""form-group"">" &_
                    "<label for=""inputsm"">Display requests' number greater than or equal to: &nbsp;</label>" &_
                    "<input type=""hidden"" name=""iptype"" value=""" & iptype & """>" &_
                    "<input id=""displayNum"" class=""form-control input-sm"" value=""" & displayNum & """ type=""number""  name=""displayNum""> &nbsp;" &_
                    "<input type=""submit"" value=""Confirm"">" &_
                    "</div>" &_
                    "</form>" &_
                    "<hr /> " &_
                    "<table id='clientable' class='usertable table table-striped table-hover table-responsive'>" &_
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
                            "where IPType= ?" &_
                            " group by ip_id) record " &_
                            "on ip.id=record.ip_id " &_
                            "where record.requests >= ?" 
    Set o_cmd = Server.CreateObject("ADODB.command") 
    
    ipSQL = "select row_number() over (order by number desc, ipname asc) as noo," &_
                            "r.ipname, r.number, r.id as ip_id " &_
                            "from (" & SQL & ") r"      
                    
    o_cmd.ActiveConnection = ReportConn                       
    o_cmd.CommandText = ipSQL 
    o_cmd.CommandType = adCmdText
    o_cmd.Prepared = true
                    
    set prm1 = o_cmd.CreateParameter("@prm1",adVarChar,adParamInput,20, iptype)
    set prm2 = o_cmd.CreateParameter("@prm2", adInteger,adParamInput,5,displayNum)
    o_cmd.Parameters.Append prm1
    o_cmd.Parameters.Append prm2
                   
    set rs = server.CreateObject("ADODB.Recordset")
    set rs = o_cmd.Execute()

    if rs.eof and rs.bof then
        responseHtml = responseHtml & "<p class='bg-warning text-warning'>No result. Please choose another query condition and try again.</p>"
    else
        dim firstRecord                                                     
        While Not rs.EOF
            responseHtml = responseHtml & "<tr =trclass >" &_
                            "<td>" & rs("noo") & "</td>" &_
                            "<td>" & rs("ipname") & "</td>" &_
                            "<td>" & rs("number") & "</td>" 
            clientSQL = "select b.ClientName " &_
                            "from IPGuideRequestRecord a " &_
                            "right join IPGuideRequestClient b " &_
                            "on a.client_id=b.id " &_
                            "where a.ip_id=" & rs("ip_id")
            set clientRS = ReportConn.Execute(clientSQL)
            responseHtml = responseHtml & "<td>" 
       
            firstRecord = true   
            Do While Not clientRS.EOF
                if not firstRecord then
                    responseHtml = responseHtml & ", &nbsp;"
                end if
                responseHtml = responseHtml & "&nbsp;" & clientRS("clientname")
                firstRecord = false
                clientRS.MoveNext
            Loop
            'responseHtml = Left(responseHtml, len(responseHtml) -1 )
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