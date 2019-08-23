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
							<li><a href="index.php?{x2;$_app}-app">学生中心</a></li>
							<li class="active">学习进度</li>
						</ol>
					</div>
				</div>
				<div class="box itembox" style="padding-top:10px;">
					<h4 class="title">我的学习进度</h4>
					<table class="table table-hover table-bordered">
						<thead>
						<tr class="info">
							<!--th>ID</th-->
							<th class="col-xs-3">课程</th>
							<!--th>课程状态</th>
							<th>考试</th>
							<th>考试状态</th-->
							<th class="col-xs-1">开课时间</th>
							<th class="col-xs-1">结课时间</th>
							<th class="col-xs-3">学习进度</th>
							<th class="col-xs-2">备  注</th>
						</tr>
						</thead>
						<tbody>


				<?php
						
						


//     进度条显示函数


						function ClassProgress($userid,$coursecsid)
						{


						$dbhost = 'localhost:3306';  // mysql服务器主机地址
						$dbuser = 'root';            // mysql用户名
						$dbpass = 'DRsXT5ZJ6Oi55LPQ';          // mysql用户名密码
						$conn = mysqli_connect($dbhost, $dbuser, $dbpass);
						if(! $conn )
						{
						    die('连接失败: ' . mysqli_error($conn));
						}
						// 设置编码，防止中文乱码
						mysqli_query($conn , "set names utf8");
						mysqli_select_db( $conn, 'exam' );
						//echo "conn<br>";
						//echo "<pre>";
						//var_dump($conn);
						//echo "</pre>";

/*

							$sqlProgress = "
											SELECT
												logstatus,
												COUNT(*) as num
											FROM
												x2_log
											WHERE
												loguserid =".$userid."
											AND logcourseid IN (
												SELECT
													courseid
												FROM
													x2_course
												WHERE
													coursecsid = ".$coursecsid."
											)
											GROUP BY
												logstatus";
*/
							$sqlProgress="
											SELECT
												(
													SELECT
														COUNT(*) AS num
													FROM
														x2_log
													WHERE
														loguserid =".$userid."
													AND logstatus = 1
													AND logcourseid IN (
														SELECT
															courseid
														FROM
															x2_course
														WHERE
															coursecsid = ".$coursecsid."
													)
												) AS finish,
												(
													SELECT
														COUNT(*)
													FROM
														x2_course
													WHERE
														coursecsid =  ".$coursecsid."
												) AS total

							";
							//echo $sqlProgress;
							//echo "<br>";

							$retval = mysqli_query( $conn, $sqlProgress );
							//print_r(mysql_fetch_row($retval));
							//var_dump($conn);
							//echo "<pre>";
							
							//var_dump($retval );
							//echo "</pre>";
							if(! $retval )
							{
							    die('无法读取进度数据: ' . mysqli_error($conn));
							}

							$progress=[0,0];//第一位保存已完成，第二位保存总课时
							//$i=0;
							while($row = mysqli_fetch_array($retval,MYSQLI_ASSOC))
							{
							  // echo "finish={$row['finish']}<br> ".
							         "total={$row['total']} <br> "."<br>";
								$progress=[(int)$row['finish'],(int)$row['total']];
							}

						
						$progressPercent=round($progress[0]*100/($progress[1]),2);
						//echo round($progress[1]*100/($progress[0]+$progress[1]),2)."<br>";
						//echo $progressPercent;
						return $progressPercent;


						mysqli_close($conn);
						}

				
						//echo $this->tpl_var['_user']['userid']."<br>";
						//echo "sqlProgress=".$sqlProgress."<br>";
						
						 


//课程有效期函数						

					function ClassPeriod($userid,$coursecsid){

						$dbhost = 'localhost:3306';  // mysql服务器主机地址
						$dbuser = 'root';            // mysql用户名
						$dbpass = 'DRsXT5ZJ6Oi55LPQ';          // mysql用户名密码
						$conn = mysqli_connect($dbhost, $dbuser, $dbpass);
						if(! $conn )
						{
						    die('连接失败: ' . mysqli_error($conn));
						}
						// 设置编码，防止中文乱码
						mysqli_query($conn , "set names utf8");
						mysqli_select_db( $conn, 'exam' );
						//echo "conn<br>";
						//echo "<pre>";
						//var_dump($conn);
						//echo "</pre>";



						$sqlEffectivePeriod="
												SELECT
													from_unixtime(`octime`) AS beginTime,
													from_unixtime(`ocendtime`) AS endTime
												FROM
													x2_opencourse
												WHERE
													ocuserid = ".$userid."
												AND occourseid = ".$coursecsid;

						//$sqlEffectivePeriod="SELECT from_unixtime( `obtime` ) as beginTime,from_unixtime( `obendtime` ) as endTime FROM x2_openbasics WHERE obuserid=".$userid."  AND obbasicid= ".$coursecsid;



						// echo "<br>sqlEffectivePeriod=".$sqlEffectivePeriod."<br>";
						$EffectivePeriod = mysqli_query( $conn, $sqlEffectivePeriod );
						if(! $EffectivePeriod )
						{
						    die('无法读取有效期数据: ' . mysqli_error($conn));
						}

						//echo $sqlEffectivePeriod;


						 $Period=[date("Y-m-d", strtotime("Today")),date("Y-m-d", strtotime("+6 Years")),6];//第一位保存开始时间，第二位保存截止时间,默认期限为三年,第三位保存0为非系统开通
						 $j=0;
						 //echo "<pre>";
						 //var_dump($EffectivePeriod);
						 //echo "</pre>";

						 $raw=mysqli_fetch_array($EffectivePeriod,MYSQLI_ASSOC);
						 //echo "<pre>";
						 //var_dump($raw);
						 //echo "</pre>";

						 

						 if($raw){
						 //echo "ok";
						 	$Period=[$raw["beginTime"],$raw["endTime"],0];
						 }
						// echo "<pre>";
						 //var_dump($Period);
						 //echo "</pre>";



						mysqli_close($conn);
						return $Period;

$d=strtotime("Today");
echo date("Y-m-d h:i:sa", $d) . "<br>";


$d=strtotime("tomorrow");
echo date("Y-m-d h:i:sa", $d) . "<br>";

$d=strtotime("next Saturday");
echo date("Y-m-d h:i:sa", $d) . "<br>";

$d=strtotime("+3 Months");
echo date("Y-m-d", strtotime("+3 Years")) . "<br>";




					}


						
						

