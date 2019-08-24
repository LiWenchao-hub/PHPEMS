

<?php


//connect_mysql.php
header("Content-type:text/html;charset=utf-8");	//定义编码和页面

header("Access-Control-Allow-Origin: *");	//跨域问题


//session_start();	//开启会话
if (!session_id()) session_start();

$host = 'localhost'; //主机地址

//$host = '118.89.25.120';

$database = 'exam';   //数据库名

$username = 'root'; //数据库的用户名

$password = 'DRsXT5ZJ6Oi55LPQ'; //数据库的密码

/*
 连接数据库
 */

$link = mysqli_connect($host, $username, $password);    

mysqli_select_db($link, "exam");

mysqli_query($link,"set names 'utf8'");//编码转化


if (!$link) {


    die("could not connect to the database.\n" . mysqli_error($link));//诊断连接错误
}





?>