
<%
    Set DelConn = Server.CreateObject("ADODB.Connection")
    DelConn.Open  "Driver={SQL Server};" & _ 
                     "Server=10.2.1.24;" & _ 
                     "Database=STP_Online;" & _
                     "DataTypeCompatibility=80;" & _
                     "Uid=stp.sqlsa;" & _ 
                     "Pwd=#STP2011?;" 
        
    dim SQL, clientid, num, sqlCheck
   
    clientid = Request.Form("clientid")   
    contact = Request.Form("contact")
    contact2 = Request.Form("contact2")
    rep = Request.Form("rep")

    ' to check if there is records of this ip
    sqlUpdate = "update IPGuideRequestClient " &_
            "set contact_firstname='" & contact &_
            "', contact_lastname='" &contact2 &_
            "', rep='" &rep &_
            "' where id=" & clientid
    
    on error resume next
    DelConn.execute(sqlUpdate)
   
        if err<>0 then
                Response.Write("Error: Failed to update. Please check the data and try again.")
                Response.AppendToLog("Error: Failed to update the contact. Please check the data and try again.")
        else
                response.Write("data updated.")
        end if
 

    DelConn.Close   
    'response.End
%>