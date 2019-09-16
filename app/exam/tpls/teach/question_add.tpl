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

                    <form action="index.php?exam-teach-questions-addquestion" method="post" name="theform" id="theform"
                          class="form-horizontal">
                        <fieldset>

                            <div class="form-group">
                                <label class="control-label col-sm-2"></label>
                                <div class="col-sm-10 form-inline">
                                    <select style="width: 50%;" class="combox form-control col-sm-1" id="subjectid"
                                            name="subjectid" target="isectionselect"
                                            refUrl="?exam-teach-questions-ajax-getsectionsbysubjectid&subjectid={value}">
                                        <option id="subject_option_zero" value="">选择科目</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-sm-2"></label>
                                <div class="col-sm-10 form-inline">

                                    <select style="width:50%;" class="combox form-control col-sm-1" name="iknowsselect"
                                            id="iknowsselect">
                                        <option id="iknowsselect_option_zero" value="">选择知识点</option>
                                    </select>
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="control-label col-sm-2">知识点:</label>
                                <div class="col-sm-10">
                                    <textarea class="ckeditor" id="questionknowsid" name="questionknowsid"></textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-sm-2">题型:</label>

                                <div class="col-sm-10 form-inline">
                                    <select style="width: 50%;" class="combox form-control col-sm-1" id="questiontype"
                                            name="questiontype" target="isectionselect">
                                        <option id="questiontype_option_zero" value=" ">选择题型</option>
                                    </select>
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
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-sm-2">题干:</label>
                                <div class="col-sm-10">
                                    <textarea class="ckeditor col-sm-1" name="question" id="question"> </textarea>
                                    <span class="help-block">需要填空处请以&nbsp;(&nbsp;&nbsp;)&nbsp;表示,题干不可以为空!</span>
                                </div>
                            </div>


                            <!--单选题  默认不显示-->
                             <div style="display: none;" id="unit">

                                 <div class="form-group">
                                     <label class="control-label col-sm-2">备选项数量:</label>
                                     <div class="col-sm-10 form-inline">
                                         <select style="width: 50%;" class="combox form-control"
                                                 id="questionselectnumber_unit" name="questionselectnumber_unit"
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
                                        <textarea class="ckeditor" name="questionselect_unit"
                                                  id="questionselect_unit"></textarea>
                                         <span class="help-block">无选择项的请不要填写,如&nbsp;[&nbsp;填空题&nbsp;,&nbsp;问答题&nbsp;]&nbsp;等主观题.</span>
                                     </div>
                                 </div>

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

                                 <div class="form-group">
                                     <label class="control-label col-sm-2">习题解析:</label>
                                     <div class="col-sm-10">
                                        <textarea class="ckeditor" name="questiondescribe_unit" id="questiondescribe_unit"></textarea>
                                     </div>
                                 </div>
                             </div>

                            <!--多选题  默认不显示-->
                            <div style="display: none;" id="multiple">

                                <div class="form-group">
                                    <label class="control-label col-sm-2">备选项数量:</label>
                                    <div class="col-sm-10 form-inline">
                                        <select style="width: 50%;" class="combox form-control"
                                                id="questionselectnumber_multiple" name="questionselectnumber_multiple"
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
                                        <textarea class="ckeditor" name="questionselect_multiple"
                                                  id="questionselect_multiple"></textarea>
                                        <span class="help-block">无选择项的请不要填写,如&nbsp;[&nbsp;填空题&nbsp;,&nbsp;问答题&nbsp;]&nbsp;等主观题.</span>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="control-label col-sm-2">参考答案:</label>
                                    <div class="col-sm-10">
                                        <div id="answerbox_multiple" class="answerbox" style="font-family: 仿宋;">

                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="targs[questionanswer2][]" value="A">A
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="targs[questionanswer2][]" value="B">B
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="targs[questionanswer2][]" value="C">C
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="targs[questionanswer2][]" value="D">D
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="targs[questionanswer2][]" value="E">E
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="targs[questionanswer2][]" value="F">F
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="targs[questionanswer2][]" value="G">G
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="targs[questionanswer2][]" value="H">H
                                            </label>

                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="control-label col-sm-2">习题解析:</label>
                                    <div class="col-sm-10">
                                        <textarea class="ckeditor" name="questiondescribe_multiple" id="questiondescribe_multiple"></textarea>
                                    </div>
                                </div>

                            </div>

                            <!--判断题  默认不显示-->
                            <div style="display: none;" id="judge">

                                <div class="form-group">
                                    <label class="control-label col-sm-2">备选项数量:</label>
                                    <div class="col-sm-10 form-inline">
                                        <select style="width: 50%;" class="combox form-control"
                                                id="questionselectnumber_judge" name="questionselectnumber_judge"
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
                                        <textarea class="ckeditor" name="questionselect_judge"
                                                  id="questionselect_judge"></textarea>
                                        <span class="help-block">无选择项的请不要填写,如&nbsp;[&nbsp;填空题&nbsp;,&nbsp;问答题&nbsp;]&nbsp;等主观题.</span>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="control-label col-sm-2">参考答案:</label>
                                    <div class="col-sm-10">
                                        <div id="answerbox_judge" class="answerbox" style="font-family: 仿宋;">

                                            <label class="radio-inline">
                                                <input type="radio" name="targs[questionanswer4]" value="A" checked>对
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="targs[questionanswer4]" value="B">错
                                            </label>

                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="control-label col-sm-2">习题解析:</label>
                                    <div class="col-sm-10">
                                        <textarea class="ckeditor" name="questiondescribe_judge" id="questiondescribe_judge"></textarea>
                                    </div>
                                </div>

                            </div>


                            <!--完形填空 默认不显示-->
                            <div style="display: none;" id="cloze">

                                <div class="form-group">
                                    <label class="control-label col-sm-2">备选项数量:</label>
                                    <div class="col-sm-10 form-inline">
                                        <select style="width: 50%;" class="combox form-control"
                                                id="questionselectnumber_cloze" name="questionselectnumber_cloze"
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
                                        <textarea class="ckeditor" name="questionselect_cloze"
                                                  id="questionselect_cloze"></textarea>
                                        <span class="help-block">无选择项的请不要填写,如&nbsp;[&nbsp;填空题&nbsp;,&nbsp;问答题&nbsp;]&nbsp;等主观题.</span>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="control-label col-sm-2">参考答案:</label>
                                    <div class="col-sm-10">
                                        <div id="answerbox_cloze" class="answerbox" style="font-family: 仿宋;">

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

                                <div class="form-group">
                                    <label class="control-label col-sm-2">习题解析:</label>
                                    <div class="col-sm-10">
                                        <textarea class="ckeditor" name="questiondescribe_judge" id="questiondescribe_judge"></textarea>
                                    </div>
                                </div>

                            </div>
                            <hr>
                            <div class="form-group">
                                <label class="control-label col-sm-2"></label>
                                <div class="col-sm-10">
                                    <button id="submit" name='submit' class="btn btn-primary pull-right" type="submit">提交</button>
                                    <input type="hidden" name="page" value="{x2;$page}"/>
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

    //表单检查
    $("#theform").bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            subjectid: {
                validators: {
                    notEmpty: {
                        message: '&emsp;&emsp;科目不能为空!'
                    }
                }
            },

            iknowsselect: {
                validators: {
                    notEmpty: {
                        message: '&emsp;&emsp;知识点不能为空!'
                    }
                }
            },

            questiontype: {
                validators: {
                    notEmpty: {
                        message: '&emsp;&emsp;题型不能为空!'
                    }
                }
            },
            questionlevel: {
                validators: {
                    notEmpty: {
                        message: '&emsp;&emsp;难度不能为空!'
                    },

                }
            },
        }
    });


    //设置CKEDITOR样式
    var obj = CKEDITOR.replace('questionknowsid', {
        toolbarCanCollapse: false,
        toolbarStartupExpanded: false,
        toolbar: [['']],
        resize_enabled: false,
        readOnly: true,
        height: 100
    });

    var questionobj= CKEDITOR.replace('question', {

    });




    //向下拉列表中放入科目信息
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

    //当科目改变时候触发的事件
    $('#subjectid').on('change', function () {
        $("#iknowsselect_option_zero").nextAll().remove();
        obj.setData("");
        // $("#questionsubjectid").val("0");
        var questionsubjectid = $("#subjectid").val();
        var questionknows_data = getQuestionknows(questionsubjectid);
        setQuestionknows(questionknows_data);
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
        // console.log(questionknows_data);

        for (var i = 0; i < questionknows_data.length; i++) {
            $("#iknowsselect_option_zero").after('<option value="' + questionknows_data[i].knowsid + '">' + questionknows_data[i].knows + '</option>');
        }
    }


    //当知识点改变时候触发的事件
    $('#iknowsselect').on('change', function () {
        if ($('#iknowsselect').val() == "") {
            obj.setData("");
        }
        obj.setData("&nbsp;&nbsp;&nbsp;知识点ID&nbsp;:&nbsp;" + $('#iknowsselect').val() + "&nbsp;&nbsp;<br>" + "知识点名称&nbsp;:&nbsp;" + $("#iknowsselect option:selected").text());
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
        var questiontype_val=$("#questiontype").val();
        if(questiontype_val=="1"){
            $("#unit").css("display","block");
        }else{
            $("#unit").css("display","none");
        }

        if(questiontype_val=="2"){
            $("#multiple").css("display","block");
        }else{
            $("#multiple").css("display","none");
        }


        if(questiontype_val=="3"){
            $("#judge").css("display","block");
        }else{
            $("#judge").css("display","none");
        }

        if(questiontype_val=="4"){
            $("#cloze").css("display","block");
        }else{
            $("#cloze").css("display","none");
        }
    });

    //当备选数量触发的时候触发事件



    $("#submit").on("click", function () {
        var bootstrapValidator = $("#theform").data('bootstrapValidator');
        bootstrapValidator.validate();
        if (bootstrapValidator.isValid()) {
            /*查询按钮点击事件*///search
                var fromdata = $("#theform").serializeArray();
                alert(typeof(fromdata));
                $.ajax({
                    type: "POST",
                    dataType: "JSON",
                    url: "index.php?exam-teach-questions-question_add",
                    data:{
                        args:fromdata
                    },
                    async: false,
                    cache: false,
                    success: function (data) {

                    },
                    error: function (data) {

                    }
                });
        } else {
            return
        }

    });


</script>
</html>
{x2;endif}
