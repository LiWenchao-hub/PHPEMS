{x2;if:!$userhash}{x2;include:header}<body>{x2;include:nav}<div class="container-fluid">	<div class="row-fluid">		<div class="main">			<div class="col-xs-2" style="padding-top:10px;margin-bottom:0px;">                {x2;include:menu}			</div>			<div class="col-xs-10" id="datacontent">                {x2;endif}				<div class="box itembox" style="margin-bottom:0px;border-bottom:1px solid #CCCCCC;">					<div class="col-xs-12">						<ol class="breadcrumb">							<li><a href="index.php?edu-app">教务中心</a></li>							<li><a href="index.php?edu-app-edu">教学计划</a></li>							<li><a href="index.php?edu-app-edu-detail&planid={x2;$plan['planid']}">计划详情</a></li>							<li class="active">添加计划详情</li>						</ol>					</div>				</div>				<div class="box itembox" style="padding-top:10px;margin-bottom:0px;">					<h4 class="title" style="padding:10px;">						{x2;$plan['planyear']}-{x2;$plan['major']}						<a class="btn btn-primary pull-right" href="index.php?edu-app-edu-detail&planid={x2;$plan['planid']}">详情列表</a>					</h4>					<form action="index.php?edu-app-edu-adddetail" method="post" class="form-horizontal">						<div class="form-group">							<label for="contenttitle" class="control-label col-sm-2">学期：</label>							<div class="col-sm-9">								<select class="form-control" name="args[pdgrade]">									<option>第一学期</option>									<option>第二学期</option>									<option>第三学期</option>									<option>第四学期</option>									<option>第五学期</option>									<option>第六学期</option>									<option>第七学期</option>									<option>第八学期</option>								</select>							</div>						</div>						<div class="form-group">							<label for="contenttitle" class="control-label col-sm-2">课程：</label>							<div class="col-sm-9">								{x2;tree:$courses,course,cid}								<label class="checkbox-inline">									<input type="checkbox" class="form-control" name="args[pdcourse][]" value="{x2;v:course['csid']}"/> ({x2;v:course['csid']}){x2;v:course['cstitle']}								</label>								{x2;endif}							</div>						</div>						<div class="form-group">							<label for="contenttemplate" class="control-label col-sm-2"></label>							<div class="col-sm-9">								<button class="btn btn-primary" type="submit">提交</button>								<input type="hidden" name="args[pdplanid]" value="{x2;$plan['planid']}">								<input type="hidden" name="submit" value="1">							</div>						</div>					</form>				</div>			</div>            {x2;if:!$userhash}		</div>	</div></div>{x2;include:footer}</body></html>{x2;endif}