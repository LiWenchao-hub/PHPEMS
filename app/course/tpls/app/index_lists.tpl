{x2;include:header}
<body>
{x2;include:nav}
<div class="container-fluid">
	<div class="row-fluid">
		<div class="main">
			<div class="box itembox" style="padding-top:20px;">
				<!-- 显示学校名称 -->
				<ul class="nav nav-tabs">
					{x2;tree:$catids,cat,cid}
					{x2;if:v:cid==1}
						<li class="active" id="li{x2;v:cid}" style="font-size: 14px">
					{x2;else}
						<li id="li{x2;v:cid}" style="font-size: 14px">
					{x2;endif}
						<a href="index.php?course-app-category&catid={x2;v:cat['catid']}#{x2;v:cat['catname']}" data-toggle="tab"><h4>{x2;v:cat['catname']}</h4></a>
						</li>
					{x2;endtree}
				</ul>
				<?php
				//echo '<pre>';
				//var_dump($this->tpl_var['catids']);
				//echo '<pre>';
				?>
				<!-- 显示学校名称 -->
				<div id="myTabContent" class="tab-content">
					<!-- 显示学校开设课程 -->
					{x2;tree:$catids,cat,cid}
						{x2;if:v:cat['catname']=='新疆农业大学'}
							<div class="tab-pane fade in active" id="{x2;v:cat['catname']}">
						{x2;else}
								<div class="tab-pane fade" id="{x2;v:cat['catname']}">
						{x2;endif}
									<div class="col-xs-12 container" style="padding-left:0px;padding-right:0px; padding-top:20px; ">
										{x2;tree:$contents[v:cat['catid']]['data'],content,cid}
										<div class="col-xs-2 border border-success" style="padding: 3pt">
											<div class="card bg-light mb-0" style="padding: 1px" >
											  <div class="card-header">

											  


										  <?php
												  
												  $l=mb_strlen($content['cstitle'],'UTF-8');
												  $s="";
												  //echo $l;
												  //die("00000");
												  if($l>'9')
												  	{
													$s="h5";
												  	//echo $s;

												  }
												  else
												  	{
														$s="h4";
												  		//echo $s;

												  }
													//die("3333");
												  	echo "  <".$s." align='center' style='color: #f3f3f3'>".$content['cstitle']. " </ ".$s." > ";
										  ?>
											  </div>
											  <div class="card-body">
												  <a href="index.php?course-app-course&csid={x2;v:content['csid']}" title={x2;v:content['ClassTitle']}>
												  <div class="card-text"><span class="fa fa-book" > </span>&nbsp;&nbsp;<?php echo substr($content['ClassTitle'] , 0 , 24); ?></div>
												  <div class="card-text"><span class="fa fa-user"> </span>&nbsp;&nbsp;{x2;v:content['author']}</div>
												  <div class="card-text"><span class="fa fa-podcast"> </span>&nbsp;&nbsp;{x2;v:content['publish']} </div>
												  <!--div class="card-text"><span class="fa fa-podcast"> </span> &nbsp;&nbsp;{x2;v:content['publishTime']} </div-->
												  </a>
											  </div>
											</div>
										</div>
										{x2;if:v:cid % 6 == 0}
											<div class="col-xs-12"><hr/></div>
										{x2;endif}

										{x2;endtree}
									</div>
								</div>

					
						

							
					{x2;endtree}
				<!-- 显示学校开设课程 -->
							</div>
							<div class="col-xs-12">
								<hr/>
								<p><ul class="pagination pagination-right">{x2;$contents['pages']}      </ul>
								</p>
							</div>
					
			</div>
		</div>
	</div>
</div>
{x2;include:footer}
</body>
</html>