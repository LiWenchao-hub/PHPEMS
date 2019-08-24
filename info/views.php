
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


?>

 

<html>
 <head>
  <title> 信息预览 </title>
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
 <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

 </head>

 <body>
   <div class="container-fluid">
    <div class="row-fluid">
        <div align="left">
            
                <fieldset>
                     <legend>姓名：<?php echo $_SESSION["Username"]?></legend>
                     <legend>身份证：<?php echo $_SESSION["IdCard"]?></legend>


                    <dl class="dl-horizontal">
                      <dt>联系电话     </dt>
                      <dd>
                      <?php echo $_SESSION['tel'] ?>
                      </dd>
                    </dl>

                    <dl class="dl-horizontal">
                      <dt>省           </dt>
                      <dd><?php echo $_SESSION['sheng'] ?></dd>
                    </dl>

                    <dl class="dl-horizontal">
                      <dt>联系电话     </dt>
                      <dd>
                      <?php echo $_SESSION['tel'] ?>
                      </dd>
                    </dl>

                    <dl class="dl-horizontal">
                      <dt>地州        </dt>
                      <dd><?php echo $_SESSION['dizhou'] ?></dd>
                    </dl>

                    <dl class="dl-horizontal">
                      <dt>县市         </dt>
                      <dd><?php echo $_SESSION['xianshi'] ?></dd>
                    </dl>

                    <dl class="dl-horizontal">
                      <dt>乡镇（街道） </dt>
                      <dd><?php echo $_SESSION['xiangzhen']  ?></dd>
                    </dl>

                    <dl class="dl-horizontal">
                      <dt>村（社区）   </dt>
                      <dd><?php echo $_SESSION['cun'] ?></dd>
                    </dl>

                    <dl class="dl-horizontal">
                      <dt>备注</dt>
                      <dd><?php echo $_SESSION['back'] ?></dd>
                    </dl>



                   
                </fieldset>
           
            
        </div>
    </div>
</div>
 </body>
</html>
