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
					<h4 class="title" style="padding:10px;">
                        {x2;$user['usertruename']} {x2;$course['cstitle']} 学习进度
						<a class="pull-right btn btn-primary" href="javascript:history.back();">返回</a>
					</h4>
					<div class="progress">
						<div class="progress-bar" role="progressbar" aria-valuenow="{x2;$oknumber}" aria-valuemin="0" aria-valuemax="100" style="width: {x2;$oknumber}%;">
                            {x2;$oknumber}%
						</div>
					</div>
					<table class="table table-hover table-bordered" style="margin-top:10px;">
						<thead>
						<tr class="info">
							<th>ID</th>
							<th>课件名</th>
							<th>完成状态</th>
						</tr>
						</thead>
						<tbody>
                        {x2;tree:$courses['data'],course,cid}
						<tr>
							<td>{x2;v:course['courseid']}</td>
							<td>{x2;v:course['coursetitle']}</td>
							<td>{x2;if:$logs[v:course['courseid']]['logstatus']}已完成{x2;else}学习中{x2;endif}</td>
						</tr>
                        {x2;endtree}
						</tbody>
					</table>
					<ul class="pagination pagination-right">{x2;$courses['pages']}</ul>
				</div>
			</div>
		</div>
	</div>
</div>
{x2;include:footer}


</body>
</html>