<!--
    date: 2016-5-19
    author: Rafy Zhao
    description: 
        - when user click the checkbox after the IP name, update the database table IPGuideRequestRecord.
        - to be called by /IPGuideRequest/editIPGuideRecord.asp
-->

<!-- #include virtual=/assets/lib/utils.asp -->

<%
    ip_name = request("ip_name")
    client_id = request("client_id")
    ip_type = request("ip_type")
    ip_id = request("ip_id")
        
   
	' to check if there is records of this ip
    SQL = 	"select count(*) record_num from IPGuideRequestRecord " &_
            "where client_id=" & client_id &_
            " and ip_id = " & ip_id &_
            " and iptype='" & ip_type &_
            "'"
    
    set numRS = conn.execute(SQL)
    num = numRS("record_num")

    dim updateRecord 

    if num = 0 then ' no record, then insert one.
        updateRecord = "insert into IPGuideRequestRecord(ip_id, client_id, iptype) " &_
                        "values(" & ip_id &_
                        "," & client_id &_
                        ", '" & ip_type & "')" 
    else ' has a record, then delete it.
        updateRecord = "delete from IPGuideRequestRecord where " &_
                        "ip_id=" & ip_id &_
                        " and client_id=" & client_id &_
                        " and iptype='" & ip_type & "'"
    end if
    
    conn.execute(updateRecord)
    Response.Write(ip_name & " is updated.")  
%>