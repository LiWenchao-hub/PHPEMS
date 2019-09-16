{x2;include:header}
<body>
{x2;include:nav}
<div class="container-fluid" style="padding-left:0px;padding-right:0px;">
	<div class="row-fluid">
				<div class="col-xs-10 box split" style="padding:0px;width:100%;">
				<div id="carousel-example-generic" class="carousel slide carousel-fade" data-ride="carousel">
					<!-- Indicators -->
					<ol class="carousel-indicators" style="bottom:0px;">
						{x2;tree:$contents[2]['data'],content,cid}
						<li data-target="#carousel-example-generic" data-slide-to="{x2;v:key}"{x2;if:v:cid == 1} class="active"{x2;endif}></li>
						{x2;endtree}
					</ol>
					<!-- Wrapper for slides -->
					<div class="carousel-inner" role="listbox">
						{x2;tree:$contents[2]['data'],content,cid}
						<div class="item{x2;if:v:cid == 1} active{x2;endif} index_bg00{x2;v:cid}" align="center">
							<a href="index.php?content-app-content&contentid={x2;v:content['contentid']}">
								<img src="{x2;v:content['contentthumb']}" alt="" style="width:1280px;height: 500px">
							</a>

							<div class="carousel-caption">
								<!--{x2;v:content['contenttitle']}-->
							</div>
						</div>
						{x2;endtree}
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
{x2;include:footer}
</body>
</html>