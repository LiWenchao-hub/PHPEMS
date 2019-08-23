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
                            <li><a href="index.php?edu-app">教务中心</a></li>
                            <li class="active">教学管理&nbsp;&nbsp;/&nbsp;&nbsp;教学计划</li>
                        </ol>
                    </div>
                </div>
                <div class="box itembox" style="padding-top:10px;margin-bottom:0px;">

                    <form action="index.php?edu-app-edu" method="post" class="form-inline">
                        <table class="table">
                            <tr>

                                <td style="border-top: 0px;">
                                    年级：
                                </td>
                                <td style="border-top: 0px;">
                                    <input class="form-control" name="search[planyear]" size="15" type="text"
                                           value="{x2;$search['planyear']}"/>
                                </td>
                                <td style="border-top: 0px;">
                                    专业编号：
                                </td>
                                <td style="border-top: 0px;">
                                    <input name="search[planmajor]" class="form-control" size="15" type="text"
                                           class="number" value="{x2;$search['planmajor']}"/>
                                </td>
                                <!--<td style="border-top: 0px;">
									专业：
								</td>
								<td style="border-top: 0px;">
									<input name="search[major]" class="form-control" size="15" type="text" class="number" value="{x2;$search['major']}"/>
								</td>-->
                                <td style="border-top: 0px;">
                                    <a class="btn btn-primary pull-right" href="index.php?edu-app-edu-add">添加教学计划</a>

                                    <button style="margin-right: 20px;" class="btn btn-primary pull-right" type="submit">查询</button>
                                </td>
                            </tr>
                        </table>
                        <div class="input">
                            <input type="hidden" value="1" name="search[argsmodel]"/>
                        </div>
                    </form>
                    <table class="table table-hover table-bordered">
                        <thead>
                        <tr class="info">
                            <!--th width="80">ID</th-->
                            <th width="60">序号</th>
                            <th width="100">年份</th>
                            <th width="120">专业编号</th>
                            <th>专业</th>
                            <th width="240">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        {x2;tree:$plans['data'],plan,pid}
                        <tr>
                            <!--td>{x2;v:plan['planid']}</td-->
                            <td>{x2;v:pid}</td>
                            <td>{x2;v:plan['planyear']}</td>
                            <td>{x2;v:plan['majorcode']}</td>
                            <td>{x2;v:plan['major']}</td>
                            <td>
                                <div class="btn-group">
                                    <a class="btn confirm" msg="确定要复制吗？"
                                       href="index.php?edu-app-edu-copy&planid={x2;v:plan['planid']}{x2;$u}">复制</a>
                                    <a class="btn"
                                       href="index.php?edu-app-edu-detail&planid={x2;v:plan['planid']}{x2;$u}">详情</a>
                                    <a class="btn"
                                       href="index.php?edu-app-edu-modify&planid={x2;v:plan['planid']}{x2;$u}">修改</a>
                                    <a class="btn confirm"
                                       href="index.php?edu-app-edu-del&planid={x2;v:plan['planid']}{x2;$u}">删除</a>
                                </div>
                            </td>
                        </tr>
                        {x2;endtree}
                        </tbody>
                    </table>
                    <ul class="pagination pull-right">
                        {x2;$plans['pages']}
                    </ul>
                </div>
            </div>
            {x2;if:!$userhash}
        </div>
    </div>
</div>
{x2;include:footer}
</body>
</html>
{x2;endif}