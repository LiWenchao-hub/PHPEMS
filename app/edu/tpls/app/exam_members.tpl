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
							<li><a href="index.php?{x2;$_app}-app-exam-basic">考场管理</a></li>
							<li class="active">成员列表</li>
						</ol>
					</div>
				</div>
				<div class="box itembox" style="padding-top:10px;margin-bottom:0px;">
					<h4 class="title" style="padding:10px;">
						【{x2;$basic['basic']}】成员列表
					</h4>
			        <form action="index.php?edu-app-exam-members&basicid={x2;$basicid}" method="post" class="form-inline">
						<table class="table">
							<tr>
								<td style="border-top:0px;">
									身份证号：
								</td>
								<td style="border-top:0px;">
									<input class="form-control" name="search[username]" size="25" type="text" value="{x2;$search['username']}"/>
								</td>
								<td style="border-top:0px;">
									年级：
								</td>
								<td style="border-top:0px;">
									<select name="search[normal_favor]" class="form-control">
										<option value="0">不限</option>
                                        {x2;tree:$grade,gd,gid}
										<option value="{x2;v:gd}"{x2;if:$search['normal_favor'] == v:gd} selected{x2;endif}>{x2;v:gd}</option>
                                        {x2;endtree}
									</select>
								</td>
								<td style="border-top:0px;">
									专业：
								</td>
								<td style="border-top:0px;">
									<select name="search[userreferrer]" class="form-control">
										<option value="0">不限</option>
                                        {x2;tree:$majors,major,mid}
										<option value="{x2;v:major['majorcode']}"{x2;if:$search['userreferrer'] == v:major['majorcode']} selected{x2;endif}>{x2;v:major['major']}</option>
                                        {x2;endtree}
									</select>
								</td>
								<td style="border-top:0px;">
									<button class="btn btn-primary" type="submit">搜索</button>
									<input type="hidden" value="1" name="search[argsmodel]" />
								</td>
							</tr>
						</table>
					</form>
			        <table class="table table-hover table-bordered">
						<thead>
							<tr class="info">
			                    <th>ID</th>
						        <th>身份证号</th>
						        <th>姓名</th>
						        <th>开通时间</th>
						        <th>年级</th>
						        <th>专业</th>
						        <th>到期时间</th>
						        <th>操作</th>
			                </tr>
			            </thead>
			            <tbody>
			            	{x2;tree:$members['data'],user,uid}
			            	<tr>
			                    <td>{x2;v:user['userid']}</td>
			                    <td>{x2;v:user['username']}</td>
			                    <td>{x2;v:user['usertruename']}</td>
								<td>{x2;date:v:user['obtime'],'Y-m-d'}</td>
								<td>{x2;v:user['normal_favor']}</td>
								<td>{x2;v:user['userreferrer']}</td>
								<td>{x2;date:v:user['obendtime'],'Y-m-d'}</td>
								<td>
								  	<div class="btn-group">
			                    		<a class="btn confirm" href="index.php?edu-app-exam-closebasics&userid={x2;v:user['userid']}&basicid={x2;v:user['obbasicid']}{x2;$u}" title="取消开通"><em class="glyphicon glyphicon-remove"></em></a>
									</div>
								</td>
			                </tr>
			                {x2;endtree}
			        	</tbody>
			        </table>
			        <ul class="pagination pull-right">
			            {x2;$members['pages']}
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