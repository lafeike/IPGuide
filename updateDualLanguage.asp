<!--
    date: 2016-5-19
    author: Rafy Zhao
    description: 
        - when user click the checkbox after the IP name, update the database table IPGuideRequestRecord.
        - to be called by /IPGuideRequest/editIPGuideRecord.asp
-->

<!-- #include virtual=/assets/lib/utils.asp -->

<%
    client_id = request("client_id")
    ip_id = request("ip_id")
    dual_language = request("dual_language")       
    
    dim updateRecord 
  
    updateRecord = "update IPGuideRequestRecord set dual_language='" & dual_language &_
                         "' where ip_id=" & ip_id &_
                         " and client_id=" & client_id    
    response.Write(updatRecord)
    conn.execute(updateRecord)
    Response.Write(ip_name & " is updated.")  
%>