{x2;if:!$userhash}
{x2;include:header_table}
<style>
    .control-label {
        font-size: 12px;
        font-family: 仿宋;
    }

    .form-control {
        height: 30px;
        font-size: 12px;
    }

    .help-block {
        font-size: 12px;
        color: #b40000;
    }

    .form-horizontal .has-feedback .form-control-feedback {
        left: 49%;
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
                            <li><a href="index.php?{x2;$_app}-teach">教师中心</a></li>
                            <li><a href="index.php?{x2;$_app}-teach-questions">试题管理</a></li>
                            <li class="active">手动添加</li>
                        </ol>
                    </div>
                </div>
                <div class="box itembox" style="padding-top:10px;margin-bottom:0px;">

                    <form name="questionform" id="questionform" data-parsley-validate="" class="form-horizontal">
                        <fieldset>
                            <div class="form-group">
                                <label class="control-label col-sm-2"></label>
                                <div class="col-sm-10 form-inline">
                                    <select style="width: 50%;" class="combox form-control col-sm-1" id="subjectid"
                                            name="subjectid" target="isectionselect"
                                            refUrl="?exam-teach-questions-ajax-getsectionsbysubjectid&subjectid={value}">
                                        <option id="subject_option_zero" value="">选择科目</option>
                                    </select>
                                    <label class="help-block">&nbsp;&nbsp;*</label>
                                </div>

                            </div>

                            <div class="form-group">
                                <label class="control-label col-sm-2"></label>
                                <div class="col-sm-10 form-inline">

                                    <select  required="" style="width:50%;" class="combox form-control col-sm-1"
                                            name="questionknowsid"
                                            id="questionknowsid">
                                        <option id="questionknowsid_option_zero" value="">选择知识点</option>
                                    </select>
                                    <label class="help-block">&nbsp;&nbsp;*</label>
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="control-label col-sm-2">知识点:<span class="help-block"></label>
                                <div class="col-sm-10 ">
                                    <textarea class="ckeditor" id="iknowsselect" name="iknowsselect"></textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-sm-2">题型:</label>

                                <div class="col-sm-10 form-inline">
                                    <select style="width: 50%;" class="combox form-control col-sm-1" id="questiontype"
                                            name="questiontype" target="isectionselect">
                                        <option id="questiontype_option_zero" value="">选择题型</option>
                                    </select>
                                    <label class="help-block">&nbsp;&nbsp;*</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-sm-2">难度:</label>
                                <div class="col-sm-10 form-inline">
                                    <select style="width: 50%;" class="combox form-control col-sm-1" id="questionlevel"
                                            name="questionlevel" target="isectionselect">
                                        <option id="questionlevel_option_zero" value="">选择难度</option>
                                        <option value="1">易</option>
                                        <option value="2">中</option>
                                        <option value="3">难</option>
                                    </select>
                                    <label class="help-block">&nbsp;&nbsp;*</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-sm-2">题干:</label>
                                <div class="col-sm-10">
                                    <textarea class="ckeditor col-sm-1" name="question" id="question"></textarea>
                                    <label class="help-block">&nbsp;&nbsp;*&nbsp;&nbsp;需要填空处请以&nbsp;&nbsp;(&nbsp;&nbsp;)&nbsp;表示!</label>
                                    <span class="help-block"></span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-sm-2">备选项数量:</label>
                                <div class="col-sm-10 form-inline">
                                    <select style="width: 50%;" class="combox form-control"
                                            id="questionselectnumber" name="questionselectnumber"
                                            target="isectionselect">
                                        <option value="0">0</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4" selected>4</option>
                                        <option value="5">5</option>
                                        <option value="6">6</option>
                                        <option value="7">7</option>
                                        <option value="8">8</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group" id="selecttext">
                                <label class="control-label col-sm-2">备选项:</label>
                                <div class="col-sm-10">
                                        <textarea class="ckeditor" name="questionselect"
                                                  id="questionselect"></textarea>
                                    <label class="help-block">无选择项的请不要填写,如&nbsp;[&nbsp;填空题&nbsp;,&nbsp;问答题&nbsp;]&nbsp;等主观题.</label>
                                </div>
                            </div>


                            <!--单选题  默认不显示-->
                            <div style="display: none;" id="unit">
                                <div class="form-group">
                                    <label class="control-label col-sm-2">参考答案:</label>
                                    <div class="col-sm-10">
                                        <div id="answerbox_unix" class="answerbox" style="font-family: 仿宋;">
                                            <label class="radio-inline">
                                                <input type="radio" name="questionanswer1" value="A" checked>A
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="questionanswer1" value="B">B
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="questionanswer1" value="C">C
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="questionanswer1" value="D">D
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="questionanswer1" value="E">E
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="questionanswer1" value="F">F
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="questionanswer1" value="G">G
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="questionanswer1" value="H">H
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!--多选题  默认不显示-->
                            <div style="display: none;" id="multiple">

                                <div class="form-group">
                                    <label class="control-label col-sm-2">参考答案:</label>
                                    <div class="col-sm-10">
                                        <div id="answerbox_multiple" class="answerbox" style="font-family: 仿宋;">
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="questionanswer2" id="questionanswer2_a"
                                                       value="A">A
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="questionanswer2" id="questionanswer2_b"
                                                       value="B">B
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="questionanswer2" id="questionanswer2_c"
                                                       value="C">C
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="questionanswer2" id="questionanswer2_d"
                                                       value="D">D
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="questionanswer2" id="questionanswer2_e"
                                                       value="E">E
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="questionanswer2" id="questionanswer2_f"
                                                       value="F">F
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="questionanswer2" id="questionanswer2_g"
                                                       value="G">G
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="questionanswer2" id="questionanswer2_h"
                                                       value="H">H
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!--判断题  默认不显示-->
                            <div style="display: none;" id="judge">
                                <div class="form-group">
                                    <label class="control-label col-sm-2">参考答案:</label>
                                    <div class="col-sm-10">
                                        <div id="answerbox_judge" class="answerbox" style="font-family: 仿宋;">

                                            <label class="radio-inline">
                                                <input type="radio" name="questionanswer3" id="questionanswer3_a"
                                                       value="A" checked>对
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="questionanswer3" id="questionanswer3_b"
                                                       value="B">错
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!--完形填空 默认不显示-->
                            <!--<div style="display: none;" id="cloze">

                                <div class="form-group">
                                    <label class="control-label col-sm-2">参考答案:</label>
                                    <div class="col-sm-10">
                                        <div id="answerbox_cloze" class="answerbox" style="font-family: 仿宋;float: left">
                                            <label class="radio-inline">
                                                <input type="radio" name="questionanswer4" id="optionsRadios4_a"
                                                       value="A" checked="checked">A
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="questionanswer4" id="optionsRadios4_b"
                                                       value="B">B
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="questionanswer4" id="optionsRadios4_c"
                                                       value="C">C
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="questionanswer4" id="optionsRadios4_d"
                                                       value="D">D
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="questionanswer4" id="optionsRadios4_e"
                                                       value="E">E
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="questionanswer4" id="optionsRadios4_f"
                                                       value="F">F
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="questionanswer4" id="optionsRadios4_g"
                                                       value="G">G
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="questionanswer4" id="optionsRadios4_e"
                                                       value="H">H
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>-->

                            <div class="form-group">
                                <label class="control-label col-sm-2">习题解析:</label>
                                <div class="col-sm-10">
                                        <textarea class="ckeditor" name="questiondescribe"
                                                  id="questiondescribe"></textarea>
                                </div>
                            </div>
                            <hr>
                            <div class="form-group">
                                <label class="control-label col-sm-2"></label>
                                <div class="col-sm-10">
                                    <label id="questionsubmit" name='questionsubmit' class="btn btn-primary pull-right" >
                                        保存
                                    </label>
                                    <input type="hidden" name="insertquestion" value="1"/>
                                    {x2;tree:$search,arg,aid}
                                    <input type="hidden" name="search[{x2;v:key}]" value="{x2;v:arg}"/>
                                    {x2;endtree}
                                </div>
                            </div>
                    </form>
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
        setSubject();
        setQuestionTypeList();
    });
    //设置CKEDITOR样式
    var obj = CKEDITOR.replace('iknowsselect', {
        toolbarCanCollapse: false,
        toolbarStartupExpanded: false,
        toolbar: [['']],
        resize_enabled: false,
        readOnly: true,
        height: 100
    });

    //题干
    var questionobj = CKEDITOR.replace('question', {

    });

    //备选项
    var questionselectobj = CKEDITOR.replace('questionselect', {

    });

    //习题解析
    var questiondescribeobj = CKEDITOR.replace('questiondescribe', {

    });

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




    //向下拉列表中放入科目信息
    function setSubject() {
        var subject_datas = getSubject();
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

    //当科目改变时候触发的事件
    $('#subjectid').on('change', function () {
        $('#questionknowsid').val("")
        $("#questionknowsid_option_zero").nextAll().remove();
        obj.setData("");
        // $("#questionsubjectid").val("0");
        var questionsubjectid = $("#subjectid").val();
        if (questionsubjectid != "") {
            var questionknows_data = getQuestionknows(questionsubjectid);
            setQuestionknows(questionknows_data);
        }
    });

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

    function setQuestionknows(questionknows_data) {
        for (var i = 0; i < questionknows_data.length; i++) {
            $("#questionknowsid_option_zero").after('<option value="' + questionknows_data[i].knowsid + '">' + questionknows_data[i].knows + '</option>');
        }
    }


    //当知识点改变时候触发的事件
    $('#questionknowsid').on('change', function () {
        if ($('#questionknowsid').val() == "") {
            obj.setData("");
        }
        obj.setData("&nbsp;&nbsp;&nbsp;知识点ID&nbsp;:&nbsp;" + $('#questionknowsid').val() + "&nbsp;&nbsp;<br>" + "知识点名称&nbsp;:&nbsp;" + $("#questionknowsid option:selected").text());
    });

    //将试题类型放入下拉列表中
    function setQuestionTypeList() {
        var $questions_type_lists = getQuestionType();
        for (var i = 0; i < $questions_type_lists.length; i++) {
            $("#questiontype_option_zero").after('<option value="' + $questions_type_lists[i].questid + '">' + $questions_type_lists[i].questype + '</option>');
        }
    }

    //初始化试题类型
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

    //当试题类型触发的时候触发的事件
    $('#questiontype').on('change', function () {
        // obj.setData( "&nbsp;&nbsp;&nbsp;知识点ID&nbsp;:&nbsp;"+$('#iknowsselect').val()+"&nbsp;&nbsp;<br>"+"知识点名称&nbsp;:&nbsp;"+$("#iknowsselect option:selected").text());
        // alert($("#questiontype").val());
        var questiontype_val = $("#questiontype").val();
        if (questiontype_val == "1") {
            $("#unit").css("display", "block");
        } else {
            $("#unit").css("display", "none");
        }

        if (questiontype_val == "2") {
            $("#multiple").css("display", "block");
        } else {
            $("#multiple").css("display", "none");
        }


        if (questiontype_val == "3") {
            $("#judge").css("display", "block");
        } else {
            $("#judge").css("display", "none");
        }

        if (questiontype_val == "4") {
            $("#cloze").css("display", "block");
        } else {
            $("#cloze").css("display", "none");
        }
    });



    //当备选数量触发的时候触发事件
    $("#questionsubmit").on("click", function () {
        //此处校验



        var question = questionobj.document.getBody().getText(); //取得纯文本-题干
        var questionselect = questionselectobj.document.getBody().getText();//取得纯文本-备选项
        var questiondescribe = questiondescribeobj.document.getBody().getText();//取得纯文本-习题解析

        /*查询按钮点击事件*/
        var fromdata = $("#questionform").serializeArray();
        var values = { };
        var questionanswer2_value = "";//多选题需要拼接多选题答案
        for (var item in fromdata) {
            values[fromdata[item].name] = fromdata[item].value;
            if (fromdata[item].name == "questionanswer2") {
                questionanswer2_value = questionanswer2_value + fromdata[item].value;
            }
        }

        if (values["questiontype"] == "1") {
            //如果试题类型为单选题
            delete values.questionanswer2;
            delete values.questionanswer3;
        } else if (values["questiontype"] == "2") {
            //如果试题类型为多选题
            delete values.questionanswer1;
            delete values.questionanswer2;
            delete values.questionanswer3;
            values["questionanswer2"] = questionanswer2_value;
        } else if (values["questiontype"] == "3") {
            //如果试题类型为判断题
            delete values.questionanswer1;
            delete values.questionanswer2;
        }else {
            delete values.questionanswer1;
            delete values.questionanswer2;
            delete values.questionanswer3;
        }
        //放入题干
        values["question"] = question;
        values["questionselect"] = questionselect;
        values["questiondescribe"] = questiondescribe;
        // console.log(values);
        //校验科目不得为空
        if($.trim(values.subjectid)==""){
            toastr.info("科目不得为空!")
            return;
        }
        //知识点不得为空
        if($.trim(values.questionknowsid)==""){
            toastr.info("知识点不得为空!")
            return;
        }
        //题型不得为空
        if($.trim(values.questiontype)==""){
            toastr.info("题型不得为空!")
            return;
        }
        //难度不得为空
        if($.trim(values.questionlevel)==""){
            toastr.info("难度不得为空!")
            return;
        }
        // alert(values.question);
        //题干不得为空
        if($.trim(values.question)==""){
            toastr.info("题干不得为空!")
            return;
        }

        $.ajax({
            type: "POST",
            dataType: "JSON",
            url: "index.php?exam-teach-questions-questionaddunit",
            data: {
                args: values
            },
            async: false,
            cache: false,
            success: function (data) {
                if(data.statusCode=="200"){
                    toastr.success(data.message);
                    $.confirm({
                        title: '提示信息',
                        content: '是否继续新增?',
                        type: '#337ab7',
                        buttons: {
                            ok: {
                                text: "是",
                                btnClass: 'btn-primary',
                                keys: ['enter'],
                                action: function(){
                                    location.href = "index.php?exam-teach-questions-addquestion";
                                }
                            },
                            cancel: {
                                text: "否",
                                btnClass: 'btn',
                                keys: ['enter'],
                                action: function(){
                                    location.href = "index.php?exam-teach-questions";
                                }
                            },

                        }
                    });
                }else{
                    toastr.error(data.message);
                }

            },
            error: function (data) {
                toastr.error(data.message);
            }
        });
    });
</script>
</html>
{x2;endif}
