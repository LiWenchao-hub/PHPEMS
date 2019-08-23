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
							<li><a href="index.php?user-center">首页</a></li>
							<li><a href="index.php?{x2;$_app}-center">学生中心</a></li>
							<li class="active">教学计划</li>
						</ol>
					</div>
				</div>
				<div class="box itembox" style="padding-top:10px;">
					<h4 class="title">我的教学计划</h4>
					<div   class="row row-centered">
						<div class="well col-md-12 col-centered text-center">
							<h3>{x2;$_user['normal_favor']}级{x2;$_user['userreferrer']}专业教学计划</h3>
						</div>
					</div>
					<table width="100%">
						<tr>
							<td width="30%">
								该专业教学计划信息未录入 ！
							</td>
							<td width="35%" style="padding:10px;">
								
								<p>&nbsp;</p>
								<!--p><a class="btn btn-primary" href="index.php?user-center-payfor">充值</a></p-->
							</td>
							<td style="padding:10px;">
								 
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
{x2;include:footer}
</body>
</html>