<div class="container-fluid box" style="margin:0px auto;padding-top:10px;overflow:visible">
	<div class="row-fluid">
		<div class="main">
			<div class="col-xs-10">
				<h2 style="color:#337AB7;"><a href="index.php"><img src="app/core/styles/img/logo2.png" style="height:60px;margin-top:-10px;"/>&nbsp;</a></h2>
			</div>
			<div class="col-xs-2" style="padding-top:22px;">
				<ul class="list-unstyled list-inline">
					{x2;if:$_user['userid']}
					<li>
						<div class="btn-group">
							<button type="button" class="btn btn-info"><em class="fa fa-user"style="font-size: 14pt"></em> {x2;$_user['usertruename']}</button>
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
				<ul class="list-unstyled list-inline">
					<li class="menu col-xs-1">
						<a href="index.php?core-master">全局</a>
					</li>
					{x2;if:$apps['user']['appsetting']['managemodel']}
					{x2;tree:$apps,app,aid}
					{x2;if:v:app['appstatus'] && v:app['appid'] != 'core' && in_array(v:app['appid'],$_user['manager_apps'])}
					<li class="menu col-xs-1{x2;if:$_app == v:app['appid']} active{x2;endif}">
						<a href="index.php?{x2;v:app['appid']}-master">{x2;v:app['appname']}</a>
					</li>
					{x2;endif}
					{x2;endtree}
					{x2;else}
					{x2;tree:$apps,app,aid}
					{x2;if:v:app['appstatus'] && v:app['appid'] != 'core'}
					<li class="menu col-xs-1{x2;if:$_app == v:app['appid']} active{x2;endif}">
						<a href="index.php?{x2;v:app['appid']}-master">{x2;v:app['appname']}</a>
					</li>
					{x2;endif}
					{x2;endtree}
					{x2;endif}
				</ul>
			</div>
		</div>
	</div>
</div>