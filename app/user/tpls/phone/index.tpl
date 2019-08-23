		<header class="container-fluid" style="background-color:#337AB7;">
			<h5 class="text-center">
				<em style="font-size:2rem;" class="pull-left glyphicon glyphicon-chevron-left" onclick="javascript:$.goPrePage();"></em>
				个人中心
				<em style="font-size:2rem;" class="pull-right glyphicon glyphicon-home" onclick="javascript:$.goPage('#page1');"></em>
			</h5>
		</header>
		<div class="container-fluid">
		<br>
			<h2 class="text-center">
				<img src="app/core/styles/img/logo2.png" style="width:60%;">
			</h2>
			
		</div>
		<div class="container-fluid" style="width: =80%;padding-left: 10px;padding-right: 10px;">
				<div>
						<h2 class="text-center col-md-12" style="margin-top:1em;">{x2;$_user['usertruename']}</h2>
				</div>

				<div class="col-md-3" >
				<span class="glyphicon glyphicon-th-list" style="font-size: 13pt;color: #008899;"></span>
				学号：
				<span class="col-md-8">{x2;$_user['NumberID']}</span>
				</div>
				
				
				<div class="col-md-3">
				<span class="glyphicon glyphicon-barcode" style="font-size: 13pt;color: #008899;"></span>
				身份证号码：
				<span class="col-md-8">{x2;$_user['IdCard']}</span>
				</div>
				
				<div class="col-md-3">
				<span class="glyphicon glyphicon-equalizer" style="font-size: 13pt;color: #008899;"></span>
				专业：
				<span class="col-md-8">
				{x2;$_user['usersequence']}
				{x2;$_user['userreferrer']}
				</span>
				</div>
				
				<div class="col-md-3">
				<span class="glyphicon glyphicon-blackboard" style="font-size: 13pt;color: #008899;"></span>
				班级：
				<span class="col-md-8">{x2;$_user['normal_favor']}
				{x2;$_user['normal_studyType']}
				{x2;$_user['normal_studyLevel']}
				</span>
				</div>
				
				<div class="col-md-3">
				<span class="glyphicon glyphicon-envelope" style="font-size: 13pt;color: #008899;"></span>
				邮箱：
				<span class="col-md-7">{x2;$_user['useremail']}</span>
				</div>
				
				<div class="col-md-3">
				<span class="glyphicon glyphicon-home" style="font-size: 13pt;color: #008899;"></span>
				住址：
				<span class="col-md-8">{x2;$_user['normal_address']}</span>
				</div>
		</div>





		{x2;if:$_user['username'] != '888'}

			<div style="width:95%;margin:auto;margin-top:0.6rem;background-color:#FFFFFF;overflow:hidden;padding:1.2rem;">
				<a class="ajax" href="index.php?exam-app" data-target="page2" data-page="page2">我的考场 <span class="glyphicon glyphicon-chevron-right pull-right"></span></a>
			</div>

			<div style="width:95%;margin:auto;margin-top:0.6rem;background-color:#FFFFFF;overflow:hidden;padding:1.2rem;">
				<a class="ajax" href="index.php?user-phone-payfor" data-target="page2" data-page="page2">系统消息 <span class="glyphicon glyphicon-chevron-right pull-right"></span></a>
			</div>

			<div style="width:95%;margin:auto;margin-top:0.6rem;background-color:#FFFFFF;overflow:hidden;padding:1.2rem;">
				<a class="ajax" href="index.php?user-phone-privatement-modifypass" data-target="page2" data-page="page2">修改密码 <span class="glyphicon glyphicon-chevron-right pull-right"></span></a>
			</div>
		{x2;endif}
		<div style="width:95%;margin:auto;margin-top:0.6rem;margin-bottom:4.8rem;background-color:#FFFFFF;overflow:hidden;padding:1.2rem;">
			<a href="index.php?user-phone-logout" class="ajax">退出登录 <span class="glyphicon glyphicon-chevron-right pull-right"></span></a>
		</div>