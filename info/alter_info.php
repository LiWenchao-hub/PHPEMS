
<?php

header("Content-type:text/html;charset=utf-8");
header("Access-Control-Allow-Origin: *");
//die(json_encode($_GET['p'], TRUE));
//session_start();
if (!session_id()) session_start();
//die($_SESSION["Username"]);
/*
if(isset($_POST["submit"]) &&$_SERVER['REQUEST_METHOD']=="POST"){
   echo "提交过来了";
}else {
   echo "submit is no come~";
}
*/
//echo( $_POST['submit']);

// if (isset($_POST['submit']) && $_POST['submit'] == "确认修改") {
if (isset($_POST['submit'])) {

   // var_dump(isset($_POST['submit']));
    //die($_POST['tel']);
    include "connect_mysql.php";    
    //require_once('connect_mysql.php');
    //die($_POST["submit"]);
    $IdCard=$_SESSION["IdCard"];
    $tel = $_POST['tel'];
    $sheng = $_POST['sheng']; 
    $dizhou = $_POST['dizhou'];   
    $xianshi= $_POST['xianshi'];
    $xiangzhen= $_POST['xiangzhen'];  
    $cun= $_POST['cun'];
    $back= $_POST['back'];     

    $sql = "UPDATE temp_user SET tel = '$tel',sheng = '$sheng',dizhou = '$dizhou',xianshi = '$xianshi',xiangzhen= '$xiangzhen',cun = '$cun', back = '$back' WHERE IdCard = '$IdCard'";
    //die($sql);

    $result = mysqli_query($link, $sql);


    if ($result) { 
 //修改信息成功

        $json_arr = array('success' => 1);

      // echo("信息修改成功！");
        echo"<script>alert('信息修改成功,退出系统！');</script>"; 
        header('refresh:3;url=login.html'); 
        session_destroy();
    }

    else { 
 //修改信息失败
 
       $json_arr = array('success' => 0);
       //echo("");

        echo"<script>alert('信息修改失败，返回重新输入');history.go(-1);</script>"; 
 
     }

    

$login_json = json_encode($json_arr);
 
  // echo $login_json;
}


?>

 

<html>
 <head>
  <title> 信息采集 </title>
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
 <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

 </head>

 <body>
   <div class="container-fluid">
    <div class="row">
        <div class="col-md-16" align="left" >
        <br>
            <form class="form-inline" action="alter_info.php" method="post">
                
                     <legend>姓名：<?php echo $_SESSION["Username"]?></legend>
                     <legend>身份证：<?php echo $_SESSION["IdCard"]?></legend>

<br>
                    <dl class="dl-horizontal col-md-12">
                      <dt class="col-md-4">联系电话     </dt>
                      <dd class="col-md-12">
                      <input type="text" name="tel"  size=45 value="<?php echo $_SESSION['tel'] ?>" placeholder="请输入11位手机号码"/>
                      </dd>
                    </dl>

                    <dl class="dl-horizontal  col-md-12">
                      <dt class="col-md-4">省           </dt>
                      <dd class="col-md-8"><input type="text"  name="sheng"  size=45 value="<?php echo $_SESSION['sheng'] ?>" placeholder="请输入入学前户籍地所在省"/></dd>
                    </dl>

                    

                    <dl class="dl-horizontal col-md-12">
                      <dt class="col-md-4">地州        </dt>
                      <dd class="col-md-8"><input type="text"  name="dizhou"  size=45 value="<?php echo $_SESSION['dizhou'] ?>" placeholder="请输入入学前户籍地所在地州"/></dd>
                    </dl>

                    <dl class="dl-horizontal col-md-12">
                      <dt class="col-md-4">县市         </dt>
                      <dd class="col-md-8"><input type="text"  name="xianshi"  size=45 value="<?php echo $_SESSION['xianshi'] ?>" placeholder="请输入入学前户籍地所在县市"/></dd>
                    </dl>

                    <dl class="dl-horizontal col-md-12">
                      <dt class="col-md-4">乡镇（街道） </dt>
                      <dd class="col-md-8"><input type="text"  name="xiangzhen"  size=45 value="<?php echo $_SESSION['xiangzhen']  ?>" placeholder="请输入入学前户籍地所在乡镇（街道）"/></dd>
                    </dl>

                    <dl class="dl-horizontal col-md-12">
                      <dt class="col-md-4">村（社区）   </dt>
                      <dd class="col-md-8"><input type="text"  name="cun"  size=45 value="<?php echo $_SESSION['cun'] ?>" placeholder="请输入入学前户籍地所在村（社区）"/></dd>
                    </dl>

                    <dl class="dl-horizontal col-md-12">
                      <dt class="col-md-4">备注</dt>
                      <dd class="col-md-8"><input type="textarea" id="back" name="back"   rows="80" class="form-control" value="<?php echo $_SESSION['back'] ?>" placeholder="如有姓名错误需更正信息请输入这里"  style="min-width: 100%" /></dd>
                    </dl>






                    <blockquote>

                    <dl class="dl-horizontal col-md-12">
                      <dt class="col-md-8"><footer> 新疆农业大学 <cite title="Source Title">继续教育学院 </cite>提醒您：</footer> </dt>
                      <dd class="col-md-8"><p class="bg-warning" >
                                  &nbsp;&nbsp;&nbsp;&nbsp;在认真核实您个人身份信息之后再提交，由于个人信息提交错误导致档案信息不实，后果自负！
                    </p></dd>
                    </dl>
                      
                      
                    </blockquote>


                    <div class="dl-horizontal col-md-8">
                    <p align=right>
                        <br/> <button  class="btn btn-primary btn-lg btn-block" type="submit" name="submit">提交</button>
                    </p>
                    </div>

                    
            
            </form>
            
        </div>
    </div>
</div>
 </body>
</html>

