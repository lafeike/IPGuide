<%@  language="VBScript" %>
<!-- #include virtual=/assets/lib/utils.asp -->
<!-- #include virtual=/assets/lib/header2.asp -->
<!--#include virtual="/adovbs.inc"-->
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" media="screen" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" media="screen" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css">
<link rel="stylesheet" media="screen" href="https://cdn.datatables.net/buttons/1.2.2/css/buttons.dataTables.min.css">
<link rel="stylesheet" media="print" href="/assets/css/printReport.css" type="text/css">
<style type="text/css">   
   .nav-pills a[href="#IPs"] {
       background-color:aquamarine;
   }

   .nav-pills a[href="#Mining"] {
       background-color:aqua;
   }

   .nav-pills a[href="#ISO"] {
       background-color:burlywood;
   }

   .nav-pills a[href="#Convergence"] {
       background-color:gold;
   }

   .nav-pills a[href="#Reg"] {
       background-color:lime;
   }

   .loadmodal {
        display:    none;
        position:   fixed;
        z-index:    1000;
        top:        0;
        left:       0;
        height:     100%;
        width:      100%;
        background: rgba( 255, 255, 255, .8 ) 
                    url('../assets/img/ajax-loader.gif') 
                    50% 50% 
                    no-repeat;
    }

    /* When the body has the loading class, we turn
       the scrollbar off with overflow:hidden */
    body.loading {
        overflow: hidden;   
    }

    /* Anytime the body has the loading class, our
       modal element will be visible */
    body.loading .loadmodal {
        display: block;
    }
</style>

<% 
    dim ip_type
    iptype = Request.QueryString("iptype")
        
    if len(iptype) = 0 then
            iptype = "IPs" 'default value
    end if
%>
<div id="reportContainer" class="container" data-iptype="<%= iptype %>"">
    <ul class="nav nav-pills">
      <li><a  
          <% 
          if strcomp(iptype, "IPs") = 0 then
            Response.write("active")
          end if 
          %>         
          data-toggle="pill" href="#IPs">IPs</a></li>
      <li><a  
              <% 
              if strcomp(iptype, "reg") = 0 then
                Response.write("active")
              end if 
              %>         
              data-toggle="pill" href="#Reg">REG Tracking</a></li>
      <li><a 
          <% 
          if strcomp(iptype, "Mining") = 0 then
            Response.write("active")
          end if          
          %> 
          data-toggle="pill" href="#Mining">Mining</a></li>
      <li><a 
          <% 
          if strcomp(iptype, "ISO") = 0 then
            Response.write("active")
          end if          
          %> 
          data-toggle="pill" href="#ISO">ISO</a></li>
      <li><a 
          <% if strcomp(iptype, "Convergence") = 0 then
            Response.write("active")
          end if          
          %> 
          data-toggle="pill" href="#Convergence">Convergence</a></li>
    </ul>
    <div class="control-group">
        <div class="row">
                <div class="span1 offset11">
                    <a href="index.asp" class="btn" id="backBtn">Back</a> 
                </div>
                
               <!-- <div class="span1">
                    <a href="#" class="btn printMe">Print</a>   
                </div>   -->                                    
        </div> 
     </div>
     <div class="form-group">
                    <input type="radio" name="reportType" value="country" checked> Report by country
                    &nbsp; <input type="radio" name="reportType" value="client"> Report by company
        </div>
    <div class="tab-content">
        <header style="display: block; text-align: center;">
            <h3>Report For <strong id="h3_iptype"></strong> Country Request</h3>
            <h4>&nbsp;<%= Date %> &nbsp;</h4>
        </header>     
        <div id="reportTable"></div>
    </div>
</div>
<div class="loadmodal"><!-- Place at bottom of page --></div>
<!-- /container -->
<!-- #include virtual=/assets/lib/footer.asp -->
    <script src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.2.2/js/dataTables.buttons.min.js"></script>
    <script src="//cdn.datatables.net/buttons/1.2.2/js/buttons.flash.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
    <script src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/pdfmake.min.js"></script>
    <script src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/vfs_fonts.js"></script>
    <script src="//cdn.datatables.net/buttons/1.2.2/js/buttons.html5.min.js"></script>
    <script src="//cdn.datatables.net/buttons/1.2.2/js/buttons.print.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            var activeTabName = $('#reportContainer').attr("data-iptype");            
            activeTab(activeTabName);            

            // radio button 'reportType' changed
            $('input[type=radio][name=reportType]').change(function () {
                var reportType = $('input[name=reportType]:radio:checked').val();
                var iptype = $("#reportContainer").attr("data-iptype");
                activeTab(iptype)
                fetchReportData(reportType, iptype);                
            });
        });

        $body = $("body");
        $(document).on({
            ajaxStart: function () { $body.addClass("loading"); },
            ajaxStop: function () { $body.removeClass("loading"); }
        });

        function fetchReportData(reportType, iptype) {
            console.log("iptype = " + iptype);
            $.ajax({
                url: "FetchReportData.asp",
                type: "POST",
                data: { iptype: iptype, reportType: reportType },
                error: function (xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert(err.Message);
                },
                success: function (dataFromServer) {
                    if (dataFromServer.indexOf("Error") == -1) {
                        $('#reportTable').html(dataFromServer);
                        $('#clientable').DataTable({
                            dom: 'Bfrtip',
                            buttons: [
                                    {
                                        extend: 'excelHtml5',
                                        title: 'IP Request',
                                        text: 'Export to Excel'
                                    },
                                    {
                                        extend: 'print',
                                        text: 'Print Content',
                                        autoPrint: false
                                    }
                            ]
                        });
                    }
                    else {
                        $('#reportTable').html(dataFromServer);
                    }
                }
            });
        }

        window.onload = function () {            
            var reportType = "country";
            var activeTabName = $('#reportContainer').attr("data-iptype");
            fetchReportData(reportType, activeTabName);           
        }

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
            var reportType = $('input[name=reportType]:radio:checked').val();
            var iptype = target.substring(1);
            activeTab(iptype);
            fetchReportData(reportType, iptype);
        });

        function activeTab(tab) {
            //alert("tab: " + tab);
            if (tab == 'Reg') {
                $('header h3').html("Report for REG Tracking");
            }
            else {
                $('header h3').html("Report for " + tab);
            }
            var activeItem = 'li:has(a[href="#' + tab + '"])';
            $(activeItem).addClass("active");
            $('.nav-pills a[href="#' + tab + '"]').tab('show');           
        };

        // Wait for window load
        $(window).load(function () {
            // Animate loader off screen
            $(".se-pre-con").fadeOut("slow");;
        });
    </script>
</body>
</html>