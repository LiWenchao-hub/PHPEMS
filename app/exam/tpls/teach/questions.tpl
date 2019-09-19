{x2;if:!$userhash}
{x2;include:header_table}
<style>
    .theadClassesStyle {
        font-size: 14px;
        color: #5c5c5c;
    }

    .theadClassesStyle_sub {
        font-size: 10px;
        color: #5c5c5c;
    }

    .card-view-title {
        font-size: 8px;
    }

    .card-view-value {
        font-size: 10px;
    }

    .bootstrap-table .fixed-table-toolbar .bs-bars {
        width: 100%;
    }

    .bootstrap-table .fixed-table-toolbar .bs-bars, .bootstrap-table .fixed-table-toolbar .search, .bootstrap-table .fixed-table-toolbar .columns {
        margin-bottom: 2px;
    }

    .input-group-addon {
        /*background:#337ab7;*/
        /*color: #ffffff*/
    }

    .form-control {
        height: 30px;
        font-size: 12px;
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
                            <!--<li><a href="index.php?{x2;$_app}-teach">{x2;$apps[$_app]['appname']}</a></li>-->
                            <li><a href="index.php?{x2;$_app}-teach">教师中心</a></li>
                            <li class="active">试题管理</li>
                        </ol>
                    </div>
                </div>
                <div class="box itembox" style="">
                    <div id="toolbar">
                        <form class="form-inline" id="query_form">
                            <div>

                                <div class="form-group">

                                    <label class="sr-only" for="questionsubjectid">所属科目</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">所属科目</div>
                                        <select style="width: 180px;" class="form-control" name="questionsubjectid"
                                                id="questionsubjectid">
                                            <option id="subject_option_zero" value="0">不限</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="sr-only" for="questionknowsid">知识点</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">知识点</div>
                                        <select style="width: 120px;" class="form-control" name="questionknowsid"
                                                id="questionknowsid">
                                            <option id="questionknows_option_zero" value="0">不限</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="sr-only" for="normal_favor">试题类型</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">试题类型</div>
                                        <select style="width: 120px;" class="form-control" name="questiontype"
                                                id="questiontype">
                                            <option value="0" id="questiontype_option_zero">不限</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="sr-only" for="questionlevel">试题难度</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">试题难度</div>
                                        <select style="width: 120px;" class="form-control" name="questionlevel"
                                                id="questionlevel">
                                            <option value="0">不限</option>
                                            <option value="1">易</option>
                                            <option value="2">中</option>
                                            <option value="3">难</option>
                                        </select>
                                    </div>
                                </div>
                                <!--<div class="form-group">
                                    <label class="sr-only" for="questionusername">&emsp;录入人</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">&emsp;录入人</div>
                                        <input style="width:180px;" type="text" class="form-control"
                                               name="questionusername" id="questionusername" placeholder="请输入录入人..."/>
                                    </div>
                                </div>-->

                                <hr style="margin-top:5px;padding:0px;background: #337ab7;border:none;height:1px;">
                                <div style="float: right;margin-right:20px;" class="btn-group">
                                    <button type="button" id="query" class="btn btn-primary  btn-sm">&emsp;<span
                                                class='glyphicon glyphicon-search'></span>&nbsp;查询&emsp;
                                    </button>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-success  btn-sm dropdown-toggle"
                                                data-toggle="dropdown">
                                            &emsp;<span class='glyphicon glyphicon-plus'></span>&nbsp;新增
                                            <span class="caret"></span>&emsp;
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li><a href="index.php?{x2;$_app}-teach-questions-addquestion&page={x2;$page}{x2;$u}">单题添加</a></li>
                                            <li><a href="index.php?{x2;$_app}-teach-questions-filebataddquestion&page={x2;$page}{x2;$u}">批量导入</a></li>
                                        </ul>
                                    </div>
                                    <button type="button" id="batchdelbtn" name="batchdelbtn" class="btn btn-danger btn-sm"><span
                                                class='glyphicon  glyphicon-trash'></span>&nbsp;批量删除
                                    </button>
                                </div>

                            </div>
                        </form>

                    </div>

                    <table id="questioninfo_tab" class="table table-hover"></table>
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
        setQuestionTypeList();
        setSubject();
    });
    /*查询按钮点击事件*///search
    $("#query").click(function () {
        $('#questioninfo_tab').bootstrapTable(('refresh'));
        $("#query_form").serializeArray();
    });

    //将试题类型放入下拉列表中
    function setQuestionTypeList() {
        var $questions_type_lists = getQuestionType();
        for (var i = 0; i < $questions_type_lists.length; i++) {
            $("#questiontype_option_zero").after('<option value="' + $questions_type_lists[i].questid + '">' + $questions_type_lists[i].questype + '</option>');
        }
    }

    //科目
    function setSubject() {
        var subject_datas = getSubject();
        // console.log(subject_datas);
        for (var i = 0; i < subject_datas.length; i++) {
            $("#subject_option_zero").after('<option value="' + subject_datas[i].subjectid + '">' + subject_datas[i].subject + '</option>');
        }
    }



    //得到科目列表信息
    function getSubject() {
        var subject_data = "";
        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "index.php?exam-teach-questions-getSubject",
            async: false,
            cache: false,
            success: function (data) {
                subject_data = data;
            },
            error: function (data) {

            }
        });
        return subject_data;
    }

    //初始化questiontype
    function getQuestionType() {
        var questiontype_data = "";
        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "index.php?exam-teach-questions-getQuestionType",
            async: false,
            cache: false,
            success: function (data) {
                questiontype_data = data;
            },
            error: function (data) {

            }
        });
        return questiontype_data;
    };


    //当科目改变时候触发的事件
    $('#questionsubjectid').on('change', function () {
        $("#questionknows_option_zero").nextAll().remove();
        // $("#questionsubjectid").val("0");
        var questionsubjectid = $("#questionsubjectid").val();
        var questionknows_data = getQuestionknows(questionsubjectid);
        setQuestionknows(questionknows_data);
    });

    function setQuestionknows(questionknows_data) {
        for (var i = 0; i < questionknows_data.length; i++) {
            $("#questionknows_option_zero").after('<option value="' + questionknows_data[i].knowsid + '">' + questionknows_data[i].knows + '</option>');
        }
    }

    //初始化知识点
    function getQuestionknows(questionsubjectid) {
        var questionknows_data = "";
        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "index.php?exam-teach-questions-getQuestionknows",
            async: false,
            cache: false,
            data: {
                questionsubjectid: questionsubjectid
            },
            success: function (data) {
                questionknows_data = data;
            },
            error: function (data) {

            }
        });
        return questionknows_data;
    };


    toastr.options = {
        "closeButton": false, //是否显示关闭按钮
        "debug": false, //是否使用debug模式
        "positionClass": "toast-top-full-width",//弹出窗的位置
        "showDuration": "300",//显示的动画时间
        "hideDuration": "1000",//消失的动画时间
        "timeOut": "2000", //展现时间
        "extendedTimeOut": "1000",//加长展示时间
        "showEasing": "swing",//显示时的动画缓冲方式
        "hideEasing": "linear",//消失时的动画缓冲方式
        "showMethod": "fadeIn",//显示时的动画方式
        "hideMethod": "fadeOut" //消失时的动画方式
    };


    var $table; //记录页面bootstrap-table全局变量$table，方便应用


    //初始化bootstrap-table的内容
    function InitMainTable() {
        var queryUrl = 'index.php?exam-teach-questions-queryQuestionsData';
        // var fromdata = $("#query_form").serializeArray();
        $table = $('#questioninfo_tab').bootstrapTable({
            url: queryUrl,                       //请求后台的URL（*）
            method: 'get',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            // toolbarAlign:'right',               //工具栏对齐方式
            // buttonsAlign:'right',               //按钮对齐方式
            striped: true,                      //是否显示行间隔色
            cache: true,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            // sortable: true,                     //是否启用排序
            // sortOrder: "asc",                   //排序方式
            sidePagination: "server",           //分页方式:client客户端分页,server服务端分页
            pageNumber: 1,                      //初始化加载第一页,默认第一页,并记录
            pagination: true,                    //是否分页
            queryParamsType: 'limit',
            queryParams: queryParams,
            pageSize: 10,                       //每页的记录行数
            pageList: [10, 25, 50, 100],        //可供选择的每页的行数
            // search: true,                    //是否显示表格搜索
            // strictSearch: true,
            // showColumns: true,                  //是否显示所有的列（选择显示的列）
            // showRefresh: true,                  //是否显示刷新按钮
            // minimumCountColumns: 2,             //最少允许的列数
            // clickToSelect: true,                //是否启用点击选中行
            height: 500,                           //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "questionid",                //每一行的唯一标识，一般为主键列
            // showToggle: true,                   //是否显示详细视图和列表视图的切换按钮
            // cardView: true,                    //是否显示详细视图
            detailView: true,                  //是否显示父子表
            // //得到查询的参数
            // contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            //注册加载子表的事件.注意下这里的三个参数!row会传递数据到子表.
            onExpandRow: function (index, row, $detail) {
                InitSubTable(index, row, $detail);
            },

            //处理服务器返回的数据
            responseHandler: function (result) {

                if (result.total != 0) {
                    var row = result.rows;
                    return {
                        "rows": row,
                        "total": result.total
                    };

                } else {
                    return {
                        "rows": [],
                        "total": 0
                    };
                }
            },
            rowStyle: rowStyle,//设置行样式
            theadClasses: 'theadClassesStyle',
            columns: [{
                checkbox: true,
                visible: true                  //是否显示复选框
            }, {
                field: 'num',
                title: '序号'
            }, {
                field: 'questionid',
                title: '试题ID',
                width: 100
            }, {
                field: 'question',
                title: '试题内容',
                formatter: questionhandler,
                width: 200
            }, {
                field: 'questionusername',
                title: '录入人/录入时间',
                width: 150,
                formatter: inputpersonhandler
            }, {
                field: 'questiondeler',
                title: '删除人/删除时间',
                width: 150,
                formatter: removepersonhandler
            }, {
                field: 'questionlevel',
                title: '难度',
                align: 'center',
                formatter: questionlevelhandler
            }, {
                field: 'questionid',
                title: '操作',
                width: 200,
                align: 'center',
                valign: 'middle',
                formatter: linkFormatter
            },],


            onLoadSuccess: function (data) {

            },

            onLoadError: function () {

            },
        });

        //请求服务数据时所传参数
        function queryParams(params) {
            return {
                //每页多少条数据
                pageSize: params.limit,
                //从那条数据开始
                offset: params.offset,
                search: $("#query_form").serializeArray()
            }
        };

        //初始化子表格(无线循环)
        InitSubTable = function (index, row, $detail) {
            var questionid = row.questionid;
            var curtable = $detail.html('<table ></table>').find('table');
            $(curtable).bootstrapTable({
                url: 'index.php?exam-teach-questions-ajaxDetail',
                method: 'POST',
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                queryParams: {questionid: questionid},
                ajaxOptions: {questionid: questionid},
                striped: true,                      //是否显示行间隔色
                cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                pagination: false,                   //是否显示分页（*）
                sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）
                uniqueId: "questionid",                //每一行的唯一标识，一般为主键列
                cardView: true,                    //是否显示详细视图
                rowStyle: rowStyle,//设置行样式
                theadClasses: 'theadClassesStyle_sub',
                columns: [{
                    checkbox: false,
                    visible: false//是否显示复选框
                }, {
                    field: 'subject',
                    title: '所属科目'
                }, {
                    field: 'section',
                    title: '所属章节'
                }, {
                    field: 'knows',
                    title: '所属知识点',
                    formatter: knowshandler
                }, {
                    field: 'question',
                    title: '标题',
                    formatter: sub_questionhandler
                }, {
                    field: 'questionselect',
                    title: '备选项',
                    formatter: questionselecthandler
                }, {
                    field: 'questionanswer',
                    title: '答案'
                }, {
                    field: 'questiondescribe',
                    title: '解析'
                }, {
                    field: 'questionlevel',
                    title: '难度',
                    formatter: sub_questionlevelhandler
                }],
                //无线循环取子表，直到子表里面没有记录
                onExpandRow: function (index, row, $Subdetail) {
                    InitSubTable(index, row, $Subdetail);
                },
                onLoadSuccess: function (data) {
                },
            });
        };
    };


    function rowStyle(row, index) {
        var style = { };
        style ={css:{'font-size':'12px'}};
        return style;
    }

    /*试题内容控制器*/
    function questionhandler(value, row, index) {
        var htmlStr = escape2Html(value);
        var str = htmlStr.replace(/<\/?[^>]*>/g, ''); //去除HTML标签
        str = str.replace(/[|]*\n/, '') //去除行尾空格
        return str;
    }

    /*详细信息标题控制器*/
    function sub_questionhandler(value, row, index) {
        var htmlStr = escape2Html(value);
        var str = htmlStr.replace(/<\/?[^>]*>/g, ''); //去除HTML标签
        str = str.replace(/[|]*\n/, '') //去除行尾空格
        return str;
    }

    function questionselecthandler(value, row, index) {
        var htmlStr = escape2Html(value);
        var str = htmlStr.replace(/<\/?[^>]*>/g, ''); //去除HTML标签
        str = str.replace(/[|]*\n/, '') //去除行尾空格
        return str;
    }

    /*录入人和录入时间控制器*/
    function inputpersonhandler(value, row, index) {
        var questioncreatetime = $.myTime.UnixToDate(row.questioncreatetime);
        if (value && row.questioncreatetime) {
            return value + "/" + questioncreatetime;
        } else {
            return "";
        }
    }

    /*删除人和删除时间控制器*/
    function removepersonhandler(value, row, index) {
        var questiondeltime = $.myTime.UnixToDate(row.questiondeltime);
        if (value && row.questiondeltime) {
            return value + "/" + questiondeltime;
        } else {
            return "";
        }
    }

    /*难度控制器*/
    function questionlevelhandler(value, row, index) {

        if (value == "1") {
            return "易";
        } else if (value == "2") {
            return "中";
        } else if (value == "3") {
            return "难";
        } else {
            return "";
        }
    }

    /*详细信息子标签控制器*/
    function sub_questionlevelhandler(value, row, index) {
        if (value == "1") {
            return "易";
        } else if (value == "2") {
            return "中";
        } else if (value == "3") {
            return "难";
        } else {
            return "";
        }
    }

    function knowshandler(value, row, index) {
        var knows = row.questionknowsid["0"].knows;
        return knows;
    }

    /*操作控制器*/
    function linkFormatter(value, row, index) {
        var str = "<button type='button' onclick='onClickEditButton(" + row.questionid + ");' class='btn btn-primary btn-xs'>\n" +
            "<span class='glyphicon glyphicon-edit'></span>&nbsp;修改\n" +
            "</button>";
        str += "<button style='margin-left:10px;' type='button' onclick='onClickRemoveButton(" + row.questionid + ");' class='btn btn-danger btn-xs'>\n" +
            "<span class='glyphicon  glyphicon-trash'></span>&nbsp;删除\n" +
            "</button>";
        return str;
    }

    /*修改试题按钮单击事件*/
    function onClickEditButton(questionid) {
        location.href = "index.php?exam-teach-questions-modifyquestion&questionid=" + questionid;
    }

    /*删除试题按钮单击事件*/
    function onClickRemoveButton(questionid) {
        // location.href = "index.php?exam-teach-questions-delquestion&questionparent=0&questionid=" + questionid;
        $.ajax({
            type: "GET",
            dataType: "JSON",
            url: "index.php?exam-teach-questions-delquestion&questionparent=0&questionid="+ questionid,
            async: false,
            cache: false,
            success: function (data) {
                if(data.statusCode=="200"){
                    toastr.success(data.message);
                    $table.bootstrapTable('refresh');
                }else{
                    toastr.error(data.message);
                }
            },
            error: function (data) {
                toastr.error(data.message);
            }
        });

    }

    /*批量删除点击事件*/
    $("#batchdelbtn").click(function () {
        // $('#questioninfo_tab').bootstrapTable(('refresh'));
        // $("#query_form").serializeArray();
        var batchlist = $table.bootstrapTable('getAllSelections');
        var idlists=[];
        for (var i = 0; i < batchlist.length; i++) {
            idlists.push(batchlist[i].questionid);
        }
        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "index.php?exam-teach-questions-batchdelquestion",
            async: false,
            cache: false,
            data:{
                questionids:idlists
            },
            success: function (data) {
                if(data.statusCode=="200"){
                    toastr.success(data.message);
                    $table.bootstrapTable('refresh');
                }else{
                    toastr.error(data.message);
                }
            },
            error: function (data) {
                toastr.error(data.message);
            }
        });

    });



    //该方法将转义字符转换为普通的HTML标签
    function escape2Html(str) {
        var arrEntities ={'lt':'<','gt':'>','nbsp':' ','amp':'&','quot':'"'};
        return str.replace(/&(lt|gt|nbsp|amp|quot);/ig, function (all, t){return arrEntities[t];});
    }




</script>
</html>
{x2;endif}
