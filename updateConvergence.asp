<!--
    date: 2016-12-9
    author: Rafy Zhao
    description: 
        - when user click the checkbox after the IP name, update the database table IPGuideRequestRecord.
        - to be called by /IPGuideRequest/editConvergence.asp
-->

<!-- #include virtual=/assets/lib/utils.asp -->

<%
    ip_name = request("ip_name")
    client_id = request("client_id")
    c_flag = request("c_flag")
    ip_id = request("ip_id")
        
   Response.Write("ip_name is:" & ip_name)
	' to check if there is records of this ip
    SQL = 	"select count(*) record_num from IPGuideRequestRecord " &_
            "where client_id=" & client_id &_
            " and ip_id = " & ip_id &_
            " and iptype='Convergence' " &_
            " and dual_language=" &c_flag
    Response.Write("select SQL: " & SQL)
    set numRS = conn.execute(SQL)
    num = numRS("record_num")

    dim updateRecord 

    if num = 0 then ' no record, then insert one.
        updateRecord = "insert into IPGuideRequestRecord(ip_id, client_id, iptype,dual_language) " &_
                        "values(" & ip_id &_
                        "," & client_id &_
                        ", 'Convergence'," &_
                         c_flag & ")"
    else ' has a record, then delete it.
        updateRecord = "delete from IPGuideRequestRecord where " &_
                        "ip_id=" & ip_id &_
                        " and client_id=" & client_id &_
                        " and iptype='Convergence' " &_
                        " and dual_language=" &c_flag
    end if
    Response.Write("updatet SQL: " & updateRecord)
    conn.execute(updateRecord)
%>