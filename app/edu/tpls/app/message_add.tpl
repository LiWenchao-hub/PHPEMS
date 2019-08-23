{x2;if:!$userhash}
{x2;include:header}
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
                            <li class="active">消息管理&nbsp;&nbsp;/&nbsp;&nbsp;发布新消息</li>
                        </ol>
                    </div>
                </div>
                <div class="box itembox" style="padding-top:10px;margin-bottom:0px;overflow:visible">
                    <form action="index.php?edu-app-message-add" method="post" class="form-horizontal">
                        <div class="form-group">
                            <label for="contenttitle" class="control-label col-sm-2">标题：</label>
                            <div class="col-sm-10">
                                <input class="form-control" type="text" name="args[msgtitle]" needle="needle"
                                       msg="您必须输入标题" value="{x2;$content['contenttitle']}">
                            </div>
                        </div>

                        <div class="form-group">
							<span>
								<label for="normal_studyLevel" class="control-label col-sm-2">学历类别：</label>
								<div class="col-sm-4">
									<label class="radio-inline">
										<input type="radio" name="args[studyLevel]" id="studyLevel0" value="本科"
                                               autocomplete="off"> 本科
									</label>&nbsp;&nbsp;
									<label class="radio-inline">
										<input type="radio" name="args[studyLevel]" id="studyLevel1" value="专科"
                                               autocomplete="off"> 专科
									</label>&nbsp;&nbsp;			
								</div>
							</span>

                            <span>
								<label for="normal_studyType" class="control-label col-sm-2">学习形式：</label>
									<div class="col-sm-4">
										<label class="radio-inline">
										<input type="radio" name="args[studyType]" id="studyType0" value="函授"
                                               autocomplete="off"> 函授
										</label>&nbsp;&nbsp;
										<label class="radio-inline">
										<input type="radio" name="args[studyType]" id="studyType1" value="业余"
                                               autocomplete="off"> 业余
										</label>&nbsp;&nbsp;								
									</div>

							</span>
                        </div>

                        <div class="form-group">
                            <label for="contenttitle" class="control-label col-sm-2">可查看用户组：</label>
                            <input style="float:left;margin-left:15px;margin-top:12px;" id="grade_checkbox"
                                   name="grade_checkbox" type="checkbox">
                            <span>
                                <span style="float:left;margin-top:5px;margin-left:10px;">年级：</span>

                                <div class="col-sm-2" style="padding: 0px;margin-top:5px;">

                                    <select disabled="true" name="args[grade]" id="grade" class="form-control">
                                        <option id="grade_option_zero" value="0">不限</option>
                                    </select>
                                </div>

                             </span>

                            <span>
                                <span style="float:left;margin-left:35px;margin-top:5px;">专业：</span>
                                <div class="col-sm-5" style="padding: 0px;margin-top:5px;">

                                    <select disabled="true" name="args[major]" id="major" class="form-control">
                                        <option id="major_option_zero" value="0">不限</option>
                                    </select>
                                </div>
                             </span>

                        </div>


                        <div class="form-group">
                            <label for="contenttitle" class="control-label col-sm-2">可查看用户：</label>
                             <input style="float:left;margin-left:15px;margin-top:12px;" name="studentId_checkbox" id="studentId_checkbox" type="checkbox">
                            <span style="float:left;margin-left:10px;margin-top:5px;">学号：</span>

                            <div class="col-sm-8" style="padding: 0px;margin-top:5px;">

                                <input type="text" disabled="true" name="args[msgusers]" id="studentId" class="form-control">

                                <span class="help-block" style="font-size: 13px;">说明：填写可以查看的用户学号,多个学号请用英文逗号隔开.用户组和用户都为0时,全部人员都可以看到本消息.</span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="contenttext" class="control-label col-sm-2"
                                   style="margin-top:150px;">内容：</label>
                            <div class="col-sm-10">
                                <textarea rows="6" cols="4" class="ckeditor"
                                          name="args[msgcontent]">{x2;realhtml:$content['contenttext']}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="contenttemplate" class="control-label col-sm-2"></label>
                            <div class="col-sm-9">
                                <button class="btn btn-primary" style="float: right" type="submit">提交</button>
                                <input type="hidden" name="submit" value="1">
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
<!--此处引入JS标签-->
<script type="text/javascript">

    /*当页面加载完毕后执行该函数*/
    $(function () {
        $("#studentId").val("0");
        setGrade();
    });

    /*the function does is get grade data */
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
            $("#grade_option_zero").after('<option value="'+grade_datas[i].planyear+'">'+grade_datas[i].planyear+'</option>');
        }
    };

    //选择年级下拉列表时触发事件
    $('#grade').on('change',function(){
      // alert( $("#grade").val());
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
                grade:$("#grade").val()
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
        $("#major").find("option").not(":first").remove();
        for(var i=0;i<major_datas.length;i++){
            $("#major_option_zero").after('<option value="'+major_datas[i].major+'">'+major_datas[i].major+'</option>');
        }
    }

    /*年级的checkbox改变事件*/
    $("#grade_checkbox").change(function () {
        if ($("#grade_checkbox").is(':checked')) {
            //如果年级被选,则学号不准被选中
            $("#studentId_checkbox").attr("checked", false);
            //如果年级被选,则学号不准输入,默认值为0
            $("#studentId").attr("disabled", true);
            $("#studentId").val("0");

            //如果年级被选,则允许选择年级,允许选择专业(年级与专业为级联的关系)
            $("#grade").attr("disabled", false);
            $("#major").attr("disabled", false);
        } else {
            //如果年级不被选,则不允许选择年级,不允许选择专业,并设置输入框显示内容为不限
            $("#grade").attr("disabled", true);
            $("#major").attr("disabled", true);
            $("#grade").val("0");
            $("#major").val("0");
        }
    });

    /*学号的checkbox改变事件*/
    $("#studentId_checkbox").change(function () {
        if ($("#studentId_checkbox").is(':checked')) {
            //如果学号被选,则年级,专业不准被选中
            $("#grade_checkbox").attr("checked", false);
            //如果学号被选,则年级,专业不准被选择,默认显示值为不限
            $("#grade").attr("disabled", true);
            $("#major").attr("disabled", true);
            $("#grade").val("0");
            $("#major").val("0");
            //如果学号被选,则允许学号输入,清空输入框的值
            $("#studentId").attr("disabled", false);
            $("#studentId").val(null);
        } else {
            $("#studentId").attr("disabled", true);
            $("#studentId").val("0");
        }
    });

</script>
</html>
{x2;endif}