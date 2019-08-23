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
							<li><a href="index.php?{x2;$_app}-app-student">学籍管理</a></li>
							<li class="active">学生档案</li>
						</ol>
					</div>
				</div>
				<div class="box itembox" style="padding-top:10px;margin-bottom:0px;">
					<ul class="nav nav-tabs">
						<li>
							<a href="index.php?edu-app-student-show&userid={x2;$user['userid']}">档案</a>
						</li>
						<li>
							<a href="index.php?edu-app-student-showprocess&userid={x2;$user['userid']}">进度</a>
						</li>
						<li class="active">
							<a href="index.php?edu-app-student-showscore&userid={x2;$user['userid']}">成绩</a>
						</li>
						<a href="index.php?edu-app-student-outscore&userid={x2;$user['userid']}{x2;$u}" class="btn btn-primary ajax pull-right">导出成绩</a>
					</ul>
					<form action="index.php?{x2;$_app}-app-student-showscore&basicid={x2;$basicid}" method="post">
						<table class="table form-inline">
					        <tr>
								<td style="border-top:0px;">
									考试时间：
								</td>
								<td style="border-top:0px;">
									<input class="form-control datetimepicker" data-date="{x2;date:TIME,'Y-m-d'}" data-date-format="yyyy-mm-dd" type="text" name="search[stime]" size="10" id="stime" value="{x2;$search['stime']}"/> - <input class="form-control datetimepicker" data-date="{x2;date:TIME,'Y-m-d'}" data-date-format="yyyy-mm-dd" size="10" type="text" name="search[etime]" id="etime" value="{x2;$search['etime']}"/>
								</td>
								<td style="border-top:0px;"><button class="btn btn-primary" type="submit">提交</button></td>
					        </tr>
						</table>
						<div class="input">
							<input type="hidden" value="1" name="search[argsmodel]" />
						</div>
					</form>
			        <table class="table table-hover table-bordered" style="margin-top:10px;">
						<thead>
							<tr class="info">
			                    <!--th>ID</th-->
			                    <th>序号</th>
			                    <th>学生姓名</th>
			                    {x2;tree:$fields,field,fid}
			                    <th>{x2;v:field['fieldtitle']}</th>
			                    {x2;endtree}
			                    <th>分数</th>
						        <th>考试名称</th>
						        <th>考试时间</th>
						        <!--th>考试用时</th-->
			                </tr>
			            </thead>
			            <tbody>
		                    {x2;tree:$exams['data'],exam,eid}
					        <tr{x2;if:v:exam['ehneedresit']} class="text-danger"{x2;endif}>
								<!--td>
									{x2;v:exam['ehid']}
								</td-->
								<!--td>
									{x2;v:exam['ehusername']}
								</td-->
								<td>
									{x2;v:eid}
								</td>
								<td>
									{x2;v:exam['usertruename']}
								</td>
								{x2;tree:$fields,field,fid}
			                    <th>{x2;v:exam[v:field['field']]}</th>
			                    {x2;endtree}
								<td>
									{x2;v:exam['ehscore']}
								</td>
								<td>
									{x2;v:exam['ehexam']}
								</td>
								<td>
									{x2;date:v:exam['ehstarttime'],'Y-m-d H:i'}
								</td>
								<!--td>
									{x2;if:v:exam['ehtime'] >= 60}{x2;if:v:exam['ehtime']%60}{x2;eval: echo intval(v:exam['ehtime']/60)+1}{x2;else}{x2;eval: echo intval(v:exam['ehtime']/60)}{x2;endif}分钟{x2;else}{x2;v:exam['ehtime']}秒{x2;endif}
								</td-->
					        </tr>
					        {x2;endtree}
			        	</tbody>
			        </table>
			        <ul class="pagination pull-right">
			            {x2;$exams['pages']}
			        </ul>
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