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
						<li class="active">
							<a href="index.php?edu-app-student-show&userid={x2;$user['userid']}">档案</a>
						</li>
						<li>
							<a href="index.php?edu-app-student-showprocess&userid={x2;$user['userid']}">进度</a>
						</li>
						<li>
							<a href="index.php?edu-app-student-showscore&userid={x2;$user['userid']}">成绩</a>
						</li>
					</ul>
					<table class="table table-hover table-bordered" style="margin-top:10px;">
						<thead>
						<tr class="info">
							<th width="200">项目</th>
							<th>信息</th>
						</tr>
						</thead>
						<tbody>
                        {x2;tree:$infos,field,fid}
						<tr>
							<td>{x2;v:field['title']}</td>
							<td>{x2;v:field['value']}</td>
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