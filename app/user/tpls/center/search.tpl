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
							<li class="active">成绩查询 </li>
						</ol>
					</div>
				</div>
				<div class="box itembox" style="padding-top:10px;">
					<h4 class="title" style="padding:10px;">我的考试成绩<!--a href="#" class="btn btn-primary pull-right"><em class="glyphicon glyphicon-search"></em> 成绩查询</a--></h4>
					<table class="table table-hover table-bordered">
						<thead>
							<tr class="info">
								<!--th>ID</th-->
								<th>考试名称</th>
								<th>分数</th>
								<th>考试时间</th>
								<th>备注</th>
							</tr>
						</thead>
						<tbody style="font-size:9pt;">
							{x2;tree:$exams['data'],exam,eid}
							<tr{x2;if:v:exam['ehneedresit']} class="text-danger"{x2;endif}>
								<!--td>
									{x2;v:exam['ehid']}
								</td-->
								<td>
									{x2;v:exam['ehexam']}
								</td>
								<td>
									{x2;v:exam['ehscore']}
								</td>

								<td>
									{x2;date:v:exam['ehstarttime'],'Y-m-d H:i'}
								</td>
								<!--td>
									{x2;if:v:exam['ehtime'] >= 60}{x2;if:v:exam['ehtime']%60}{x2;eval: echo intval(v:exam['ehtime']/60)+1}{x2;else}{x2;eval: echo intval(v:exam['ehtime']/60)}{x2;endif}分钟{x2;else}{x2;v:exam['ehtime']}秒{x2;endif}
								</td-->
								<td>
									
								</td>
							</tr>
							{x2;endtree}
						</tbody>
					</table>
					<ul class="pagination pull-right">
                        {x2;$exams['pages']}
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
{x2;include:footer}
</body>
</html>