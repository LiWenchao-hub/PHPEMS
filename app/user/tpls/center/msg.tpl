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
							<li><a href="index.php">首页</a></li>
							<li><a href="index.php?{x2;$_app}-center">学生中心</a></li>
							<li class="active">系统消息</li>
						</ol>
					</div>
				</div>
				<div class="box itembox" style="padding-top:10px;">
					<h4 class="title" style="padding:10px;">系统消息</h4>
					<table class="table table-hover table-bordered" style="margin-top:10px;">
						<thead>
						<tr class="info">
							<th>消息标题</th>
							<th width="200">发布时间</th>
						</tr>
						</thead>
						<tbody>
                        {x2;tree:$msgs['data'],msg,mid}
						<tr>
							<td><a href="index.php?user-center-msg-detail&msgid={x2;v:msg['msgid']}">{x2;v:msg['msgtitle']}</a></td>
							<td>{x2;date:v:msg['msgtime'],'Y-m-d H:i:s'}</td>
						</tr>
                        {x2;endtree}
						</tbody>
					</table>
					<ul class="pagination pagination-right">{x2;$msgs['pages']}</ul>
				</div>
			</div>
		</div>
	</div>
</div>
{x2;include:footer}
</body>
</html>