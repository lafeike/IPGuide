<%@  language="VBScript" %>

<!--
    date: 2016-5-19
    author: Rafy Zhao
    description: 
        - when user clicks the dropdown list in the IPGuideRequest page, populate the data in that dropdown list.
        - to be called by /IPGuideRequest/index.asp
-->

<%
    Set IPConn = Server.CreateObject("ADODB.Connection")
    IPConn.Open  "Driver={SQL Server};" & _ 
       "Server=10.2.1.24;" & _ 
       "Database=STP_Online;" & _
       "DataTypeCompatibility=80;" & _
       "Uid=stp.sqlsa;" & _ 
       "Pwd=#STP2011?;" 
      
    dim query, reponseHtml
   
    responseHtml = "<option>" & Request.QueryString("req_num") & "</option>"

    query = "SELECT ipname FROM IPGuide " &_
            "WHERE id in " &_
            "(select ip_id from IPGuideRequestRecord " &_ 
            " where client_id ="  &  Request.QueryString("client_id") &_
            " and iptype='" & Request.QueryString("ip_type") &_
             "')"
    'responseHtml = responseHtml & "<option>" & query & "</option>"
    Set rs = IPConn.Execute(query)
    While Not rs.EOF   
        responseHtml = responseHtml & "<option>" & rs("ipname") & "</option>"
        rs.MoveNext
    Wend
    Response.Write(responseHtml)
   
    rs.Close : Set rs = Nothing : IPConn.Close : Set IPConn = Nothing
    Response.End 
%> 