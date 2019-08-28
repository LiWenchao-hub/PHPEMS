{x2;if:!$userhash}
{x2;include:header_table}
<style>
    .theadClassesStyle {
        font-size: 14px;
        color: #5c5c5c;
    }
</style>
<body>
{x2;include:nav}
<div class="container-fluid">
    <div class="row-fluid">
        <div class="main">
            <div class="col-xs-2" style="padding-top:10px;margin-bottom:0px;">
                {x2;include:menu}
            </div>
            <div class="col-xs-10" id="datacontent">
                {x2;endif}
                <div class="box itembox" style="margin-bottom:0px;border-bottom:1px solid #CCCCCC;">
                    <div class="col-xs-12">
                        <ol class="breadcrumb">
                            <li><a href="index.php?{x2;$_app}-app">教务中心</a></li>
                            <li class="active">学生管理&nbsp;&nbsp;/&nbsp;&nbsp;综合信息查询</li>
                        </ol>
                    </div>
                </div>
                <ul class="box itembox" style="padding-top:10px;margin-bottom:0px;">
                    <ul class="nav nav-tabs">
                        <li class="active">
                            <a href="index.php?edu-app-student-document">档案查询</a>
                        </li>
                        <li>
                            <a href="index.php?edu-app-student-info">进度查询</a>
                        </li>
                        <li>
                            <a href="index.php?edu-app-student-score">成绩查询</a>
                        </li>
                    </ul>

                    <div id="toolbar">
                        <form class="form-inline" id="query_form">
                            <div>
                                <div class="form-group">
                                    <label class="sr-only" for="product_line">姓名</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">姓名</div>
                                        <input style="width: 160px;" type="text" class="form-control"
                                               name="usertruename" id="usertruename" placeholder="请输入姓名..."/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="sr-only" for="username">身份证</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">身份证</div>
                                        <input style="width:160px;" type="text" class="form-control" name="username"
                                               id="username" placeholder="请输入身份证..."/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="sr-only" for="msg_type">学号</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">学号</div>
                                        <input style="width:160px;" type="text" class="form-control" name="normal_schID"
                                               id="normal_schID" placeholder="请输入学号...">
                                    </div>
                                </div>
                            </div>

                            <div style="margin-top:3px;">

                                <div class="form-group">
                                    <label class="sr-only" for="normal_favor">入学年级</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">年级</div>
                                        <select style="width:100px;" class="form-control" name="normal_favor"
                                                id="normal_favor">
                                            <option id="normal_favor_option_zero" value="0">不限</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="sr-only" for="normal_favor">&emsp;专业</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">&emsp;专业</div>
                                        <select style="width:180px;" class="form-control" name="userreferrer"
                                                id="userreferrer">
                                            <option value="0" id="userreferrer_option_zero">不限</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="sr-only" for="normal_favor">学习形式</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">学习形式</div>
                                        <select style="width:80px;" class="form-control" name="normal_studyType"
                                                id="normal_studyType">
                                            <option value="0">不限</option>
                                            <option value="业余">业余</option>
                                            <option value="函授">函授</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="sr-only" for="normal_favor">学习层次</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">学习层次</div>
                                        <select style="width:80px;" class="form-control" name="normal_studyLevel"
                                                id="normal_studyLevel">
                                            <option value="0">不限</option>
                                            <option value="专科">专科</option>
                                            <option value="本科">本科</option>
                                        </select>
                                    </div>
                                </div>
                                <span  style="margin-left:30px;">
                                <button  type="button"  id="query" class="btn btn-primary queryButton">查询</button>

                                <button  type="button"  id="export" class="btn btn-info queryButton">导出</button>

                                <!--<a class="btn btn-info" href="index.php?edu-app-student-documentQuery&type=1">导出</a>-->
                                    </span>
                            </div>
                        </form>
                    </div>
                    <table id="userinfo_tab" class="table table-hover"></table>
            </div>
        </div>
        {x2;if:!$userhash}
    </div>
</div>
</div>
{x2;include:footer}
</body>

