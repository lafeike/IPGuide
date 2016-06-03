<%@  language="VBScript" %>
<!-- #include virtual=/assets/lib/utils.asp -->
<!-- #include virtual=/assets/lib/header2.asp -->
<!-- #include virtual=/assets/lib/send_email.asp -->


<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="/assets/js/guidely/guidely.css" type="text/css">
<link rel="stylesheet" href="/assets/css/countryform.css" type="text/css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<% ' check 
    dim iptype
    iptype = Request.QueryString("iptype")   
%>

<div class="container">
    <div class="row">
        <div class="span12">
            <% 
                dim objFileSystem
                Set objFileSystem=Server.CreateObject("Scripting.FileSystemObject")
                if(objFileSystem.FileExists(Server.MapPath("/" & session("stp_companyid") & "/logo.jpg"))) then
                    Response.Write("<img src='/assets/logo/" & session("stp_companyid") & "/logo.jpg' style='padding-top:15px;padding-bottom:7px;'>")
                else
            %>
            <h3>International Protocol (IP) Guide Request</h3>
            <h4 class="countryh3"><%= Session("stp_companyname") %></h4>
            <%
                end if
            %>
        </div>
    </div>
    <hr />

   

    <h3>Search</h3>

    <div class="tab-content">
        <div id="ips" class="tab-pane fade in active">
            
            <div class="control-group">
                <div class="controls">
                    <div class="span1 offset10">
                        <a href="index.asp?iptype=<%= iptype %>" class="btn active">Back</a>
                    </div>
                </div>
            </div>
            <br>
            <hr>
        </div>
    </div>
    <form class="form-horizental container" role="form" id="searchForm">
        <div class="form-group">
            <label class="control-label col-sm-2" for="iptype">IP Type</label>
            <div class="col-sm-10">
                <div class="btn-group" data-toggle="buttons" id="iptype">
                    <label class="radio-inline">
                        <input type="radio" id="r1" name="options" value="IPs" 
                            <% 
                                    if StrComp(iptype,"IPs",1) = 0 then
                                          Response.Write("Checked")
                                    end if  
                                %>/>
                        IPs                          
                    </label>
                    <label class="radio-inline">
                        <input type="radio" id="r2" name="options" value="Mining" 
                            <% 
                                    
                            if StrComp(iptype,"Mining",1) = 0 then
                                          Response.Write("Checked")
                                    end if  
                                %>/>
                        Mining
                    </label>
                    <label class="radio-inline">
                        <input type="radio" id="r3" name="options" value="ISO" 
                            <% 
                                    if StrComp(iptype,"ISO",1) = 0 then
                                          Response.Write("Checked")
                                    end if  
                                %>/>
                        ISO
                    </label>
                    <label class="radio-inline">
                        <input type="radio" id="r4" name="options" value="Convergence" 
                            <% 
                                    if StrComp(iptype,"Convergence",1) = 0 then
                                          Response.Write("Checked")
                                    end if  
                                %>/>
                        Convergence
                    </label>
                </div>
            </div>
        </div>
        <br />
        <br />
        <div class="form-group">
            <label class="control-label col-sm-2" for="ipname">IP Name</label>
            <div class="col-sm-10">
                <select id="ipname" class="form-control"></select>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2" for="client">Client Name</label>
            <div class="col-sm-10">
                <select id="client" class="form-control"></select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label" for="rep">Rep Number</label>
            <div class="col-sm-10">
                <select id="rep" class="form-control"></select>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10 btn-group-lg">
                <button type="submit" class="btn btn-default" id="btnSearch">Search</button>
            </div>
        </div>
    </form>
    <section id="query_result"></section>
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
    // when page loaded, populdate the dropdown list for IPs ip type
    $(document).ready(function () {
       
            var jqxhr = $.getJSON("FetchSearchSelect.asp?iptype=IPs", function (data) {
                //console.log(data);
                $.each(data, function (key, val) {
                    //console.log(key);
                    $('#' + key).html(val);
                });
            })
            .fail(function (textStauts, error) {
                console.log("error:" + textStauts + ", " + error);
            });
       
       
    });


        // when iptype radio button is clicked, update the dropdown list for different ip type.
        $(":radio").change(function () {
            var iptype = $(this).attr("value")
            var jqxhr = $.getJSON("FetchSearchSelect.asp?iptype=" + iptype, function (data) {
                $.each(data, function (key, val) {
                    //console.log(key);
                    $('#' + key).html(val);
                });
            })
           .fail(function (textStauts, error) {
               console.log("error:" + textStauts + ", " + error);
           });
        });

        // button search clicked, show the query result.
        $("#searchForm").submit(function (e) {
            e.preventDefault(); // to avoid to execute the actual sumbit of the form

            var iptype = "";
            var selected = $("input[type='radio']:checked");
            if (selected.length > 0) {
                iptype = selected.val();
            }
            var ipname = "";
            var ipid = "";
            if ($('#ipname option:selected').val() != 0) {
                ipid = $("#ipname option:selected").val();
                ipname = $("#ipname option:selected").text();
            }

            var client = "";
            var clientid = "";
            if ($('#client option:selected').attr("value") != 0) {
                clientid = $("#client option:selected").val();
                client = $("#client option:selected").text();
            }

            var rep = "";
            if ($('#rep option:selected').val() != 0) {
                rep = $("#rep option:selected").text();
            }

            var data = { "iptype": iptype, "ipid":ipid, "ipname": ipname, "clientid": clientid,"client": client, "rep": rep };
            var dataFromServer;
            $.get({
                url: 'queryIPRecord.asp',
                data: data,
                success: handleData
            })

            function handleData(dataFromServer) {
                $('#query_result').html(dataFromServer);
                first = false;
            }
        });   
</script>
<script src="/assets/js/jquery.simulate.js"></script>
</body>
</html>

