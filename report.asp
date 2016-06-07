<%@  language="VBScript" %>
<!-- #include virtual=/assets/lib/utils.asp -->
<!-- #include virtual=/assets/lib/header2.asp -->
<!--#include virtual="/adovbs.inc"-->

<link rel="stylesheet" media="screen" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" media="print" href="/assets/css/printReport.css" type="text/css">

<% 
    dim ip_type
    iptype = Request.QueryString("iptype")
    
    if len(iptype) = 0 then
            iptype = "IPs" 'default value
    end if
%>
<div id="reportContainer" class="container" data-iptype="<%= iptype %>"">
    <ul class="nav nav-pills">
      <li><a <% if strcomp(iptype, "IPs") = 0 then
          Response.write("active")
          end if          
           %> data-toggle="pill" href="#IPs">IPs</a></li>
      <li><a <% if strcomp(iptype, "Mining") = 0 then
          Response.write("active")
          end if          
           %> data-toggle="pill" href="#Mining">Mining</a></li>
      <li><a <% if strcomp(iptype, "ISO") = 0 then
          Response.write("active")
          end if          
           %> data-toggle="pill" href="#ISO">ISO</a></li>
      <li><a <% if strcomp(iptype, "Convergence") = 0 then
          Response.write("active")
          end if          
           %> data-toggle="pill" href="#Convergence">Convergence</a></li>
    </ul>

    <div class="tab-content">
        <h3>Report For &nbsp;<%= iptype %>&nbsp; Country Request</h3>
        <h4>&nbsp;<%= Date %> &nbsp;</h4>
        <div class="control-group">
                <div class="row">
                    <div class="span1 offset7">
                        <a href="index.asp" class="btn" id="backBtn">Back</a> 
                    </div>
                    <div class="span1">
                            <a href="#" class="btn exportMe">Export</a> 
                    </div>
                    <div class="span1">
                            <a href="#" class="btn printMe">Print</a>   
                    </div>                                       
                </div> 
        </div>
        
        
        <div id="IPs" class="tab-pane fade in active"></div> 
         <div id="Mining" class="tab-pane fade in active"></div> 
         <div id="ISO" class="tab-pane fade in active"></div> 
         <div id="Convergence" class="tab-pane fade in active"></div>  
         <!--#include  virtual="./IPGuide/FetchReportData.asp" -->                
             <form id="reloadForm" method="get" action="report.asp">
                 <input type="hidden" name="iptype" id="hiddenIPtype" />
                 <input type="hidden" name="displayNum" id="hiddenNum"/>
             </form>
    </div>
</div>
<!-- /container -->
<!-- #include virtual=/assets/lib/footer.asp -->
    
    <script type="text/javascript">
        $(document).ready(function () {
            var activeTabName = $('#reportContainer').attr("data-iptype");
            var activeItem = 'li:has(a[href="#' + activeTabName + '"])';
            $(activeItem).addClass("active");
            //activeTab(activeTabName);
        });

        $('.printMe').click(function () {
           window.print();
        });

        $('.exportMe').click(function () {
            var href = "ExportReportData.asp?iptype=";
            href = href.concat( $('#reportContainer').attr("data-iptype"));
            href = href.concat("&displayNum=");
            var displayNum = $('#displayNum').val();
            href = href.concat(displayNum);
            window.location.href = href;
        });

        // when tab changed, set search button's link attribute.
        $('a[data-toggle="pill"]').on('shown.bs.tab', function (e) {
            e.preventDefault();
            var target = $(e.target).attr("href") // activated tab        
            $('#backBtn').attr("href", "index.asp?iptype=" + target.substring(1)); // skip the '#'
            $('#reportContainer').attr("data-iptype", target.substring(1));
            $('#hiddenNum').val($('#displayNum').val());
            $('#hiddenIPtype').val(target.substring(1));
            $('#reloadForm').submit();
        });

        function activeTab(tab) {
            $('.nav-pills a[href="#' + tab + '"]').tab('show');
            var activeItem = 'li:has(a[href="#' + tab + '"])';
            $(activeItem).addClass("active");
        };
    </script>
</body>
</html>