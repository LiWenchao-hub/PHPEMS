<?php

header("Content-type:text/html;charset=utf-8"); //定义编码和页面
header("Access-Control-Allow-Origin: *"); //跨域问题
include ("connect_mysql.php");
//session_start();
//die($_POST["login"]);
//
if (!session_id()) session_start();

/*
if(isset($_POST["login"]) &&$_SERVER['REQUEST_METHOD']=="POST"){
   echo "提交过来了";
}else {
   echo "submit is no come~";
}
*/
//if (isset($_POST["login"]) && $_POST["login"] == "登录") {
if (isset($_POST["login"])) {

//die(isset($_POST["login"]));



//echo( $_POST['submit']);


    //die("ok");

    $IdCard = trim($_POST["IdCard"]); //用户电话号码
    $password = trim($_POST["password"]); //用户密码
    
    
    //require_once ('connect_mysql.php');
    //判断用户是否存在
    $sql = "SELECT * FROM temp_user WHERE IdCard = '$IdCard'";
    $result = mysqli_query($link, $sql); //执行sql语句,返回查询后的结果集
    $rows = mysqli_num_rows($result); //返回结果集中行的数量
    //echo($sql);
   // echo($password);
    if ($rows == 0) {
        //用户不存在
        
        $json_arr = array(
            'success' => - 1
        );
       /* echo "<div class='alert alert-warning' role='alert'>
                  <strong>警告！</strong>身份证号码错误！<a href='http://www.y-min.cn/info/login.html' class='close' data-dismiss='alert'><br>
        身份证号码输入错误，返回重新输入
    </a>
            </div>";
*/
        echo"<script>alert('身份证号码输入错误，返回重新输入');history.go(-1);</script>"; 


    } else {

        $sql = "SELECT * FROM temp_user WHERE password ='$password' AND IdCard = '$IdCard' ";
        $result = mysqli_query($link, $sql);
        $rows = mysqli_num_rows($result);
        
//die($sql);

        if ($rows == 1) {
            //密码正确
           
            $json_arr = array(
                'success' => 1
            );
 
            $arr = $result->fetch_row();

            $_SESSION["is_login"] = "true";
            $_SESSION["IdCard"] = $IdCard;
            $_SESSION["password"] = $password;


            $_SESSION["Username"] = $arr[2];
            $_SESSION["tel"] =  $arr[3];
            $_SESSION["sheng"] =  $arr[4];
            $_SESSION["dizhou"] =  $arr[5];
            $_SESSION["xianshi"] =  $arr[6];
            $_SESSION["xiangzhen"] =  $arr[7];
            $_SESSION["cun"] =  $arr[8];
            $_SESSION["back"] =  $arr[9];


           header('refresh:3;url=alter_info.php?p=$arr'); 
             
            
        } else {
            //密码错误
            //die($sql);
            $json_arr = array(
                'success' => - 2
            );
          /*  echo "<div class='alert alert-warning' role='alert'>
                  <strong>警告！</strong>密码错误！<br><a href='http://www.y-min.cn/info/login.html' class='close' data-dismiss='alert'>
                            返 回 重 新 输 入
                        </a>
                </div>";
*/
              echo"<script>alert('密码错误，返回重新输入');history.go(-1);</script>";     

        }
    }

    $login_json = json_encode($json_arr, TRUE); //转化为json数据

   // echo $login_json;
    //发送json数据
    // 
   //die(json_encode($arr, TRUE));
    // 页面跳转到修改页面
     
      
}
?>