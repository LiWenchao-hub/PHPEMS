<div class="container-fluid box" style="margin:0px auto;padding-top:10px;overflow:visible">
	<div class="row-fluid">
		<div class="main">
			<div class="col-xs-3">
				<h1 style="color:#337AB7;"><a href="index.php"><img src="app/core/styles/img/logo2.png" style="height:60px;margin-top:10px;margin-left: 0"/>&nbsp;</a></h1>
			</div>
			<div class="col-xs-1">
			</div>
			<div class="col-xs-6" style="padding-top:22px;">
				<div class="form-inline">
					<div class="input-group">
						<div class="input-group-btn">
							<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								课程 <span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
								<li><a href="index.php?content-app">新闻</a></li>
								<li><a href="index.php?course-app">课程</a></li>
								<li><a href="index.php?docs-app">资料</a></li>
							</ul>
						</div>
						<input type="text" style="width:380px;" class="form-control" id="keyword" placeholder="搜索课程">
					</div>
					<button type="button" class="btn btn-primary" onclick="javascript:window.location='index.php?course-app-search&keyword='+$('#keyword').val();"> 搜 索 </button>
				</div>
			</div>
			<div class="col-xs-2" style="padding-top:22px;">
				<ul class="list-unstyled list-inline">
					{x2;if:$_user['userid']}
					<li>
						<div class="btn-group">
							<button type="button" class="btn btn-info"><em class="glyphicon glyphicon-user"></em> {x2;$_user['usertruename']}</button>
							<button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<span class="caret"></span>
								<span class="sr-only">Toggle Dropdown</span>
							</button>
							<!--ul class="dropdown-menu">
								<li><a href="index.php?user-center"><em class="glyphicon glyphicon-user"></em> 用户中心</a></li>
								{x2;if:$_user['teacher_subjects']}<li><a href="index.php?exam-teach"><em class="glyphicon glyphicon-book"></em> 教师管理</a></li>{x2;endif}
								{x2;if:$_user['groupid'] == 1}<li><a href="index.php?core-master"><em class="glyphicon glyphicon-dashboard"></em> 后台管理</a></li>{x2;endif}
								<li><a class="ajax" href="index.php?user-app-logout"><em class="glyphicon glyphicon-log-out"></em> 退出</a></li>
							</ul-->
							
						<!--ul class="dropdown-menu">
								<li>
								<a href="index.php?user-center"><em class="glyphicon glyphicon-user" style="color: rgba(49,174,211,0.71);"></em> &nbsp &nbsp 学生中心</a>
								</li>
								{x2;if:$_user['groupid'] == 9 or $_user['groupid'] == 12 or $_user['groupid'] == 1}
								<li>
									<a href="index.php?exam-teach">
										<em class="glyphicon glyphicon-dashboard"style="color: rgba(49,174,211,0.71);"></em>&nbsp &nbsp  教师中心
									</a>
								</li>
								{x2;endif}
								{x2;if:$_user['groupid'] == 12 or $_user['groupid'] == 1}<li><a href="index.php?exam-teach"><em class="glyphicon glyphicon-calendar"style="color: rgba(49,174,211,0.71);"></em>&nbsp &nbsp  教务中心</a></li>{x2;endif}
								{x2;if:$_user['groupid'] == 1}<li><a href="index.php?core-master"><em class="glyphicon glyphicon-cog" style="color: rgba(49,174,211,0.71);"></em> &nbsp &nbsp 系统管理</a></li>{x2;endif}
								<li><a class="ajax" href="index.php?user-app-logout"><em class="glyphicon glyphicon-log-out" aria-hidden="true" style="color: rgba(49,174,211,0.71);"></em>&nbsp &nbsp  退 出</a></li>
							</ul-->

							<ul class="dropdown-menu">
								<li>
								<a href="index.php?user-center"><em class="glyphicon glyphicon-user" style="color: rgba(49,174,211,0.71);"></em>    &nbsp &nbsp 学生中心</a>
								</li>

								
								{x2;if:$_user['groupid'] == 9 or $_user['groupid'] == 12 or $_user['groupid'] == 1}
								<li>
									<a href="index.php?exam-teach">
										<em class="glyphicon glyphicon-dashboard"style="color: rgba(49,174,211,0.71);"></em>    &nbsp &nbsp  教师中心
									</a>
								</li>
								{x2;else}
								<li>
									<a href="#">
										<em class="glyphicon glyphicon-dashboard"style="color: rgba(49,174,211,0.71);"></em>    &nbsp &nbsp  教师中心
									</a>
								</li>
								{x2;endif}


								{x2;if:$_user['groupid'] == 12 or $_user['groupid'] == 1}
								<li><a href="index.php?core-master"><em class="glyphicon glyphicon-calendar"style="color: rgba(49,174,211,0.71);"></em>    &nbsp &nbsp  教务中心</a>
								</li>
								{x2;else}
								<li><a href="#"><em class="glyphicon glyphicon-calendar"style="color: rgba(49,174,211,0.71);"></em>    &nbsp &nbsp  教务中心</a>
								</li>
								{x2;endif}


								{x2;if:$_user['groupid'] == 1}

								<li><a href="index.php?core-master"><em class="glyphicon glyphicon-cog" style="color: rgba(49,174,211,0.71);"></em>    &nbsp &nbsp 系统管理</a>
								</li>
								{x2;else}
									<li><a href="#"><em class="glyphicon glyphicon-cog" style="color: rgba(49,174,211,0.71);"></em>    &nbsp &nbsp 系统管理</a>
								</li>
								{x2;endif}




								<li><a class="ajax" href="index.php?user-app-logout"><em class="glyphicon glyphicon-log-out" aria-hidden="true" style="color: rgba(49,174,211,0.71);"></em>    &nbsp &nbsp  退 出</a></li>
							</ul>

						</div>
					</li>
					{x2;else}
					<li><a href="javascript:;" onclick="javascript:$.loginbox.show();" class="btn btn-default"> 登 录 </a></li>
					<li><a href="index.php?user-app-register" class="btn btn-default"> 注 册 </a></li>
					{x2;endif}
				</ul>
			</div>
		</div>
	</div>
</div>
<div class="container-fluid navbar" style="margin-top:0px;margin-bottom:0px;padding-top:10px;background-color:#337AB7;">
	<div class="row-fluid">
		<div class="main">
			<div class="col-xs-12">
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
					<!--li class="menu col-xs-1">
					{x2;if:$_user['userid']}
						<a href="http://md.y-min.cn">
					{x2;else}	
						<a href="index.php?user-app-login">
					{x2;endif}	
							<span class="fa fa-universal-access"style="font-size: 24pt"></span>
							  职业培训
						</a>
					</li---->
					<li class="menu col-xs-1">
						<a href="index.php?exam-teach-users">
							<!--span class="fa fa-cubes" aria-hidden="true"style="font-size: 24pt"></span-->
							教师中心
						</a>
					</li>
					<!--li class="menu col-xs-1"><a href="index.php?exam">模拟考场</a></li-->
					<li class="menu col-xs-1">
						<a href="index.php?edu-app">
							<!--span class="fa fa-newspaper-o" aria-hidden="true"style="font-size: 24pt"></span-->
							教务中心
						</a>
					</li>
					<li class="menu col-xs-1">
						<a href="index.php?course-app-index-all">
							<!--span class="fa fa-newspaper-o" aria-hidden="true"style="font-size: 24pt"></span-->
							课程中心
						</a>
					</li>
					<!--li class="menu col-xs-1"><a href="index.php?docs">信息文库</a></li -->
					<!--li class="menu col-xs-1"><a href="tmpXL.html">政企云</a></li -->
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