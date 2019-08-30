{x2;include:header}
<body>
<style>

	a{
		color: #6c6c6c;
	}

	.nav-tabs > li.active > a, .nav-tabs > li.active > a:hover, .nav-tabs > li.active > a:link{
		color: #ffffff;
		cursor: default;
		background-color:#337AB7;
		border: 1px solid #ddd;
		border-top-color: rgb(221, 221, 221);
		border-top-style: solid;
		border-top-width: 1px;
		border-right-color: rgb(221, 221, 221);
		border-right-style: solid;
		border-right-width: 1px;
		border-bottom-color: rgb(221, 221, 221);
		border-bottom-style: solid;
		border-bottom-width: 1px;
		border-left-color: rgb(221, 221, 221);
		border-left-style: solid;
		border-left-width: 1px;
		border-image-outset: 0;
		border-image-repeat: stretch;
		border-image-slice: 100%;
		border-image-source: none;
		border-image-width: 1;
		border-bottom-color: transparent;
		border-radius: 18px 18px 0px 0px;
		-webkit-border-radius: 18px 18px 0px 0px;
		-moz-border-radius: 18px 18px 0px 0px;
	}

	#tab_a h4{
		font-size:14px;
		text-align: center;
		font-family: 仿宋;
	}

</style>
{x2;include:nav}
<div class="container-fluid">
	<div class="row-fluid">
		<div class="main" style="width: 100%;">
			<div class="box itembox" style="padding-top:20px;width: 100%;">
				<!-- 显示学校名称 -->
				<ul class="nav nav-tabs">
					{x2;tree:$catids,cat,cid}
					{x2;if:v:cid==1}
					<li class="active" id="li{x2;v:cid}" style="font-size:14px;width: 12%;">
					{x2;else}
					<li id="li{x2;v:cid}" style="font-size: 14px;width: 12%;">
					{x2;endif}
						<a  id="tab_a" href="index.php?course-app-category&catid={x2;v:cat['catid']}#{x2;v:cat['catname']}" data-toggle="tab"><h4>{x2;v:cat['catname']}</h4></a>
					</li>
					{x2;endtree}
				</ul>

				<!-- 显示课程列表 -->
				<div id="myTabContent" class="tab-content">
					<!-- 显示学校开设课程 -->
					{x2;tree:$catids,cat,cid}
					{x2;if:v:cat['catname']=='新疆农业大学'}
					<div class="tab-pane fade in active" id="{x2;v:cat['catname']}">
						{x2;else}
						<div class="tab-pane fade" id="{x2;v:cat['catname']}">
							{x2;endif}
							<div class="col-xs-12 container" style="padding-left:0px;padding-right:0px; padding-top:20px; ">
								{x2;tree:$contents[v:cat['catid']]['data'],content,cid}
								<div class="col-xs-2">
									<div class="">
									<div>
										<!--<a href="index.php?course-app-course&csid={x2;v:content['csid']}" title={x2;v:content['ClassTitle']}>
											<div class="card-text"><span class="fa fa-book" > </span>&nbsp;&nbsp;<?php echo substr($content['ClassTitle'] , 0 , 24); ?></div>
											<div class="card-text"><span class="fa fa-user"> </span>&nbsp;&nbsp;{x2;v:content['author']}</div>
											<div class="card-text"><span class="fa fa-podcast"> </span>&nbsp;&nbsp;{x2;v:content['publish']} </div>
											<div class="card-text"><span class="fa fa-podcast"> </span> &nbsp;&nbsp;{x2;v:content['publishTime']} </div>
										</a>-->
										<a href="index.php?course-app-course&csid={x2;v:content['csid']}" style="border-color: #ffffff;" class="thumbnail">
											<!--<img  src="app/core/styles/img/item.jpg" />-->
											<img src="{x2;if:v:content['csthumb']}{x2;v:content['csthumb']}{x2;else}app/core/styles/img/item.jpg{x2;endif}">
											<h5 style="height: 40px;color:#6c6c6c;font-size: 12px;"
												class="text-center">{x2;v:content['cstitle']}
											</h5>
										</a>
									</div>
								</div>
							</div>
							{x2;if:v:cid % 6 == 0}
							<div class="col-xs-12"><hr/></div>
							{x2;endif}

							{x2;endtree}
						</div>
					</div>





					{x2;endtree}
					<!-- 显示学校开设课程 -->
				</div>
				<div class="col-xs-12">
					<hr/>
					<p><ul class="pagination pagination-right">{x2;$contents['pages']}      </ul>
					</p>
				</div>

			</div>

			</div>
		</div>
	</div>
</div>
{x2;include:footer}
</body>
</html>