<?php

/*
 * Created on 2016-5-19
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */

class action extends app
{
    public function display()
    {
        $this->edu = $this->G->make('edu', 'edu');
        $action = $this->ev->url(3);
        if (!method_exists($this, $action))
            $action = "index";
        $this->$action();
        exit;
    }

    private function del()
    {
        $msgid = $this->ev->get('msgid');
        $this->edu->delMsg($msgid);
        $message = array(
            'statusCode' => 200,
            "message" => "操作成功",
            "callbackType" => "forward",
            "forwardUrl" => "reload"
        );
        $this->G->R($message);
    }

    private function modify()
    {
        $msgid = $this->ev->get('msgid');
        $msg = $this->edu->getMsgById($msgid);
        if ($this->ev->get('submit')) {
            $args = $this->ev->get('args');
            $this->edu->modifyMsg($msgid, $args);
            $message = array(
                'statusCode' => 200,
                "message" => "操作成功",
                "callbackType" => "forward",
                "forwardUrl" => "index.php?edu-app-message"
            );
            $this->G->R($message);
        } else {
            $this->tpl->assign('msg', $msg);
            $this->tpl->display('message_modify');
        }
    }

    private function add()
    {
        if ($this->ev->get('submit')) {
            $args = $this->ev->get('args');
//            $formdate = date("Y-m-d", time());
            $args['msgtime'] = TIME;
            $grade = $args['grade'];
            $major = $args['major'];
            if($grade!=null&&$major!=null){
                $msggroups = $grade . "-" . $major;
                $args['msggroups'] = $msggroups;
            }else{
                $msggroups = "0";
                $args['msggroups'] = $msggroups;
            }
            $this->edu->addMsg($args);
            $message = array(
                'statusCode' => 200,
                "message" => "操作成功",
                "callbackType" => "forward",
                "forwardUrl" => "index.php?edu-app-message"
            );
            $this->G->R($message);
        } else {
            $userid = $this->ev->get('userid');
            $user = $this->user->getUserById($userid);
            $this->tpl->assign('userid', $user['normal_schID']);
            $this->tpl->display('message_add');
        }
    }
    /*通过AJAX得到年级数据*/
    private function getGrade()
    {
        //得到所有计划年级
        $plans = $this->edu->getGrade();
        echo json_encode($plans);
        exit;
    }

    /*通过AJAX得到对应年级的计划课程数据*/
    private function getMajor()
    {
        $grade = $this->ev->get("grade");
        //得到对应的专业
        $magor = $this->edu->getMajor($grade);
        echo json_encode($magor);
        exit;
    }

    private function index()
    {
        $page = $this->ev->get('page') ? $this->ev->get('page') : 1;
        $args = array();
        $msgs = $this->edu->getMsgList($args, $page);
        //得到数据库中存放的数据
        $datas = $msgs['data'];
        //得到总条数
        $counts = count($datas);
        //定义变量得到处理过的数据
        $newmsgs = array();
        //遍历数组处理数据
        for ($i = 0; $i < $counts; $i++) {
            $the_msg = $datas[$i];
            $msggroups_val = $the_msg["msggroups"];//用户组
            $msgusers_val = $the_msg["msgusers"];//用户
            if ($msggroups_val != "0" && $msggroups_val != "") {
                $the_msg["msggroups_msgusers"] = $msggroups_val;
            } else if ($msgusers_val != "0" && $msgusers_val != "") {
                $the_msg["msggroups_msgusers"] = $msgusers_val;
            } else {
                $the_msg["msggroups_msgusers"] = "";
            }
            array_push($newmsgs, $the_msg);
        }
        $msgs["newdata"] = $newmsgs;
        $this->tpl->assign('msgs', $msgs);
        $this->tpl->display('message');
    }


}


?>
