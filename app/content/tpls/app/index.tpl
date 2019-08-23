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
							<!--a href="#">
								<img src="{x2;v:content['contentthumb']}" alt="" style="width:1280px;height: 500px">
							</a-->
							<div class="carousel-caption">
								<!--{x2;v:content['contenttitle']}-->
							</div>
						</div>
						{x2;endtree}
					</div>
					<!-- Controls
					<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
					<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
					</a>
					<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
					<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
					</a>
					-->
				</div>
			</div>
		</div>
	</div>
</div>

<!--div class="container-fluid">
	<div class="row-fluid">
		<div class="main box itembox">
			<h4 class="title">热门考场</h4>
			<div class="col-xs-3" style="padding:0px;">
				<a href="index.php?exam-app" class="">
					<img src="app/core/styles/img/item3.jpg" alt="" width="287">
				</a>
			</div>
			<div class="col-xs-9" style="padding-left:0px;">
				{x2;tree:$basics['basic'],basic,bid}
				<div class="col-xs-3">
					<a href="index.php?exam-app-index-setCurrentBasic&basicid={x2;v:basic['basicid']}" class="thumbnail ajax">
						<img src="{x2;v:basic['basicthumb']}" alt="" width="180">
					</a>
					<h5 class="text-center">{x2;v:basic['basic']}</h5>
				</div>
				{x2;if:v:hid == 4}
				<div class="col-xs-12"><hr /></div>
				{x2;endif}
				{x2;endtree}
			</div>
		</div>
	</div>
</div>

<div class="container-fluid hide">
	<div class="row-fluid">
		<div class="main"><img src="app/core/styles/img/ad.jpg"/></div>
	</div>
</div>
<div class="container-fluid">
	<div class="row-fluid">
		<div class="main box itembox">
			<h4 class="title">视频课程</h4>
			<div class="col-xs-3" style="padding:0px;">
				<a href="index.php?course-app" class="">
					<img src="app/core/styles/img/item2.jpg" alt="" width="287">
				</a>
			</div>
			<div class="col-xs-9" style="padding-left:0px;">
				{x2;tree:$courses['data'],course,cid}
				<div class="col-xs-3">
					<a href="index.php?course-app-course&csid={x2;v:course['csid']}" class="thumbnail">
						<img src="{x2;v:course['csthumb']}" alt="" width="180">
					</a>
					<h5 class="text-center">{x2;v:course['cstitle']}</h5>
				</div>
				{x2;if:v:hid == 4}
				<div class="col-xs-12"><hr /></div>
				{x2;endif}
				{x2;endtree}
			</div>
		</div>
	</div>
</div>
<div class="container-fluid hide">
	<div class="row-fluid">
		<div class="main"><img src="app/core/styles/img/ad2.png"/></div>
	</div>
</div>
<div class="container-fluid">
	<div class="row-fluid">
		<div class="main">
			<div class="col-xs-4 box itembox" style="min-height:320px;">
				<h4 class="title"><a href="index.php?content-app-category&catid=1">{x2;$rcats[1]['catname']}</a></h4>
				<ul class="list-unstyled">
					{x2;tree:$contents[1]['data'],content,cid}
					<li><a href="index.php?content-app-content&contentid={x2;v:content['contentid']}" title="{x2;v:content['contenttitle']}">{x2;v:content['contenttitle']}</a></li>
					{x2;endtree}
				</ul>
			</div>
			<div class="col-xs-4 box itembox split" style="min-height:320px;">
				<h4 class="title"><a href="index.php?content-app-category&catid=3">{x2;$rcats[3]['catname']}</a></h4>
				<ul class="list-unstyled">
					{x2;tree:$contents[3]['data'],content,cid}
					<li><a href="index.php?content-app-content&contentid={x2;v:content['contentid']}" title="{x2;v:content['contenttitle']}">{x2;v:content['contenttitle']}</a></li>
					{x2;endtree}
				</ul>
			</div>
			<div class="col-xs-4 box itembox" style="min-height:320px;">
				<h4 class="title"><a href="index.php?content-app-category&catid=4">{x2;$rcats[4]['catname']}</a></h4>
				<ul class="list-unstyled">
					{x2;tree:$contents[4]['data'],content,cid}
					<li><a href="index.php?content-app-content&contentid={x2;v:content['contentid']}" title="{x2;v:content['contenttitle']}">{x2;v:content['contenttitle']}</a></li>
					{x2;endtree}
				</ul>
			</div>
		</div>
	</div>
</div-->



{x2;include:footer}
</body>
</html>