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
							<li><a href="index.php?{x2;$_app}-center">学生中心</a></li>
							<li class="active">教学计划</li>
						</ol>
					</div>
				</div>
				<div class="box itembox" style="padding-top:10px;">
					<h4> {x2;$user['userreferrer']}-{x2;$user['normal_studyLevel']}</h4>
					<table class="table table-hover table-bordered">
						<thead>
						<tr class="info">
							<th width="120">学期</th>
							<th>课程</th>
						</tr>
						</thead>
						<tbody>
                        {x2;tree:$details['data'],detail,did}
						<tr>
							<td>{x2;v:detail['pdgrade']}</td>
							<td>
								<div class="btn-group">
                                    {x2;tree:v:detail['pdcourse'],cs,cid}
									<a class="btn">{x2;$courses[v:cs]['cstitle']}</a>
                                    {x2;endtree}
								</div>
							</td>
						</tr>
                        {x2;endtree}
						</tbody>
					</table>
					<ul class="pagination pull-right">
                        {x2;$details['pages']}
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
{x2;include:footer}
</body>
</html>