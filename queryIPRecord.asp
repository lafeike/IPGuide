<%
    Set IPConn = Server.CreateObject("ADODB.Connection")
    IPConn.Open  "Driver={SQL Server};" & _ 
       "Server=10.2.1.24;" & _ 
       "Database=STP_Online;" & _
       "DataTypeCompatibility=80;" & _
       "Uid=stp.sqlsa;" & _ 
       "Pwd=#STP2011?;"
   
     dim iptype, ipname, ipid, clientid, client, rep, dual, responseHtml, SQL
    dim hasIP, hasClient, hasRep, queryCase, hasDual

    iptype = Request.QueryString("iptype")
    ipname = Request.QueryString("ipname")
    ipid = Request.QueryString("ipid")
    clientid = Request.QueryString("clientid")
    client = Request.QueryString("client")
    rep = Request.QueryString("rep")
    dual = Request.QueryString("dual")
        
   ' Response.Write("<p>" & iptype & ", " & ipname & ", " & client & ", " & rep & "</p>")

    if len(ipname) > 0 then
        hasIP = true
    else
        hasIP = false
    end if

    if len(client) > 0 then
        hasClient = true
    else
        hasClient = false
    end if

    if len(rep) > 0 then
        hasRep = true
    else
        hasRep = false
    end if

    if StrComp(dual, "1") = 0 then 
        hasDual = true
    else
        hasDual = false
    end if
    'Response.Write("<p>" & iptype & ", has ipname?" & hasIP & ", has client?" & hasClient & ", has rep?" & hasRep & "</p>")
    
    if (Not hasIP) And  (Not hasClient) And (Not hasRep)  And (Not hasDual) then
        If StrComp(iptype, "Reg") = 0 Then
            SQL = "select ipname as r1, clientname as r2 " &_
                "from IPGuide ip " &_
                "join IPGuideRequestRecord r " &_
                "on ip.id=r.ip_id " &_
                "join IPGuideRequestClient c " &_
                "on r.client_id=c.id " &_
                "where r.iptype='" & iptype & "'"   
            responseHtml = "<header class='bg-success text-success'>These IPs were requested for <strong>REG Tracking</strong>:</header>"
            queryCase = 2
        Else
            responseHtml = "<p class='bg-warning text-warning'>One query condition must be selected at least.</p>"
            queryCase = 1
        End If        
    elseif (Not hasIP) And  (Not hasClient) And (Not hasRep) then ' query records that ask for dual language
        responseHtml = "<header class='bg-success text-success'>These IPs were requested in <strong>Dual Language</strong>:</header>"
        SQL = "select ipname as r1, clientname as r2 " &_
                "from IPGuide ip " &_
                "join IPGuideRequestRecord r " &_
                "on ip.id=r.ip_id " &_
                "join IPGuideRequestClient c " &_
                "on r.client_id=c.id " &_
                "where r.dual_language=1 " &_
                "and r.iptype='" & iptype & "'"   
        queryCase = 2     
    elseif hasIP And (Not hasClient) And (Not hasRep) then
        responseHtml = "<header class='bg-success text-success'>The following client requested for <strong>" & ipname & "</strong>:</header>"
        if hasDual then
            SQL = "select clientname as r1,rep as r2 " &_
                "from IPGuideRequestClient a " &_
                "right join IPGuideRequestRecord b " &_
                "on a.id=b.client_id " &_
                "where b.ip_id=" & ipid & " and b.dual_language=1"
        else
            SQL = "select clientname as r1,rep as r2 " &_
                "from IPGuideRequestClient a " &_
                "right join IPGuideRequestRecord b " &_
                "on a.id=b.client_id " &_
                "where b.ip_id=" & ipid &_
                " and b.iptype='" & iptype & "'"
        end if    
        queryCase = 2
    elseif (Not hasIP) And hasClient And (Not hasRep) then
        responseHtml = "<header class='bg-success text-success'>The client&nbsp;<strong>" & client & "</strong>&nbsp;requests for following IP:</header>"
        if hasDual then
            SQL = "select IPName as r1 " &_
                "from IPGuide a " &_
                "right join IPGuideRequestRecord b " &_
                "on a.id=b.ip_id " &_
                "where b.client_id=" & clientid &_
                " and b.iptype='" & iptype & "'" & " and b.dual_language=1"
        else
            SQL = "select IPName as r1 " &_
                "from IPGuide a " &_
                "right join IPGuideRequestRecord b " &_
                "on a.id=b.ip_id " &_
                "where b.client_id=" & clientid &_
                " and b.iptype='" & iptype & "'"
        end if    
        queryCase = 3
    elseif (Not hasIP) And (Not hasClient) And hasRep then
        queryCase = 4
        responseHtml = "<header class='bg-success text-success'>Rep&nbsp;<strong>" & rep & "</strong>&nbsp;has these clients who requested IP:</header>"
        if hasDual then
            SQL = "select count(b.id) as r2, ClientName as r1 " &_
                "from IPGuideRequestClient a " &_
                "right join IPGuideRequestRecord b " &_
                "on a.id=b.client_id " &_
                "where a.rep like '%" & rep &_
                "%' and b.iptype='" & iptype & "' and b.dual_language=1 group by ClientName"
        else
            SQL = "select count(b.id) as r2, ClientName as r1 " &_
                "from IPGuideRequestClient a " &_
                "right join IPGuideRequestRecord b " &_
                "on a.id=b.client_id " &_
                "where a.rep like '%" & rep &_
                "%' and b.iptype='" & iptype & "' group by ClientName"
        end if
    elseif hasIP And hasClient And (Not hasRep) then
        queryCase = 5
        responseHtml = "<header class='bg-success text-success'>Client&nbsp;<strong>" & client &_
             "</strong>&nbsp;has request&nbsp;<strong>" & ipname & "</strong>&nbsp;via Rep:</header>"
        if hasDual then
            SQL = "select rep from IPGuideRequestClient  " &_
                "where id=(" &_
                "select client_id from IPGuideRequestRecord " &_
                "where ip_id=" & ipid & " and client_id=" & clientid &_ 
                " and iptype='" & iptype & "' and dual_language=1)"
        else
            SQL = "select rep from IPGuideRequestClient  " &_
                "where id=(" &_
                "select client_id from IPGuideRequestRecord " &_
                "where ip_id=" & ipid & " and client_id=" & clientid &_ 
                " and iptype='" & iptype & "')"
        end if

    elseif hasIP And (Not hasClient) And hasRep then
        queryCase = 6
        responseHtml = "<header class='bg-success text-success'>The following clients requested for <strong>" & ipname &_
                     "</strong>&nbsp;via rep<strong>" & rep & "&nbsp;:</header>"
        if hasDual then
             SQL = "select clientname as r1,rep as r2 " &_
                "from IPGuideRequestClient a " &_
                "right join IPGuideRequestRecord b " &_
                "on a.id=b.client_id " &_
                "where b.ip_id=" & ipid &_
                " and b.dual_language=1 and a.rep like '%" & rep & "%'"
        else
            SQL = "select clientname as r1,rep as r2 " &_
                "from IPGuideRequestClient a " &_
                "right join IPGuideRequestRecord b " &_
                "on a.id=b.client_id " &_
                "where b.ip_id=" & ipid &_ 
                " and b.iptype='" & iptype & "'" &_
                " and a.rep like '%" & rep & "%'"                
        end if
    elseif (Not hasIP) And hasClient And hasRep then
        queryCase = 7
        responseHtml = "<header class='bg-success text-success'>Client&nbsp;<strong>" & client &_
                     "</strong>&nbsp;via rep<strong>" & rep & "&nbsp;requests following IP:</header>"
        if hasDual then
            SQL = "select IPName r1 " &_
                "from IPGuide a " &_
                "right join IPGuideRequestRecord b " &_
                "on a.id=b.ip_id " &_
                "right join IPGuideRequestClient c " &_
                "on c.id=b.client_id " &_
                "where b.client_id=" & clientid &_
                " and b.iptype='" & iptype & "'" &_
                "  and b.dual_language=1 and c.rep like '%" & rep & "%'"
        else
            SQL = "select IPName r1 " &_
                "from IPGuide a " &_
                "right join IPGuideRequestRecord b " &_
                "on a.id=b.ip_id " &_
                "right join IPGuideRequestClient c " &_
                "on c.id=b.client_id " &_
                "where b.client_id=" & clientid &_
                " and b.iptype='" & iptype & "'" &_
                " and c.rep like '%" & rep & "%'"
        end if
    else
        queryCase = 2
        responseHtml = "<header class='bg-success text-success'>There is a record that meets the query conditions. </header>"
        if hasDual then
            SQL = "select IPName r1 , c.clientname r2 " &_
                "from IPGuide a " &_
                "right join IPGuideRequestRecord b " &_
                "on a.id=b.ip_id " &_
                "right join IPGuideRequestClient c " &_
                "on c.id=b.client_id " &_
                "where b.client_id=" & clientid &_
                " and b.iptype='" & iptype & "' and b.dual_language=1" &_
                " and c.rep like '%" & rep & "%' " &_
                " and a.id=" & ipid
        else
            SQL = "select IPName r1, c.clientname r2 " &_
                "from IPGuide a " &_
                "right join IPGuideRequestRecord b " &_
                "on a.id=b.ip_id " &_
                "right join IPGuideRequestClient c " &_
                "on c.id=b.client_id " &_
                "where b.client_id=" & clientid &_
                " and b.iptype='" & iptype & "'" &_
                " and c.rep like '%" & rep & "%' " &_
                " and a.id=" & ipid
        end if
    end if
    
    if not queryCase = 1 then
        'Response.Write(SQL)
        Set rs = IPConn.Execute(SQL)
        if rs.eof and rs.bof then
            'nothing 
             responseHtml = "<p class='bg-warning text-warning'>No results returned. Please choose another query condition and try again.</p>"
        else
            responseHtml = responseHtml & "<br><p class='bg-success text-success'>"
            dim firstRecord  
            firstRecord = true
            While Not rs.EOF
                if not firstRecord then
                        responseHtml = responseHtml & ", &nbsp;"
                    end if
                responseHtml = responseHtml & "&nbsp;"    
                Select Case queryCase
                    case 2            
                        responseHtml = responseHtml & rs("r1") & "(" & rs("r2") & ")"
                    case 3
                         responseHtml = responseHtml & rs("r1")
                    case 4
                        responseHtml = responseHtml & rs("r1") & "(" & rs("r2") & "&nbsp; times)"
                    case 5
                        responseHtml = responseHtml & rs("rep")
                    case 6
                         responseHtml = responseHtml & rs("r1")
                    case 7
                         responseHtml = responseHtml & rs("r1")
                End Select
                firstRecord = false
                rs.MoveNext
            Wend
            responseHtml = responseHtml & "</p>"
        end if
    end if

    Response.Write(responseHtml)
   
   ' rs.Close : Set rs = Nothing : IPConn.Close : Set IPConn = Nothing
    Response.End 
%> 