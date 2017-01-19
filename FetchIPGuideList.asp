<%@  language="VBScript" %>

<%
    Set IPConn = Server.CreateObject("ADODB.Connection")
    IPConn.Open  "Driver={SQL Server};" & _ 
       "Server=10.2.1.24;" & _ 
       "Database=STP_Online;" & _
       "DataTypeCompatibility=80;" & _
       "Uid=stp.sqlsa;" & _ 
       "Pwd=#STP2011?;" 
      
    dim querynum, query, reponseHtml
    
    querynum = "select count(*) as req_num from IPGuideRequestRecord "&_
                "where client_id ="  &  Request.QueryString("client") &_
                " and iptype='" & Request.QueryString("iptype") & "'"
    'response.Write(querynum)
    Set rsNum = IPConn.Execute(querynum)

    responseHtml = rsNum("req_num")

    Response.Write(responseHtml)
   
    rsNum.Close : Set rsNum = Nothing : IPConn.Close : Set IPConn = Nothing
    Response.End 
%> 