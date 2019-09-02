{x2;include:header_table}
<style>
	.theadClassesStyle {
		font-size: 14px;
		color: #5c5c5c;
	}

.bootstrap3{
		background: #ffffff;
	}

	.pagination-info{
		margin-left: 10px;
	}
</style>
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
							<li><a href="index.php?{x2;$_app}-center">学生中心</a></li>
							<li id="active_li" class="active">系统消息</li>

						</ol>
					</div>

				</div>
				<table  id="msginfo_tab" class="table table-hover"></table>
			</div>
		</div>
	</div>
</div>
{x2;include:footer}
</body>
<script type="text/javascript">
	$(function () {
		InitMainTable();
	});

	var $table; //记录页面bootstrap-table全局变量$table，方便应用

	//初始化bootstrap-table的内容
	function InitMainTable() {
		var queryUrl = 'index.php?user-center-msg-msgInfoQuery';
		$table = $('#msginfo_tab').bootstrapTable({
			url: queryUrl,                      //请求后台的URL（*）
			method: 'POST',                      //请求方式（*）
			// toolbar: '#toolbar',              //工具按钮用哪个容器
			striped: true,                      //是否显示行间隔色
			cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
			pagination: true,                   //是否显示分页（*）
			sortable: true,                     //是否启用排序
			sortOrder: "asc",                   //排序方式
			sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）
			pageNumber: 1,                      //初始化加载第一页，默认第一页,并记录
			pageSize: 10,                     //每页的记录行数（*）
			pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
			// search: true,                      //是否显示表格搜索
			// strictSearch: true,
			// showColumns: true,                  //是否显示所有的列（选择显示的列）
			// showRefresh: true,                  //是否显示刷新按钮
			// minimumCountColumns: 2,             //最少允许的列数
			// clickToSelect: true,                //是否启用点击选中行
			height: 500,                      //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
			uniqueId: "msgid",                     //每一行的唯一标识，一般为主键列
			// showToggle: true,                   //是否显示详细视图和列表视图的切换按钮
			// cardView: true,                    //是否显示详细视图
			// detailView: true,                  //是否显示父子表
			// //得到查询的参数
			// contentType: "application/x-www-form-urlencoded; charset=UTF-8",

			queryParams: function (params) {

			},
			rowStyle: rowStyle,//设置行样式
			theadClasses: 'theadClassesStyle',
			columns: [{
				checkbox: false,
				visible: false                  //是否显示复选框
			},{
				field: 'num',
				title: '序号',
				sortable: true,
				formatter:numhandler
			}, {
				field: 'msgtitle',
				title: '消息标题',
				formatter:msgtitlehandler
			}, {
				field: 'msgtime',
				title: '发布时间',
				sortable: true,
				formatter: datehandler
			},],
			onLoadSuccess: function (data) {

			},
			onLoadError: function () {
				showTips("数据加载失败！");
			},
		});
	};

	function rowStyle(row, index) {
		var style = { };
		style ={css:{'font-size':'12px'}};
		return style;
	}
    function datehandler(value, row, index){
		// var systemTime = $.format.date(new Date().getTime(), "yyyy-MM-dd HH:mm:ss");//获取当前系统时间
		// var systemTime = new Date().getTime();//获取当前系统时间
		// var thedate=new Date(value).getTime();
		// var timeInterval=systemTime-thedate;//获得秒
		// // var day = parseInt(newtime / (1000 * 60 * 60 * 24));//得到天
		// // var day = parseInt(newtime / (1000 * 60 * 60 ));//得到小时
		// // var day = parseInt(newtime / ( 60  ));//得到分钟
		// var twoDays=1000 * 60 * 60 * 24*2;
		// if(parseInt(timeInterval)>twoDays){
        // // var str="&nbsp;<span class=\"iconfont icon-dot\" style=\"color:#ff0000;font-size: 12px;\"></span>";
        // // $("#active_li").append(str)
		// }
		return value;
	}

	/*日期handler*/
	function numhandler(value, row, index){
		// console.log(row.msgtime);

		var systemTime = new Date().getTime();//获取当前系统时间
		var thedate=new Date(row.msgtime).getTime();
		var timeInterval=systemTime-thedate;//获得秒
		// var day = parseInt(newtime / (1000 * 60 * 60 * 24));//得到天
		// var day = parseInt(newtime / (1000 * 60 * 60 ));//得到小时
		// var day = parseInt(newtime / ( 60  ));//得到分钟
		var twoDays=1000 * 60 * 60 * 24*2;
		if(parseInt(timeInterval)<twoDays){
			// var str="&nbsp;<span class=\"iconfont icon-dot\" style=\"color:#ff0000;font-size: 12px;\"></span>";
			// $("#active_li").append(str)
			return value+"&nbsp;<span class='iconfont icon-dot' style='color:#ff0000;font-size: 8px;float: right'></span>";
		}else {
			return value;
		}
	}

	function msgtitlehandler(value, row, index) {

		return '<a href="index.php?user-center-msg-detail&msgid='+row.msgid+'">'+value+'</a>';

	}

</script>
</html>