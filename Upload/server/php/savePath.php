<?php
/**
 * Created by PhpStorm.
 * User: lenovo
 * Date: 2018/9/19
 * Time: 17:14
 */
include_once 'lib/config.inc.php';
$name=$_REQUEST["name"];//coursetitle
$url=$_REQUEST["url"];//course_files
$className=$_REQUEST["className"];//coursecsid->name
$courseid=$_REQUEST["courseid"];//coursecsid

//$sql="insert into nation values('{$className}','{$name}','{$url}')";//加引号，加中括号

//先连接数据库
$servername="localhost";
$username="root";
$userpassword="DRsXT5ZJ6Oi55LPQ";
$dbname = "exam";

$connent=new mysqli($servername,$username,$userpassword,$dbname);
if($connent->connect_error){
    die("连接失败: " . $connent->connect_error);
}else{
    echo "连接成功";
}




$sql="INSERT INTO `x2_course`
(`coursetitle`, `coursemoduleid`, `coursecsid`,
`coursethumb`, `courseuserid`, `courseinputtime`,
`coursemodifytime`, `coursesequence`, `coursedescribe`,
`course_files`, `releaseTime`)
VALUES
('{$name}',14,'{$courseid}',
    'app/core/styles/images/noimage.gif',1,'{$now}',
    '{$now}',0, '',
    '{$url}','')";
echo $sql;



if($connent->query($sql)==true){
    echo "数据写入成功";
}else{
    echo "写入失败: " . $connent->error."<br>";
}

//插入数据
/*$insertdata="insert into zh(name,age,email) values('zhanghao',23,'142*******112@110.com')";
if($connent->query($insertdata)==true){
	echo "插入数据成功";
}else{
	echo "Error insert data: " . $connent->error;
}*/
//也可以如下这么写 也比较简单一些
/*if (mysqli_query($connent, $insertdata)) {
    echo "插入数据成功";
} else {
    echo "Error insert data: " . $connent->error;
}*/
//插入多条数据
/*$insertdatas="insert into zh(name,age,email) values('test1',1,'1.com');";
$insertdatas .="insert into zh(name,age,email) values('tes2',2,'2.com');";
$insertdatas .="insert into zh(name,age,email) values('test3',3,'3.com')";
if ($connent->multi_query($insertdatas)==true) {
    echo "插入多条数据成功";
} else {
    echo "Error insert datas: " . $connent->error;
}*/
//关闭数据库
mysqli_close($connent);
?>