<%@  language="VBScript" %>
<!-- #include virtual=/assets/lib/utils.asp -->
<!-- #include virtual=/assets/lib/header2.asp -->
<!--#include virtual="/adovbs.inc"-->

<link rel="stylesheet" media="screen" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

<div class="container">
    <%  'SQL to get the IPGuideRequestRecord by the userid       
        dim UserID, iptype
        UserID = Session("stp_userid")       
        iptype = Request.QueryString("iptype")
    %>

        <h3>Add A Client</h3>
        
        <div class="control-group">
                <div class="row">
                    <div class="span2 offset8">
                        <a href="index.asp"  class="btn">Go Back</a>
                    </div>                              
                </div> 
            </div>
            
            <form class="form-horizental container" role="form" id="addForm">
                 <div class="form-group">
                    <label for="inputClient" class="control-label col-xs-2">Client</label>
                    <div class="col-xs-10">
                        <input type="text" class="form-control" 
                            id="inputClient" name="client" placeholder="Company name" 
                            required pattern=".{1,50}" title="50 characters maximum">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputContact" class="control-label col-xs-2">Contact Name</label>
                    <div class="col-xs-10">
                        <input type="text" class="form-control" id="inputContact" name="contact" placeholder="Contact name"
                            pattern=".{0,50}" title="50 characters maximum" >
                    </div>
                </div>
                 <div class="form-group">
                    <label for="input2contact" class="control-label col-xs-2">Contact 2 Name</label>
                    <div class="col-xs-10">
                        <input type="text" class="form-control" id="input2contact" name="contact2contact" 
                            placeholder="Contact name"
                            pattern=".{0,50}" title="50 characters or numbers maximum">
                        <input type="hidden" value=<%=UserID %> id="inputUserid" name="userid" >
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-xs-offset-5 col-xs-7">
                        <button type="submit" class="btn btn-primary">Confirm</button>
                    </div>
                </div>
            </form>
            
</div>
<!-- /container -->
<!-- #include virtual=/assets/lib/footer.asp -->
    <%
        set cmd = nothing
        checkSession.Close
        conn.Close
        set checkSession = nothing
        set conn = nothing
    %>
    <script type="text/javascript">
        $('.printMe').click(function () {
           window.print();
        });

        $('.exportMe').click(function () {
            var href = "ExportReportData.asp?iptype=";
            href = href.concat($(this).attr("data-iptype"));
            href = href.concat("&displayNum=");
            var displayNum = $('#displayNum').val();
            href = href.concat(displayNum);
            window.location.href = href;
        });

        // button add clicked, save the client data.
        $("#addForm").submit(function (e) {
            e.preventDefault(); // to avoid to execute the actual sumbit of the form

            var client, contact, contacNumber, userid;
            client = $("#inputClient").val();
            contact = $("#inputContact").val();
            contact2 = $("#input2contact").val();          

            userid = $("#inputUserid").val();

           var data = { "client": client, "contact": contact, "contact2": contact2, "userid": userid };
           var dataFromServer;
           $.ajax({
               url: "AddClientData.asp",
               type: "POST",
               data: data,
               error: function (xhr, status, error) {
                   var err = eval("(" + xhr.responseText + ")");
                   alert(err.Message);
               },
               success: function (dataFromServer) {
                   alert(dataFromServer);
                   //console.log(dataFromServer);
                   if (dataFromServer.indexOf("Error") === -1) {
                       clearInput();
                   }                       
               }
           })           
        });

        function clearInput() {
            $(':input')
                .not(':button, :submit, :hidden')
                .val('');
        } 
    </script>
   
</body>
</html>