

<?php


//connect_mysql.php
header("Content-type:text/html;charset=utf-8");	//��������ҳ��

header("Access-Control-Allow-Origin: *");	//��������


//session_start();	//�����Ự
if (!session_id()) session_start();

$host = 'localhost'; //������ַ

//$host = '118.89.25.120';

$database = 'exam';   //���ݿ���

$username = 'root'; //���ݿ���û���

$password = 'DRsXT5ZJ6Oi55LPQ'; //���ݿ������

/*
 �������ݿ�
 */

$link = mysqli_connect($host, $username, $password);    

mysqli_select_db($link, "exam");

mysqli_query($link,"set names 'utf8'");//����ת��


if (!$link) {


    die("could not connect to the database.\n" . mysqli_error($link));//������Ӵ���
}





?>