{x2;if:!$userhash}{x2;include:header}<body>{x2;include:nav}<div class="container-fluid">	<div class="row-fluid">		<div class="main">			<div class="col-xs-2" style="padding-top:10px;margin-bottom:0px;">                {x2;include:menu}			</div>			<div class="col-xs-10" id="datacontent">                {x2;endif}				<div class="box itembox" style="margin-bottom:0px;border-bottom:1px solid #CCCCCC;">					<div class="col-xs-12">						<ol class="breadcrumb">							<li><a href="index.php?edu-app">教务中心</a></li>							<li><a href="index.php?edu-app-edu">教学计划</a></li>							<li class="active">计划详情</li>						</ol>					</div>				</div>				<div class="box itembox" style="padding-top:10px;margin-bottom:0px;">					<h4 class="title" style="padding:10px;">                        {x2;$plan['planyear']}-{x2;$plan['major']}						<a class="btn btn-primary pull-right" href="index.php?edu-app-edu-adddetail&planid={x2;$plan['planid']}">添加计划课程</a>					</h4>					<form action="index.php?content-master-contents" method="post" class="form-inline hide">						<table class="table">							<tr>								<td style="border-top: 0px;">									专业：								</td>								<td style="border-top: 0px;">									<input name="search[contentid]" class="form-control" size="15" type="text" class="number" value="{x2;$search['contentid']}"/>								</td>								<td style="border-top: 0px;">									年份：								</td>								<td style="border-top: 0px;">									<input class="form-control" name="search[username]" size="15" type="text" value="{x2;$search['username']}"/>								</td>								<td style="border-top: 0px;">									<button class="btn btn-primary" type="submit">提交</button>								</td>							</tr>						</table>						<div class="input">							<input type="hidden" value="1" name="search[argsmodel]" />						</div>					</form>					<form action="index.php?edu-app-category-lite" method="post">						<fieldset>							<table class="table table-hover table-bordered">								<thead>								<tr class="info">									<!--th width="60">ID</th-->									<th width="120">学期</th>									<!--th>科目</th-->									<th>课程</th>									<th width="140">操作</th>								</tr>								</thead>								<tbody>                                {x2;tree:$details['data'],detail,did}								<tr>									<!--td>{x2;v:detail['pdid']}</td-->									<td>{x2;v:detail['pdgrade']}</td>									<!--td>										<div class="btn-group">                                            {x2;tree:v:detail['pdcourse'],cs,cid}											<a class="btn">{x2;$subjects[$courses[v:cs]['cssubjectid']]['subject']}</a>                                            {x2;endtree}										</div>									</td-->									<td>										<div class="btn-group">										{x2;tree:v:detail['pdcourse'],cs,cid}											<a class="btn">{x2;$courses[v:cs]['cstitle']}</a>										{x2;endtree}										</div>									</td>									<td>										<div class="btn-group">											<a class="btn" href="index.php?{x2;$_app}-app-edu-modifydetail&pdid={x2;v:detail['pdid']}&page={x2;$page}{x2;$u}">修改</a>											<a class="btn confirm" href="index.php?{x2;$_app}-app-edu-deldetail&pdid={x2;v:detail['pdid']}{x2;$u}">删除</a>										</div>									</td>								</tr>                                {x2;endtree}								</tbody>							</table>							<ul class="pagination pull-right">                                {x2;$details['pages']}							</ul>						</fieldset>					</form>				</div>			</div>            {x2;if:!$userhash}		</div>	</div></div>{x2;include:footer}</body></html>{x2;endif}