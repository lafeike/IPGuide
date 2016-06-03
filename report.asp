<%@  language="VBScript" %>
<!-- #include virtual=/assets/lib/utils.asp -->
<!-- #include virtual=/assets/lib/header2.asp -->
<!-- #include virtual=/assets/lib/send_email.asp -->
<!--#include virtual="/adovbs.inc"-->

<link rel="stylesheet" media="screen" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" media="screen" href="/assets/js/guidely/guidely.css" type="text/css">
<link rel="stylesheet" media="screen" href="/assets/css/countryform.css" type="text/css">
<link rel="stylesheet" media="print" href="/assets/css/printReport.css" type="text/css">

<div class="container">
    <% dim ip_type %>
    <ul class="nav nav-pills">
      <li class="active"><a data-toggle="pill" href="#ips">IPs</a></li>
      <li><a data-toggle="pill" href="#mining">Mining</a></li>
      <li><a data-toggle="pill" href="#iso">ISO</a></li>
      <li><a data-toggle="pill" href="#convergence">Convergence</a></li>
    </ul>

    <div class="tab-content">
        <h3>Report For IP Country Request</h3>
        <h4>&nbsp;<%= Date %> &nbsp;</h4>
        <% ip_type = "IPs" %>
        <div id="ips" class="tab-pane fade in active">       
            <div class="control-group">
                <div class="row">
                    <div class="span1 offset7">
                        <a href="index.asp" class="btn">Back</a> 
                    </div>
                    <div class="span1">
                            <a href="#" class="btn exportMe" data-iptype="IPs">Export</a> 
                    </div>
                    <div class="span1">
                            <a href="#" class="btn printMe">Print</a>   
                    </div>                                       
                </div> 
            </div>
            <!--#include  virtual="./IPGuideRequest/FetchReportData.asp" -->
            <div class="control-group">
                <div class="row">
                     <div class="span1 offset7">
                        <a href="index.asp" class="btn">Back</a> 
                    </div>
                    <div class="span1">
                        <a href="#" class="btn exportMe" data-iptype="IPs">Export</a> 
                    </div>
                    <div class="span1">
                        <a href="#" class="btn printMe">Print</a>   
                    </div>              
                </div> 
            </div>
        </div>
        <div id="mining" class="tab-pane fade">
            <h3>Mining</h3>
            <h4>In constructing...</h4>
       
        </div>
        <div id="iso" class="tab-pane fade">
            <h3>ISO</h3>
            <h4>In constructing...</h4>
        
        </div>
        <div id="convergence" class="tab-pane fade">
            <h3>Convergence</h3>
              <h4>In constructing...</h4>
        
        </div>
    </div>
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
    
       
    </script>
    <script src="/assets/js/jquery.simulate.js"></script>
</body>
</html>