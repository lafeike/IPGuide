
<%
    Set AddConn = Server.CreateObject("ADODB.Connection")
    AddConn.Open  "Driver={SQL Server};" & _ 
                     "Server=10.2.1.24;" & _ 
                     "Database=STP_Online;" & _
                     "DataTypeCompatibility=80;" & _
                     "Uid=stp.sqlsa;" & _ 
                     "Pwd=#STP2011?;" 
        
    dim SQL, client, contact, contact2, userid, num, sqlCheck
   
    client = Request.Form("client")
    contact = Request.Form("contact")    
    contact2 = Request.Form("contact2")
    userid = Request.Form("userid")

    'check if client has existed.
    sqlCheck = "select count(*) as record_num from IPGuideRequestClient " &_
                      "where clientname='" & client & "'"
    set numRS = AddConn.execute(sqlCheck)
    num = numRS("record_num")

    if not num = 0 then ' client exist, return error message.
        response.Write("Error: " & client & " has existed. Cannot add again.")
    else
    
        SQL =  "insert into IPGuideRequestClient(ClientName, contact_firstname, contact_lastname, rep) " &_
                "select '" & client & "','"  & contact & "','" & contact2 & "',rep " &_
                "from IPGuideRep where userid='" & userid & "'"
    
        on error resume next
        AddConn.Execute(SQL)
        if err<>0 then
            Response.Write("Error: Failed to add the client. Please check the data and try again.")
        else
            response.Write(client & " was added successfully.")
        end if
    end if

    AddConn.Close   
    'response.End
%>