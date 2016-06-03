<%
    Set IPConn = Server.CreateObject("ADODB.Connection")
    IPConn.Open  "Driver={SQL Server};" & _ 
       "Server=10.2.1.24;" & _ 
       "Database=STP_Online;" & _
       "DataTypeCompatibility=80;" & _
       "Uid=stp.sqlsa;" & _ 
       "Pwd=#STP2011?;"
   
    dim iptype, ipname, ipid, clientid, client, rep, responseHtml, SQL
    dim hasIP, hasClient, hasRep, queryCase

    iptype = Request.QueryString("iptype")
    ipname = Request.QueryString("ipname")
    ipid = Request.QueryString("ipid")
    clientid = Request.QueryString("clientid")
    client = Request.QueryString("client")
    rep = Request.QueryString("rep")
        
    Response.Write("<p>" & iptype & ", " & ipname & ", " & client & ", " & rep & "</p>")

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
    'Response.Write("<p>" & iptype & ", has ipname?" & hasIP & ", has client?" & hasClient & ", has rep?" & hasRep & "</p>")
    
    if (Not hasIP) And  (Not hasClient) And (Not hasRep) then
        responseHtml = "<p class='bg-warning text-warning'>One query condition must be selected at least.</p>"
        queryCase = 1
    elseif hasIP And (Not hasClient) And (Not hasRep) then
        responseHtml = "<header class='bg-success text-success'>The following client requested for <strong>" & ipname & "</strong>:</header>"
        SQL = "select clientname as r1,rep as r2 " &_
                "from IPGuideRequestClient a " &_
                "right join IPGuideRequestRecord b " &_
                "on a.id=b.client_id " &_
                "where b.ip_id=" & ipid
        queryCase = 2
    elseif (Not hasIP) And hasClient And (Not hasRep) then
        responseHtml = "<header class='bg-success text-success'>The client&nbsp;<strong>" & client & "</strong>&nbsp;requests for following IP:</header>"
        SQL = "select IPName as r1 " &_
                "from IPGuide a " &_
                "right join IPGuideRequestRecord b " &_
                "on a.id=b.ip_id " &_
                "where b.client_id=" & clientid &_
                " and b.iptype='" & iptype & "'"
        queryCase = 3
    elseif (Not hasIP) And (Not hasClient) And hasRep then
        queryCase = 4
        responseHtml = "<header class='bg-success text-success'>Rep&nbsp;<strong>" & rep & "</strong>&nbsp;has these clients who requested IP:</header>"
        SQL = "select count(b.id) as r2, ClientName as r1 " &_
                "from IPGuideRequestClient a " &_
                "right join IPGuideRequestRecord b " &_
                "on a.id=b.client_id " &_
                "where a.rep like '%" & rep &_
                "%' and b.iptype='" & iptype & "' group by ClientName"
        
    elseif hasIP And hasClient And (Not hasRep) then
        queryCase = 5
        responseHtml = "<header class='bg-success text-success'>Client&nbsp;<strong>" & client &_
             "</strong>&nbsp;has request&nbsp;<strong>" & ipname & "</strong>&nbsp;via Rep:</header>"
        SQL = "select rep from IPGuideRequestClient  " &_
                "where id=(" &_
                "select client_id from IPGuideRequestRecord " &_
                "where ip_id=" & ipid & " and client_id=" & clientid &_ 
                " and iptype='" & iptype & "')"

    elseif hasIP And (Not hasClient) And hasRep then
        queryCase = 6
        responseHtml = "<header class='bg-success text-success'>The following clients requested for <strong>" & ipname &_
                     "</strong>&nbsp;via rep<strong>" & rep & "&nbsp;:</header>"
         SQL = "select clientname as r1,rep as r2 " &_
                "from IPGuideRequestClient a " &_
                "right join IPGuideRequestRecord b " &_
                "on a.id=b.client_id " &_
                "where b.ip_id=" & ipid &_
                " and a.rep like '%" & rep & "%'"
    elseif (Not hasIP) And hasClient And hasRep then
        queryCase = 7
        responseHtml = "<header class='bg-success text-success'>Client&nbsp;<strong>" & client &_
                     "</strong>&nbsp;via rep<strong>" & rep & "&nbsp;requests following IP:</header>"
        SQL = "select IPName r1 " &_
                "from IPGuide a " &_
                "right join IPGuideRequestRecord b " &_
                "on a.id=b.ip_id " &_
                "right join IPGuideRequestClient c " &_
                "on c.id=b.client_id " &_
                "where b.client_id=" & clientid &_
                " and b.iptype='" & iptype & "'" &_
                " and c.rep like '%" & rep & "%'"
    else
        queryCase = 8
        responseHtml = "<header class='bg-success text-success'>There is a record that meets the query conditions. </header>"
        SQL = "select IPName r1 " &_
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