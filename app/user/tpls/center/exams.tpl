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
							<li class="active">考试训练</li>
						</ol>
					</div>
				</div>
				<div class="box itembox" style="padding-top:10px;">
					<h4 class="title" style="padding:10px;">我的考试训练<!--a href="index.php?exam-app-basics-open" class="btn btn-primary pull-right"><em class="glyphicon glyphicon-plus-sign"></em> 开通新考场</a--></h4>
					<div class="col-xs-12" style="padding-left:0px;">
						{x2;tree:$basics,basic,bid}
						
						<div class="col-xs-3" style="width:20%">
							<a href="index.php?{x2;$_app}-app-index-setCurrentBasic&basicid={x2;v:basic['basicid']}" class="thumbnail ajax">
								<img src="{x2;if:v:basic['basicthumb']}{x2;v:basic['basicthumb']}{x2;else}app/core/styles/img/item.jpg{x2;endif}" alt="" width="100%">
							</a>
							<h5 class="text-center">{x2;v:basic['basic']}</h5>
						</div>
						{x2;if:v:bid % 5 == 0}
						<div class="col-xs-12"><hr /></div>
						{x2;endif}
						{x2;endtree}
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