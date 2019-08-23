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
				<div class="box itembox" style="margin-bottom:0px;border-bottom:1px solid #CCCCCC;">
					<div class="col-xs-12">
						<ol class="breadcrumb">
							<li><a href="index.php">首页</a></li>
							<li><a href="index.php?{x2;$_app}-app-student">学籍管理</a></li>
							<li class="active">学生档案</li>
						</ol>
					</div>
				</div>
				<div class="box itembox" style="padding-top:10px;">
					<ul class="nav nav-tabs">
						<li>
							<a href="index.php?edu-app-student-show&userid={x2;$user['userid']}">档案</a>
						</li>
						<li class="active">
							<a href="index.php?edu-app-student-showprocess&userid={x2;$user['userid']}">进度</a>
						</li>
						<li>
							<a href="index.php?edu-app-student-showscore&userid={x2;$user['userid']}">成绩</a>
						</li>
						<a href="index.php?edu-app-student-outprocess&userid={x2;$user['userid']}{x2;$u}" class="btn btn-primary ajax pull-right">导出进度</a>
					</ul>
					<table class="table table-hover table-bordered" style="margin-top:10px;">
						<thead>
						<tr class="info">
							<!--th>ID</th-->
							<th>序号</th>
							<th>课程</th>
							<th>课程进度</th>
							<th>开始学习时间</th>
							<th>完成学习时间</th>
							<th>详细</th>
						</tr>
						</thead>
						<tbody>
                        {x2;tree:$progresses['data'],progress,pid}
						<tr>
							<!--td>{x2;v:progress['prsid']}</td-->
							<td>{x2;v:pid}</td>
							<td>{x2;$courses[v:progress['prscourseid']]['cstitle']}</td>
							<td>
								<div class="progress">
									<div class="progress-bar" role="progressbar" aria-valuenow="{x2;v:progress['prspersent']}" aria-valuemin="0" aria-valuemax="100" style="width: {x2;v:progress['prspersent']}%;">
                                        {x2;v:progress['prspersent']}%
									</div>
								</div>
							</td>
							<td>{x2;date:v:progress['prstime'],'Y-m-d'}</td>
							<td>{x2;if:v:progress['prsendtime']}{x2;date:v:progress['prsendtime'],'Y-m-d'}{x2;else}-{x2;endif}</td>
                            <td>
								<a href="index.php?edu-app-student-progress&prsid={x2;v:progress['prsid']}">查看</a>
								<a href="index.php?edu-app-message-add&userid={x2;v:progress['prsuserid']}">发消息</a>
							</td>
						</tr>
                        {x2;endtree}
						</tbody>
					</table>
					<ul class="pagination pagination-right">{x2;$progresses['pages']}</ul>
				</div>
			</div>
		</div>
	</div>
</div>
{x2;include:footer}


</body>
</html>