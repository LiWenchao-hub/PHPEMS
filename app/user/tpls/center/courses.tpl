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
							<li class="active">我的课程</li>
						</ol>
					</div>
				</div>
				<div class="box itembox" style="padding-top:10px;">
					<div class="col-xs-12" style="padding-left:0px;">
						{x2;tree:$contents['data'],content,cid}
						<div class="col-xs-3" style="width:20%">
							<a href="index.php?course-app-course&csid={x2;v:content['csid']}" class="thumbnail">
								<img src="{x2;if:v:content['csthumb']}{x2;v:content['csthumb']}{x2;else}app/core/styles/img/item.jpg{x2;endif}" alt="" width="100%">
							</a>
							<h5 class="text-center">{x2;v:content['cstitle']}</h5>
						</div>
						{x2;endtree}
						<ul class="pagination pagination-right">{x2;$contents['pages']}</ul>
					</div>
					<ul class="pagination pagination-right">{x2;$progresses['pages']}</ul>
				</div>
			</div>
		</div>
	</div>
</div>
{x2;include:footer}
</body>
</html>