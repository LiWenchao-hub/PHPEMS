{x2;if:!$userhash}
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
{x2;endif}
				<div class="box itembox" style="margin-bottom:0px;border-bottom:1px solid #CCCCCC;">
					<div class="col-xs-12">
						<ol class="breadcrumb">
							<li><a href="index.php?{x2;$_app}-app">教务中心</a></li>
							<li class="active">消息管理&nbsp;&nbsp;/&nbsp;&nbsp;历史消息管理</li>
						</ol>
					</div>
				</div>
				<div class="box itembox" style="padding-top:10px;margin-bottom:0px;overflow:visible">

						<!--<span class="pull-right">
							<a style="margin-bottom: 10px;" class="btn btn-primary" href="index.php?edu-app-message-add">添加消息</a>
						</span>-->
					<table class="table table-hover table-bordered">
						<thead>
							<tr class="info">
								<th>标题</th>
								<th width="240">可查看用户组&nbsp;/&nbsp;可查看用户</th>
								<th width="120">发布时间</th>
								<th width="140">操作</th>
							</tr>
						</thead>
						<tbody>
							{x2;tree:$msgs['newdata'],msg,cid}
							<tr>
								<td>
									{x2;v:msg['msgtitle']}
								</td>
								<td>
									{x2;v:msg['msggroups_msgusers']}
								</td>
								<!--<td>
									{x2;v:msg['msggroups']}
								</td>
								<td>
									{x2;v:msg['msgusers']}
								</td>
								-->
								<td>
									{x2;date:v:msg['msgtime'],'y-m-d'}
								</td>
								<td class="actions">
									<div class="btn-group">
										<a class="btn" href="index.php?edu-app-message-modify&msgid={x2;v:msg['msgid']}&page={x2;$page}{x2;$u}" title="修改">查看</a>
										<a class="btn confirm" href="index.php?edu-app-message-del&msgid={x2;v:msg['msgid']}&page={x2;$page}{x2;$u}" title="删除">删除</a>
									</div>
								</td>
							</tr>
							{x2;endtree}
						</tbody>
					</table>
					<ul class="pagination pull-right">
						{x2;$contents['pages']}
					</ul>
				</div>
			</div>
{x2;if:!$userhash}
		</div>
	</div>
</div>
<script src="index.php?content-master-contents-catsmenu&catid={x2;$catid}"></script>
<script>
    $('#catsmenu').treeview({
        levels: {x2;$catlevel},
        expandIcon: 'glyphicon glyphicon-chevron-right',
        collapseIcon: 'glyphicon glyphicon-chevron-down',
        selectedColor: "#000000",
        selectedBackColor: "#FFFFFF",
        enableLinks: true,
        data: treeData
    });
</script>
{x2;include:footer}
</body>
</html>
{x2;endif}