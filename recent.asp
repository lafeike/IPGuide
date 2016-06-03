<%@  language="VBScript" %>
<!-- #include virtual=/assets/lib/utils.asp -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-type" content="text/html;charset=UTF-8" />
    <title>STP Online</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <link href="/assets/css/bootstrap.css" rel="stylesheet" />
    <link href="/assets/css/datepicker.css" rel="stylesheet" />
    <link href="/assets/css/docs_footer.css" rel="stylesheet" />
    <link href="/assets/css/validation.css" rel="stylesheet" />
    <style type="text/css">
        body {
            padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
        }

        ul.dropdown-menu .countrysche {
            background: #c2f2fa;
        }
    </style>
    <link href="/assets/css/bootstrap-responsive.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
    <script src="/assets/js/bootbox.min.js"></script>
    <!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->
    <!--[if lte IE 8]>
        <script src="/assets/js/html5shiv.min.js"></script>
        <script src="/assets/js/respond.min.js"></script>
    <![endif]-->
    <link rel="shortcut icon" href="/assets/ico/favicon.ico" />
</head>
<body data-spy="scroll" data-target=".subnav" data-offset="60">
    <a name="top"></a>
    


<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="/assets/js/guidely/guidely.css" type="text/css">
<link rel="stylesheet" href="/assets/css/countryform.css" type="text/css">
<style type="text/css">
    .datalist {
    }
    .divider{
        width:5px;
        height:auto;
        display:inline-block;
    }
    .modal-body {
    max-height: 520px;
    padding: 15px;
    overflow-y: auto;
}
    .modal {
    position: fixed;
    width:50%;
    top: 50%;
    left: 50%;
    margin: -300px 0 0 -400px;   
}
</style>

