<!--
    date: 2016-5-25
    author: Rafy Zhao
    description: 
        - export the report data to an Excel file.
        - to be included in /IPGuideRequest/report.asp
-->

<!-- #include virtual=/assets/lib/utils.asp -->
<!--#include virtual="/adovbs.inc"-->

<%
    dim SQL1, SQL2, iptype, displayNum
    
    iptype = Request.QueryString("iptype")
    displayNum = Request.QueryString("displayNum")

   SQL1 =  "select top 100 percent ip.id, ip.ipname ipname, record.requests number " &_
                            "from IPGuide ip " &_
                            "right join(" &_
                            "select ip_id, count(*) requests " &_
                            "from IPGuideRequestRecord " &_
                            "where IPType= ?" &_
                            " group by ip_id) record " &_
                            "on ip.id=record.ip_id " &_
                            "where record.requests >= ? order by record.requests desc, ipname asc" 
    Set o_cmd = Server.CreateObject("ADODB.command") 
    
    ipSQL = "select row_number() over (order by number desc) as noo," &_
                            "r.ipname, r.number, r.id as ip_id " &_
                            "from (" & SQL1 & ") r"      
                    
    o_cmd.ActiveConnection = conn                       
    o_cmd.CommandText = ipSQL 
    o_cmd.CommandType = adCmdText
    o_cmd.Prepared = true
                   
    set prm1 = o_cmd.CreateParameter("@prm1",adVarChar,adParamInput,20, iptype)
    set prm2 = o_cmd.CreateParameter("@prm2", adInteger,adParamInput,5,displayNum)

    o_cmd.Parameters.Append prm1
    o_cmd.Parameters.Append prm2
                     
    set rs = server.CreateObject("ADODB.Recordset")
    set rs = o_cmd.Execute()
    dim firstRecord                                      
    
    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader "Content-Disposition", "attachment; filename=CountryRequest_report.xls"	
    
    if rs.eof and rs.bof then
        response.write "<table border=1><tr><td>No.</td><td>Country</td><td>Sum</td><td>Client List</td></tr>"
        while not rs.eof
            response.write "<tr><td>" & rs.fields("noo") & "</td><td>" &_
            rs.fields("ipname") & "</td><td>" & rs.fields("number")  & "</td>"
            clientSQL = "select b.ClientName " &_
                        "from IPGuideRequestRecord a " &_
                        "right join IPGuideRequestClient b " &_
                        "on a.client_id=b.id " &_
                        "where a.ip_id=" & rs("ip_id")
            set clientRS = conn.Execute(clientSQL)
            response.write "<td>" 
       
            firstRecord = true   
            Do While Not clientRS.EOF
                if not firstRecord then
                    response.write ", &nbsp;"
                end if
                response.write "&nbsp;" 
                response.write clientRS("clientname")
                firstRecord = false
                clientRS.MoveNext
            Loop
            response.write "</td></tr>"
            rs.movenext
        wend
        response.write "</table>"
    
    end if
    
    response.End
    set rs=nothing
    conn.close
%>

