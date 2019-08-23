{x2;if:$_user['userid']}


<div class="container-fluid box" style="margin:0px auto;padding-top:10px;padding-left:0px;padding-right:0px;padding-bottom:10px;overflow:visible;">
	<div class="row-fluid">
		<div class="main">
		
			<div class="col-xs-10" style="padding-top:30px;margin-left: 0px;margin-bottom: 0px;">
				<h1 style="color:#337AB7;margin-left: -50px;margin-bottom: 0px;">
					<span style="font-size:15pt;padding-top:100px;margin-right:0;"><a href="index.php"><img src="app/core/styles/img/logo2.png" style="height:60px;margin-top:-10px;margin-left: 0"/></a>
					</span>
		
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span style="font-size:15pt;padding-top:500px;margin-top:500;margin-right:0;">
					{x2;$_user['usersequence']}在线学习平台</span>

					
				</h1>
			</div>	

			<div class="col-xs-2" style="padding-top:40px;margin-left: 0px;margin-bottom: 0px;">			
				<a class="ajax  pull-right btn btn-default " href="index.php?user-app-logout"><em class="fa fa-window-close " aria-hidden="true" style="color: rgba(49,174,211,0.71);"></em>&nbsp &nbsp  退 出</a>
			</div>
		</div>
	</div>
</div>


<div class="container-fluid navbar" style="margin-top:0px;margin-bottom:0px;margin-left: 0px;margin-right:0px;padding-top:10px;padding-left:0px;padding-right:0px;background-color:#337AB7;">
	<div class="row-fluid">
		<div class="main">
			<div class="col-xs-12" style="margin-left: -50px;">
				<ul class="list-unstyled list-inline" >
					<li class="menu col-xs-1 active">
						<a href="index.php" class="icon" >
							<!--span class="fa fa-home" style="font-size: 24pt"></span-->
							 首页
						</a>
					</li>

					<li class="menu col-xs-1">
						<a href="index.php?user-center">
							<!--span class="fa fa-language" style="font-size: 24pt"></span-->
							  学生中心
						</a>
					</li>
					
					<li class="menu col-xs-1">
						<!--a href="index.php?exam-app-basics-open"-->
						<a href="index.php?exam-teach-users">
							<!--span class="fa fa-cubes" aria-hidden="true"style="font-size: 24pt"></span-->
							教师助手
						</a>
					</li>
					<!--li class="menu col-xs-1"><a href="index.php?exam">模拟考场</a></li-->
					
					<li class="menu col-xs-1">
						<a href="index.php?exam-master">
							<!--span class="fa fa-newspaper-o" aria-hidden="true"style="font-size: 24pt"></span-->
							教务管理
						</a>
					</li>
					<li class="menu col-xs-1">
						<a href="index.php?course-app-index-lists">
							<!--span class="fa fa-language" style="font-size: 24pt"></span-->
							  课程中心
						</a>
					</li>
					<li class="menu col-xs-1">
						<a href="aboutMeXL.html">
							<!--span class="fa fa-newspaper-o" aria-hidden="true"style="font-size: 24pt"></span-->
							关于我们
						</a>
					</li>

				</ul>
			</div>
		</div>
	</div>
</div>			
{x2;else}


<div class="container-fluid box" style="margin:0px auto;padding-top:10px;padding-left:0px;padding-right:0px;padding-bottom:36px;overflow:visible;">
	<div class="row-fluid">
		<div class="main">
		
			<div class="col-xs-10" style="padding-top:10px;margin-left: 0px;margin-bottom: 0px;">
				<h1 style="color:#337AB7;margin-left: -50px;margin-bottom: 0px;">
					<a href="index.php"><img src="app/core/styles/img/logo2.png" style="height:60px;margin-top:-10px;margin-left: -10"/></a>
				</h1>
			</div>		
			<div class="col-xs-2 pull-right" style="padding-top:40px;margin-right: 0px;margin-bottom: 0px;">			
				<span><a href="javascript:;" onclick="javascript:$.loginbox.show();" class="btn btn-default "> 登 录 </a></span>
				<span><a href="index.php?user-app-register" class="btn btn-default "> 注 册 </a></span>
					
			</div>		
	</div>
</div>
<div class="container-fluid navbar" style="margin-top:90px;margin-bottom:0px;margin-left: 0px;margin-right:0px;padding-top:10px;padding-left:0px;padding-right:0px;background-color:#337AB7;">
	<div class="row-fluid">
		<div class="main">
			<div class="col-xs-12" style="margin-left: -50px;">
				<ul class="list-unstyled list-inline" >
					<li class="menu col-xs-1 active">
						<a href="index.php" class="icon" >
							<!--span class="fa fa-home" style="font-size: 24pt"></span-->
							 首页
						</a>
					</li>

					<li class="menu col-xs-1">
						<a href="index.php?user-center">
							<!--span class="fa fa-language" style="font-size: 24pt"></span-->
							  学生中心
						</a>
					</li>
					
					<li class="menu col-xs-1">
						<!--a href="index.php?exam-app-basics-open"-->
						<a href="index.php?exam">
							<!--span class="fa fa-cubes" aria-hidden="true"style="font-size: 24pt"></span-->
							教师助手
						</a>
					</li>
					<!--li class="menu col-xs-1"><a href="index.php?exam">模拟考场</a></li-->
					
					<li class="menu col-xs-1">
						<a href="index.php?course-app-index-all">
							<!--span class="fa fa-newspaper-o" aria-hidden="true"style="font-size: 24pt"></span-->
							教务中心
						</a>
					</li>
					<li class="menu col-xs-1">
						<a href="index.php?course-app-index-lists">
							<!--span class="fa fa-language" style="font-size: 24pt"></span-->
							 课程中心
						</a>
					</li>
					<li class="menu col-xs-1">
						<a href="aboutMeXL.html">
							<!--span class="fa fa-newspaper-o" aria-hidden="true"style="font-size: 24pt"></span-->
							关于我们
						</a>
					</li>

				</ul>
			</div>
		</div>
	</div>
</div>
{x2;endif}