<div class="container">
    <div class="row">
        <div class="span12">
           
            <h3>temporily used only!</h3>
            
        </div>
    </div>
    <hr />

    <%  'SQL to get the IPGuideRequestRecord by the userid
        dim SQL
        dim UserID
        UserID = 438
        SQL = "select b.first_name first, b.last_name last,b.company company, a.auditname audit, a.clientid id,a.cssdate css, a.builddate build " &_
        "from flynn.dbo.tblcustscoresheet a " &_
        "inner join  stp_online.dbo.users b " &_
        "on a.clientid=b.userid " &_
        "where buildDate >= dateadd(day, -7, getdate()) "&_
        "order by builddate desc"

          
    %>

    <h2 style="padding-top: 15px;">Recent Request</h2>

    <div class="tab-content">
      <div id="ips" class="tab-pane fade in active">       
        <div class="control-group">
                         
        <table id="clientable" class="usertable table table-striped table-hover table-responsive">
            <thead>
                <tr>
                    <th>Client ID</th>
                    <th>Client name</th>
                    <th class="clientsort">Company</th>
                    <th>Audit Name</th>
                    <!--<th style="text-align: center">Contact number</th>-->
                    <th>CSS Date</th>                   
                    <th>Build Date</th>                   
                </tr>
            </thead>
            <tbody id="myTable">
                <%
                    
                    set rs = conn.Execute(SQL)
                    While Not rs.EOF                        
                        
                %>
                <tr <%=trclass %>>
                    <td><%=rs("id")%></td>
                    <td><%=rs("first")%>&nbsp;<%=rs("last")%></td>
                    <td><%=rs("company")%></td>
                    <td><%=rs("audit")%></td>
                   <td><%=rs("css")%> </td>
                    
                    <td><%=rs("build")%>             </td>
                </tr>
                <% 
                    rs.MoveNext
                    Wend 
                %>
            </tbody>
        </table>
        <div class="col-md-12 text-center">
            <ul class="pagination pagination-sm" id="myPager"></ul>
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
    $(document).ready(function () {
        $('#myTable').pageMe({ pagerSelector: '#myPager', showPrevNext: true, hidePageNumbers: false, perPage: 10 });
    });

    $.fn.pageMe = function (opts) {
        var $this = this,
            defaults = {
                perPage: 7,
                showPrevNext: false,
                hidePageNumbers: false
            },
            settings = $.extend(defaults, opts);

        var listElement = $this;
        var perPage = settings.perPage;
        var children = listElement.children();
        var pager = $('.pager');

        if (typeof settings.childSelector != "undefined") {
            children = listElement.find(settings.childSelector);
        }

        if (typeof settings.pagerSelector != "undefined") {
            pager = $(settings.pagerSelector);
        }

        var numItems = children.size();
        var numPages = Math.ceil(numItems / perPage);

        pager.data("curr", 0);

        if (settings.showPrevNext) {
            $('<li><a href="#" class="prev_link"><<</a></li>').appendTo(pager);
        }

        var curr = 0;
        while (numPages > curr && (settings.hidePageNumbers == false)) {
            $('<li><a href="#" class="page_link">' + (curr + 1) + '</a></li>').appendTo(pager);
            curr++;
        }

        if (settings.showPrevNext) {
            $('<li><a href="#" class="next_link">>></a></li>').appendTo(pager);
        }

        pager.find('.page_link:first').addClass('active');
        pager.find('.prev_link').hide();
        if (numPages <= 1) {
            pager.find('.next_link').hide();
        }
        pager.children().eq(1).addClass("active");

        children.hide();
        children.slice(0, perPage).show();

        pager.find('li .page_link').click(function () {
            var clickedPage = $(this).html().valueOf() - 1;
            goTo(clickedPage, perPage);
            return false;
        });
        pager.find('li .prev_link').click(function () {
            previous();
            return false;
        });
        pager.find('li .next_link').click(function () {
            next();
            return false;
        });

        function previous() {
            var goToPage = parseInt(pager.data("curr")) - 1;
            goTo(goToPage);
        }

        function next() {
            goToPage = parseInt(pager.data("curr")) + 1;
            goTo(goToPage);
        }

        function goTo(page) {
            var startAt = page * perPage,
                endOn = startAt + perPage;

            children.css('display', 'none').slice(startAt, endOn).show();

            if (page >= 1) {
                pager.find('.prev_link').show();
            }
            else {
                pager.find('.prev_link').hide();
            }

            if (page < (numPages - 1)) {
                pager.find('.next_link').show();
            }
            else {
                pager.find('.next_link').hide();
            }

            pager.data("curr", page);
            pager.children().removeClass("active");
            pager.children().eq(page + 1).addClass("active");

        }
    };

    
    $('.selectpicker').click(function (e) { // when click the dropdown list, populate it with the ipname that the client had recorded.
        e.preventDefault();
        var $this = $(this);
        var req_num = $this.attr("data-req_num");
        var client_id = $this.attr("data-clientid");
        var ip_type = $this.attr("data-iptype")

        $.get(
            "FetchIPGuideList.asp?client_id=" + client_id + "&ip_type=" + ip_type + "&req_num=" + req_num,
            function (data) {
                $this.html(data);
                $this.simulate('mousedown');
                
            });
        $this.simulate('mousedown');
    });

    $(document).on("click", "a.EditIPGuideRecord", function (e) {
        e.preventDefault();
        var client = $(this).data("client");
        var iptype = $(this).data("iptype");
        $.get("editIPGuideRecord.asp?client=" + client + "&iptype=" + iptype, function (data) {
            var div = bootbox.dialog(data,
                    [{
                        "label": "<i class='icon-zoom-in'></i> Close",
                        "class": "btn-small btn-info no-border",
                        "callback": function () {
                            window.location.reload();
                        }
                    }],
                    {
                        "onEscape": function () { div.modal("hide"); }
                    });
        })
    });

    

</script>
<script src="/assets/js/jquery.simulate.js"></script>
</body>
</html>