?>







                        {x2;tree:$progresses['data'],progress,pid}

                        <?php 
								//echo $this->tpl_var['courses'][$progress['prscourseid']]['csid']."<br>";
								$P=ClassProgress($this->tpl_var['_user']['userid'],$this->tpl_var['courses'][$progress['prscourseid']]['csid']);
								//ClassProgress(1,41);

						?>
						<tr>
							<!--td>{x2;v:progress['prsid']}</td-->
							<td>{x2;$courses[v:progress['prscourseid']]['cstitle']}

							</td>
							<!--td>{x2;$status[v:progress['prscoursestatus']]}</td>
							<td>{x2;$basics[v:progress['prsexamid']]['basic']}</td>
							<td>{x2;$status[v:progress['prsexamstatus']]}</td-->
							<!--td>{x2;date:v:progress['prstime'],'Y-m-d'}</td>
							<td>{x2;if:v:progress['prsendtime']}{x2;date:v:progress['prsendtime'],'Y-m-d'}{x2;else}-{x2;endif}</td-->


<?php

							$myTime=ClassPeriod($this->tpl_var['_user']['userid'],$this->tpl_var['courses'][$progress['prscourseid']]['csid']);
							//	echo date("Y-m-d",strtotime($myTime[0]))."<br>";
							//	echo date("Y-m-d",strtotime($myTime[1]))."<br>";

?>
							
							<td style="font-size: 9pt"><?php    echo date("Y-m-d",strtotime($myTime[0])) ;                          ?></td>
							<td style="font-size: 9pt"><?php    echo date("Y-m-d",strtotime($myTime[1]))  ;                         ?></td>
							
							<!--td>{x2;$status[v:progress['prstatus']]}</td-->
							<td>

							<div class="progress">

							  <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow=" <?php echo $P; ?>" aria-valuemin="0" aria-valuemax="100" style="width: <?php echo $P; ?>%">
							    <font class="text text-danger" >
							     
							     <?php echo $P; ?>%


							     <?php 
							     	/*
							     	
							     	echo $P."%  距离结课时间还有".date_diff(date("Y/m/d"), date("Y/m/d",strtotime($myTime[1])))->format("%R%a 天"); 
							     	echo date("Y/m/d");
							     	echo strtotime($myTime[1]);
							     	echo date("Y/m/d",strtotime($myTime[1]))."<br>";
							     	echo date_diff(date("Y/m/d"),date("Y/m/d",strtotime($myTime[1])))->format("%R%a 天")."<br>";
							     	echo date_diff("2018/12/20","2019/07/12");


							     	 */			   


							     ?>



							     </font>
							  </div>
							</div>

							</td>

							<td  style="font-size: 9pt">
								<?php 
								//echo $this->tpl_var['_user']['userid']."<br>";
								//echo $this->tpl_var['courses'][$progress['prscourseid']]['csid']."<br>";
								//ClassProgress($this->tpl_var['_user']['userid'],$this->tpl_var['courses'][$progress['prscourseid']]['csid']);
								//ClassProgress(1,41);
								//echo $P;

								$myTime=ClassPeriod($this->tpl_var['_user']['userid'],$this->tpl_var['courses'][$progress['prscourseid']]['csid']);
								//echo date("Y-m-d",strtotime($myTime[0]))."<br>";
								//echo date("Y-m-d",strtotime($myTime[1]))."<br>";


								if($myTime[2]) {
										echo " 自选课程";

								}
								else
								{
									$diff=date_diff(date_create(date("Y/m/d")),date_create($myTime[1]));
									
									echo " <span class='glyphicon glyphicon-star' aria-hidden='true' style='color:#ff0000'></span>必修课程";

									echo "<br>您的可用学习时间还有".$diff->format("%R%a 天");

								}

								?>
							</td>
						</tr>
                        {x2;endtree}
						</tbody>
					</table>
					<ul class="pagination pagination-right">{x2;$progresses['pages']}</ul>
				</div>
			</div>
		</div>
	</div>
</div>
{x2;include:footer}


</body>
</html>