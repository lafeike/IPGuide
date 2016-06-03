<%
    Set IPConn = Server.CreateObject("ADODB.Connection")
    IPConn.Open  "Driver={SQL Server};" & _ 
       "Server=10.2.1.24;" & _ 
       "Database=STP_Online;" & _
       "DataTypeCompatibility=80;" & _
       "Uid=stp.sqlsa;" & _ 
       "Pwd=#STP2011?;"
   
    dim userid, SQL, responseHtml
    
    userid = request.QueryString("userid")
    'response.Write(userid)
    SQL = "select count(*) as rec_number " &_
                "from IPGuideRep " &_
                "where UserID= " & userid
                
    on error resume next
    Set rs = IPConn.Execute(SQL)
    
    if err<>0 then
            Response.Write("Error: System error when visit database. Please contact the IT Department.")
    else
            if rs("rec_number") = 0 then
                Response.Write("You don't have a Rep number. Some functionalities may not work properly.")
            else
                Response.Write("0")
            end if
    end if
    rs.Close : Set rs = Nothing : IPConn.Close : Set IPConn = Nothing
    Response.End 
%> 