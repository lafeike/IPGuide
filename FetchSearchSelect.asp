<%
    Set IPConn = Server.CreateObject("ADODB.Connection")
    IPConn.Open  "Driver={SQL Server};" & _ 
       "Server=10.2.1.24;" & _ 
       "Database=STP_Online;" & _
       "DataTypeCompatibility=80;" & _
       "Uid=stp.sqlsa;" & _ 
       "Pwd=#STP2011?;" 
      
    dim query, iptype
    Dim jsonResponse, json1, json2, json3

    iptype = Request.QueryString("iptype")
    if StrComp(iptype, "Reg") = 0 then
        iptype = "IPs"
    end if
    'populate data for IP name dropdown list   
    json1 = """ipname"":""<option value='0'>Please choose an IP name</option>"
    query = "SELECT rtrim(ltrim(ipname)) ipname, id FROM IPGuide " &_
            "WHERE iptype='" & iptype & "' order by ipname"
    
    'json1 = json1 & "<option>" & query & "</option>"
    Set rs = IPConn.Execute(query)
    While Not rs.EOF   
        json1 = json1 & "<option value='" & rs("id") & "'>" & rs("ipname") & "</option>"
        rs.MoveNext
    Wend
    json1 = json1 & """"    

    'populate data for client dropdown list
    json2 = """client"":""<option value='0'>Please choose a client</option>"
    query = "SELECT clientname,id FROM IPGuideRequestClient " &_
            "order by clientname"
    'json2 = json2 & "<option>" & query & "</option>"
    
    Set rs = IPConn.Execute(query)
    While Not rs.EOF   
        json2 = json2 & "<option value='" & rs("id") & "'>" & rs("clientname") & "</option>"
        rs.MoveNext
    Wend
    json2 = json2 & """" 

    'popluate data for rep dropdown list
    json3 = """rep"":""<option value='0'>Please choose a rep number</option>"
    query = "SELECT  cast(rep as int) as repnum FROM IPGuideRep order by repnum" 
    'json3 = json3 & "<option>" & query & "</option>"
   
    Set rs = IPConn.Execute(query)
    While Not rs.EOF   
        json3 = json3 & "<option>" & rs("repnum") & "</option>"
        rs.MoveNext
    Wend
    json3 = json3 & """" 
    
    jsonResponse = "{" & json1 & "," & json2 & "," & json3 &"}"
    Response.Write(jsonResponse)
   
    rs.Close : Set rs = Nothing : IPConn.Close : Set IPConn = Nothing
    Response.End 
%> 