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
							<li><a href="index.php?{x2;$_app}-center">学生中心</a></li>
							<li><a href="index.php?{x2;$_app}-center-msg">系统消息</a></li>
							<li class="active">消息内容</li>
						</ol>
					</div>
				</div>
				<div class="box itembox" style="padding-top:10px;">
					<div class="col-xs-12" >
						<h2 class="text-center" style="font-size:36px">{x2;$msg['msgtitle']}</h2>
						<hr/>
					</div>
					<div class="col-xs-12" id="content" >
                        {x2;realhtml:$msg['msgcontent']}
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
{x2;include:footer}
</body>
</html>