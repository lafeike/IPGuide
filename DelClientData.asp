
<%
    Set DelConn = Server.CreateObject("ADODB.Connection")
    DelConn.Open  "Driver={SQL Server};" & _ 
                     "Server=10.2.1.24;" & _ 
                     "Database=STP_Online;" & _
                     "DataTypeCompatibility=80;" & _
                     "Uid=stp.sqlsa;" & _ 
                     "Pwd=#STP2011?;" 
        
    dim SQL, clientid, num, sqlCheck
   
    clientid = Request.Form("client")   

    ' to check if there is records of this ip
    sqlCheck = 	"select count(*) record_num from IPGuideRequestRecord " &_
            "where client_id=" & clientid
    'response.Write sqlCheck
    set numRS = DelConn.execute(sqlCheck)
    num = numRS("record_num")

    if num > 0 then ' no record, then delete.
        Response.Write("Error: You cannot delete a client with request record. Please delete the records first.")
        Response.AppendToLog("Error: You cannot delete a client with request record. Please delete the records first.")
    else
        SQL =  "delete from IPGuideRequestClient " &_
                    "where id=" & clientid 
    
        on error resume next
        DelConn.Execute(SQL)
        if err<>0 then
                Response.Write("Error: Failed to delete the client. Please check the data and try again.")
                Response.AppendToLog("Error: Failed to delete the client. Please check the data and try again.")
        else
                response.Write("Client was deleted.")
        end if
    end if   

    DelConn.Close   
    'response.End
%>