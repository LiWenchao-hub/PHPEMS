{x2;if:!$userhash}
{x2;include:header}
{x2;eval: v:signPackage = v:this->G->make('jssdk','user')->GetSignPackage();}
<body>




<?php
//重定向浏览器
//header("Location: index.php?course-app-index-all");
//确保重定向后，后续代码不会被执行
//exit;
?>




<div id="content">
    <div class="pages" id="page1">
{x2;endif}
    	<div class="pagecontent">
		<header class="container-fluid" style="background-color:#337AB7;">
			<h5 class="text-center">
				<em style="font-size:2rem;" class="pull-left glyphicon glyphicon-home"></em>
				<span class="ttlo">明德云课堂</span>
				<a style="font-size:2rem;color:#FFFFFF;" href="index.php?user-phone" class="pull-right glyphicon glyphicon-user ajax" data-target="user" data-page="user"></a>
			</h5>
		</header>
    	<div class="container-fluid" style="overflow:hidden;margin-top:1rem;margin-bottom:0.4rem;">
			<div class="swiper-container">
	    		<div class="swiper-wrapper">
		    		{x2;tree:$contents[2]['data'],content,cid}
		    		<div class="swiper-slide">
		    			<a href="index.php?content-phone-content&contentid={x2;v:content['contentid']}" class="ajax" data-page="rollpage" data-target="rollpage">
		    				<img src="{x2;v:content['contentthumb']}">
		    			</a>
		    		</div>
{x2;endif}
	    		</div>
	    		<div class="swiper-pagination"></div>
	    	</div>
		</div>
		<div class="container-fluid">
			<div style="clear:both;overflow:hidden;" class="items">
				<div class="col-xs-3" style="padding:0.2rem;">
					<div class="text-center" style="padding:0.2rem;padding-top:1.5rem;">
						<a href="index.php?course-app-index-lists" class="ajax" data-page="mybasic" data-target="mybasic">
							<p>
								<img src="app/core/styles/img/video.png" style="width:92%;"/>
							</p>
							<h5>学历教育</h5>
						</a>
					</div>
				</div>
				<div class="col-xs-3" style="padding:0.2rem;">
					<div class="text-center" style="padding:0.2rem;padding-top:1.5rem;">
						<a class="ajax" href="http://md.y-min.cn/fine" data-target="course" data-page="course">
							<p>
								<img src="app/core/styles/img/exam.png" style="width:92%;"/>
							</p>
							<h5>职业培训</h5>
						</a>
					</div>
				</div>
				<div class="col-xs-3 " style="padding:0.2rem;">
					<div class="text-center" style="padding:0.2rem;padding-top:1.5rem;">
						<a href="index.php?course-app-index-all" data-target="certificate" data-page="certificate" class="ajax">
							<p>
								<img src="app/core/styles/img/news.png" style="width:92%;"/>
							</p>
							<h5>课程中心</h5>
						</a>
					</div>
				</div>
				<div class="col-xs-3 " style="padding:0.2rem;">
					<div class="text-center" style="padding:0.2rem;padding-top:1.5rem;">
						<!--a href="index.php?exam-app-basics-open" data-target="contentcategory" data-page="contentcategory" class="ajax"-->
						<a href="index.php?exam-app" data-target="contentcategory" data-page="contentcategory" class="ajax">
							<p>
								<img src="app/core/styles/img/t3.png" style="width:92%;"/>
							</p>
							<h5>考试中心</h5>
						</a>
					</div>
				</div>
			</div >
			<h4 style="overflow:hidden;clear:both;padding-top:0.2rem;" class="hidden">
				<span class="pull-left" style="width:35%"><hr /></span>
				<span class="col-xs-4 text-center" style="width:30%;line-height:4rem;">热门考场</span>
				<span class="pull-right" style="width:35%"><hr /></span>
			</h4>
			<div style="clear:both;padding:0px;margin-bottom:1rem;overflow: hidden;" class="hidden">
				{x2;tree:$basics['basic'],basic,bid}
				<div class="col-xs-6" style="padding:3px;">
					<div style="background-color:#FFFFFF;padding:7px">
						<a href="index.php?exam-phone-index-setCurrentBasic&basicid={x2;v:basic['basicid']}" class="ajax" data-target="basic" data-page="basic">
							<img src="{x2;v:basic['basicthumb']}" style="width:100%;"/>
						</a>
						<h5 class="text-center">
							<a href="index.php?exam-phone-index-setCurrentBasic&basicid={x2;v:basic['basicid']}" class="ajax" data-target="basic" data-page="basic">{x2;v:basic['basic']}</a>
						</h5>
					</div>
				</div>
				{x2;endtree}
			</div>
			<!--  最新课程    -->
			<div>
				<h4 style="overflow:hidden;clear:both;padding-top:0.2rem;">
					<span class="pull-left" style="width:35%"><hr /></span>
					<span class="col-xs-4 text-center" style="width:30%;line-height:4rem;">最新课程</span>
					<span class="pull-right" style="width:35%"><hr /></span>
				</h4>
			</div>
			<div style="clear:both;padding:0px;margin-bottom:1rem;">
				{x2;tree:$courses['data'],course,cid}
				<div class="col-xs-6" style="padding:3px;">
					<div style="background-color:#FFFFFF;padding:7px">
						<a class="ajax" href="index.php?course-phone-course&csid={x2;v:course['csid']}" data-target="courseplatform" data-page="courseplatform" style="width:8rem;">
							<img src="{x2;v:course['csthumb']}" style="width:100%;" alt="{x2;v:course['cstitle']}">
						</a>
						<!--h5 class="text-center"><a class="ajax" href="index.php?course-phone-course&csid={x2;v:course['csid']}" data-target="courseplatform" data-page="courseplatform">{x2;v:course['cstitle']}</a></h5-->
						<h5 class="text-center"><a class="ajax" href="index.php?course-phone-course&csid={x2;v:course['csid']}" data-target="courseplatform" data-page="courseplatform" title="{x2;v:course['cstitle']}"><?php echo substr($course['cstitle'], 0 , 21); ?></a></h5>

					</div>
				</div>
				{x2;endtree}
			</div>

			<!--  最新课程    -->



			{x2;tree:$contents,contents,cid}
			{x2;if:v:key != 2}
			<!--div>
				<h4 style="overflow:hidden;clear:both;padding-top:0.2rem;">
					<span class="pull-left" style="width:35%"><hr /></span>
					<span class="col-xs-4 text-center" style="width:30%;line-height:4rem;">{x2;substring:$rcats[v:key]['catname'],15}</span>
					<span class="pull-right" style="width:35%"><hr /></span>
				</h4>
			</div>
			<div style="clear:both;padding:1.5rem;background-color:#FFFFFF;margin-bottom:1rem;" class="col-xs-12">
				{x2;tree:v:contents['data'],content,cid}
				<div class="media">
					<div class="media-body">
						<h5 class="media-heading"><a class="ajax" href="index.php?content-phone-content&contentid={x2;v:content['contentid']}" data-target="contentpage" data-page="contentpage">{x2;v:content['contenttitle']}</a></h5>
						<p style="font-size:0.8rem;">{x2;substring:v:content['contentdescribe'],81} </p>
					</div>
				</div>
				{x2;endtree}
			</div-->



			{x2;endif}
			{x2;endtree}
		</div>
		</div>
		<script>
			$(function(){
				var mySwiper = new Swiper('.swiper-container',{
					"pagination":".swiper-pagination",
					"loop":true,
					"autoplay": 3000,
					"observer":true,
					"observeParents":true
				});
			});
		</script>
		{x2;include:footer}
{x2;if:!$userhash}
    </div>
</div>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script>
	wx.config({
        debug: false,
        appId: '{x2;v:signPackage['appId']}',
        timestamp: {x2;v:signPackage['timestamp']},
		nonceStr: '{x2;v:signPackage['nonceStr']}',
        signature: '{x2;v:signPackage['signature']}',
        jsApiList:  ['onMenuShareTimeline','onMenuShareAppMessage']
    });
</script>
</body>
</html>
{x2;endif}