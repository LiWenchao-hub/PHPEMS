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
							<li class="active">消息管理&nbsp;&nbsp;/&nbsp;&nbsp;历史消息管理&nbsp;&nbsp;/&nbsp;&nbsp;查看消息</li>
						</ol>
					</div>
				</div>
				<div class="box itembox" style="padding-top:10px;margin-bottom:0px;overflow:visible">

					<form action="index.php?edu-app-message-modify" method="post" class="form-horizontal">
						<div class="form-group">
							<label for="contenttitle" class="control-label col-sm-2">标题：</label>
							<div class="col-sm-9">
								<input disabled class="form-control" type="text" name="args[msgtitle]" needle="needle" msg="您必须输入标题" value="{x2;$msg['msgtitle']}">
							</div>
						</div>
						<div class="form-group">
							<span>
								<label for="normal_studyLevel" class="control-label col-sm-2">学历类别：</label>
								<div class="col-sm-4">
									<label class="radio-inline">
										<input disabled type="radio" name="args[studyLevel]" id="studyLevel0" value="本科" autocomplete="off"> 本科
									</label>&nbsp;&nbsp;
									<label class="radio-inline">
										<input disabled type="radio" name="args[studyLevel]" id="studyLevel1" value="专科" autocomplete="off"> 专科
									</label>&nbsp;&nbsp;			
								</div>
							</span>

							<span>
								<label for="normal_studyType" class="control-label col-sm-2">学习形式：</label>
									<div class="col-sm-4">
										<label class="radio-inline">
										<input disabled type="radio" name="args[studyType]" id="studyType0" value="函授" autocomplete="off"> 函授
										</label>&nbsp;&nbsp;
										<label class="radio-inline">
										<input disabled type="radio" name="args[studyType]" id="studyType1" value="业余" autocomplete="off"> 业余
										</label>&nbsp;&nbsp;								
									</div>
							</span>
						</div>
						<div class="form-group">
							<label for="contenttitle" class="control-label col-sm-2">可查看专业：</label>
							<div class="col-sm-9">
								<input disabled class="form-control" type="text" value="{x2;$msg['msggroups']}" name="args[msggroups]" needle="needle" msg="您必须输入可查看专业">
								<span class="help-block">填写可以查看的专业年份和专业名称，如"2019-会计"，多个英文逗号隔开。不限请填写0</span>
							</div>
						</div>
						<div class="form-group">
							<label for="contenttitle" class="control-label col-sm-2">可查看用户学号：</label>
							<div class="col-sm-9">
								<input disabled class="form-control" type="text" value="{x2;$msg['msgusers']}" name="args[msgusers]" needle="needle" msg="您必须输入可查看用户学号">
								<span class="help-block">填写可以查看的用户学号，多个英文逗号隔开。不限请填写0，用户组和用户学号都填写0时，全部人员都可以看到本消息。</span>
							</div>
						</div>
						<div class="form-group">
							<label for="contenttext" class="control-label col-sm-2">内容</label>
							<div class="col-sm-10">
								<textarea disabled rows="7" cols="4" class="ckeditor" name="args[msgcontent]">{x2;$msg['msgcontent']}</textarea>
							</div>
						</div>
						<div class="form-group">
							<label for="contenttemplate" class="control-label col-sm-2"></label>
							<div class="col-sm-9">
								<!--<button class="btn btn-primary" type="submit">提交</button>-->
								<input type="hidden" name="msgid" value="{x2;$msg['msgid']}">
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
</html>
{x2;endif}