<script type="text/javascript">
    $(function () {
        InitMainTable();
        setGrade();
    });

    /*这个函数的作用是得到年级数据*/
    function getGrade() {
        var grade_data = "";
        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "index.php?edu-app-message-getGrade",
            async: false,
            cache: false,
            success: function (data) {
                grade_data = data;
                // console.log(data);
            },
            error: function (data) {

            }
        });
        return grade_data;
    };

    //将年级数据循环放入下拉列表中
    function setGrade(){
        var grade_datas=getGrade();
        // console.log(grade_datas[0].planyear);
        for(var i=0;i<grade_datas.length;i++){
            $("#normal_favor_option_zero").after('<option value="'+grade_datas[i].planyear+'">'+grade_datas[i].planyear+'</option>');
        }
    };

    //选择年级下拉列表时触发事件
    $('#normal_favor').on('change',function(){
        var major_datas=getMajor();
        setMajor(major_datas);
    });

    //根据选择的年级数据,筛选除专业数据
    function getMajor(){

        var major_data = "";
        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "index.php?edu-app-message-getMajor",
            data:{
                grade:$("#normal_favor").val()
            },
            async: false,
            cache: false,
            success: function (data) {
                major_data = data;
            },
            error: function (data) {

            }
        });
        return major_data;
    }

    //将值放入年级下拉列表
    function setMajor(major_datas){
        $("#userreferrer").find("option").not(":first").remove();
        for(var i=0;i<major_datas.length;i++){
            $("#userreferrer_option_zero").after('<option value="'+major_datas[i].major+'">'+major_datas[i].major+'</option>');
        }
    }

    /*查询按钮点击事件*///search
    $("#query").click(function () {
        var fromdata = $("#query_form").serializeArray();
        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "index.php?edu-app-student-documentQuery",
            data:{
                search:fromdata
            },
            async: false,
            cache: false,
            success: function (data) {
                $('#userinfo_tab').bootstrapTable('load',data);
            },
            error: function (data) {
            }
        });
    });

    /*导出按钮点击事件*///search
    $("#export").click(function () {
        var fromdata = $("#query_form").serializeArray();
        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "index.php?edu-app-student-documentQuery",
            data:{
                search:fromdata,
                type:"1"
            },

            success: function (data) {
                document.location.href =(data.url);
            },
            error: function (data) {
            }
        });
    });



    var $table; //记录页面bootstrap-table全局变量$table，方便应用

    //初始化bootstrap-table的内容
    function InitMainTable() {
        var queryUrl = 'index.php?edu-app-student-documentQuery';
        var fromdata = $("#query_form").serializeArray();
        $table = $('#userinfo_tab').bootstrapTable({
            url: queryUrl,                      //请求后台的URL（*）
            method: 'POST',                      //请求方式（*）
            toolbar: '#toolbar',              //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                      //初始化加载第一页，默认第一页,并记录
            pageSize: 10,                     //每页的记录行数（*）
            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
            // search: true,                      //是否显示表格搜索
            // strictSearch: true,
            // showColumns: true,                  //是否显示所有的列（选择显示的列）
            // showRefresh: true,                  //是否显示刷新按钮
            // minimumCountColumns: 2,             //最少允许的列数
            // clickToSelect: true,                //是否启用点击选中行
            height: 500,                      //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "userid",                     //每一行的唯一标识，一般为主键列
            // showToggle: true,                   //是否显示详细视图和列表视图的切换按钮
            // cardView: true,                    //是否显示详细视图
            // detailView: true,                  //是否显示父子表
            // //得到查询的参数
            // contentType: "application/x-www-form-urlencoded; charset=UTF-8",

            queryParams: function (params) {

            },
            rowStyle: rowStyle,//设置行样式
            theadClasses: 'theadClassesStyle',
            columns: [{
                checkbox: false,
                visible: false                  //是否显示复选框
            }, {
                field: 'usertruename',
                title: '姓名',
                width: 150
            }, {
                field: 'normal_schID',
                title: '学号',
                sortable: true,
                width: 150
            }, {
                field: 'username',
                title: '身份证号码',
                width: 200
            }, {
                field: 'userreferrer',
                title: '专业',
                width: 250
            }, {
                field: 'normal_favor',
                title: '年级',
                sortable: true
            }, {
                field: 'normal_studyLevel',
                title: '学习层次'
            }, {
                field: 'normal_studyType',
                title: '学习形式'
            }, {
                field: 'mobile',
                title: '电话'
            }, {
                field: 'userid',
                title: '操作',
                width: 200,
                align: 'center',
                valign: 'middle',
                formatter: linkFormatter
            },],


            onLoadSuccess: function (data) {

            },

            onLoadError: function () {
                showTips("数据加载失败！");
            },
        });
    };


    function linkFormatter(value, row, index) {

        str = "<a class=\"label label-primary\" onclick=\"selectUserLink("+value+");\" '>查看档案</a>"

        return str;

    }

    function selectUserLink(value) {
        location.href ="index.php?edu-app-student-show&userid="+value;
    }

    function rowStyle(row, index) {
        var style = { };
        style ={css:{'font-size':'12px'}};
        return style;
    }

</script>
</html>
{x2;endif}