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
        $this->cuser = $this->user->getUserById($this->_user['sessionuserid']);
        $this->module = $this->G->make('module');
        $action = $this->ev->url(3);
        $search = $this->ev->get('search');
        $this->u = '';
        if($search)
        {
            $this->tpl->assign('search',$search);
            foreach($search as $key => $arg)
            {
                $this->u .= "&search[{$key}]={$arg}";
            }
        }
        $this->tpl->assign('search',$search);
        if(!method_exists($this,$action))
        {
            $action = "index";
        }
        $this->$action();
        exit;
    }

    private function del()
    {
        $page = $this->ev->get('page');
        $userid = $this->ev->get('userid');
        $this->user->delUserById($userid);
        $message = array(
            'statusCode' => 200,
            "message" => "操作成功",
            "callbackType" => "forward",
            "forwardUrl" => "reload"
        );
        exit(json_encode($message));
    }

    private function batdel()
    {
        if($this->ev->get('action') == 'delete')
        {
            $page = $this->ev->get('page');
            $delids = $this->ev->get('delids');
            foreach($delids as $userid => $p)
            {
                $this->user->delUserById($userid);
            }
            $message = array(
                'statusCode' => 200,
                "message" => "操作成功",
                "callbackType" => "forward",
                "forwardUrl" => "reload"
            );
            exit(json_encode($message));
        }
    }

    private function modify()
    {
        $page = $this->ev->get('page');
        if($this->ev->get('modifyusergroup'))
        {
            $groupid = $this->ev->get('groupid');
            $userid = $this->ev->get('userid');
            $this->user->modifyUserGroup($groupid,$userid);
            $message = array(
                'statusCode' => 200,
                "message" => "操作成功",
                "callbackType" => "forward",
                "forwardUrl" => "index.php?edu-app-teacher&page={$page}{$this->u}"
            );
            exit(json_encode($message));
        }
        elseif($this->ev->get('setteachsubject'))
        {
            $userid = $this->ev->get('userid');
            $user = $this->user->getUserById($userid);
            $modules = $this->module->getModulesByApp('user');
            $subjects = $this->ev->get('subjects');
            if($modules[$user['groupmoduleid']]['modulecode'] != 'teacher')
            {
                $message = array(
                    'statusCode' => 300,
                    "message" => "此用户不是教师"
                );
                exit(json_encode($message));
            }
            $this->user->modifyUserInfo(array('teacher_subjects' => $subjects),$userid);
            $message = array(
                'statusCode' => 200,
                "message" => "操作成功",
                "callbackType" => "forward",
                "forwardUrl" => "reload"
            );
            exit(json_encode($message));
        }
        elseif($this->ev->get('modifyuserinfo'))
        {
            $args = $this->ev->get('args');
            $userid = $this->ev->get('userid');
            $user = $this->user->getUserById($userid);
            $group = $this->user->getGroupById($user['usergroupid']);
            $args = $this->module->tidyNeedFieldsPars($args,$group['groupmoduleid'],array('iscurrentuser'=> $userid == $this->_user['sessionuserid'],'group' => $this->user->getGroupById(1)),'user');
            $id = $this->user->modifyUserInfo($args,$userid);
            $message = array(
                'statusCode' => 200,
                "message" => "操作成功",
                "callbackType" => "forward",
                "forwardUrl" => "index.php?edu-app-teacher&page={$page}{$this->u}"
            );
            exit(json_encode($message));
        }
        elseif($this->ev->get('modifyuserpassword'))
        {
            $args = $this->ev->get('args');
            $userid = $this->ev->get('userid');
            if($args['password'] == $args['password2'] && $userid)
            {
                $id = $this->user->modifyUserPassword($args,$userid);
                $message = array(
                    'statusCode' => 200,
                    "message" => "操作成功",
                    "callbackType" => "forward",
                    "forwardUrl" => "index.php?edu-app-teacher&page={$page}{$this->u}"
                );
                exit(json_encode($message));
            }
            else
            {
                $message = array(
                    'statusCode' => 300,
                    "message" => "操作失败"
                );
                exit(json_encode($message));
            }
        }
        else
        {
            $userid = $this->ev->get('userid');
            $user = $this->user->getUserById($userid);
            $group = $this->user->getGroupById($user['usergroupid']);
            $fields = $this->module->getMoudleFields($group['groupmoduleid'],array('iscurrentuser'=> $userid == $this->_user['sessionuserid'],'group' => $this->user->getGroupById(1)),'user');
            $forms = $this->html->buildHtml($fields,$user);
            $this->tpl->assign('moduleid',$group['groupmoduleid']);
            $this->tpl->assign('fields',$fields);
            $this->tpl->assign('forms',$forms);
            $this->tpl->assign('user',$user);
            $this->tpl->assign('page',$page);
            $this->tpl->display('teacher_modifyuser');
        }
    }

    private function batadd()
    {
        if($this->ev->post('insertUser'))
        {
            $uploadfile = $this->ev->get('uploadfile');
            if(!file_exists($uploadfile))
            {
                $message = array(
                    'statusCode' => 300,
                    "message" => "上传文件不存在"
                );
                exit(json_encode($message));
            }
            else
            {
                setlocale(LC_ALL,'zh_CN');
                $handle = fopen($uploadfile,"r");
                $strings = $this->G->make('strings');
                $app = $this->G->make('apps','core')->getApp('user');
                $tpfields = explode(',',$app['appsetting']['regfields']);
                while ($data = fgetcsv($handle))
                {

                    if($data[0] && $data[1])
                    {
                        $args = array();
                        $args['username'] = iconv("GBK","UTF-8",$data[0]);
                        if($strings->isUserName($args['username']))
                        {
                            $u = $this->user->getUserByUserName($args['username']);
                            if(!$u)
                            {
                                $args['useremail'] = $data[1];
                                if($strings->isEmail($args['useremail']))
                                {
                                    $u = $this->user->getUserByEmail($args['useremail']);
                                    if(!$u)
                                    {
                                        if(!$data[2])$data[2] = '111111';
                                        $args['userpassword'] = md5($data[2]);
                                        $args['usergroupid'] = 9;
                                        $i = 3;
                                        foreach($tpfields as $p)
                                        {
                                            $args[$p] = iconv("GBK","UTF-8",$data[$i]);
                                            $i++;
                                        }
                                        $this->user->insertUser($args);
                                    }
                                }
                            }
                        }
                    }
                }
                fclose($handle);
                $message = array(
                    'statusCode' => 200,
                    "message" => "操作成功",
                    "callbackType" => "forward",
                    "forwardUrl" => "index.php?edu-app-teacher"
                );
                exit(json_encode($message));
            }
        }
        else
        {
            $this->tpl->display('teacher_batadduser');
        }
    }

    private function add()
    {
        if($this->ev->post('insertUser'))
        {
            $args = $this->ev->post('args');
            if($args['userpassword'] == $args['userpassword2'])
            {
                $userbyname = $this->user->getUserByUserName($args['username']);
                $userbyemail = $this->user->getUserByEmail($args['useremail']);
                if($userbyname)
                    $errmsg = "这个用户名已经被注册了";
                if($userbyemail)
                    $errmsg = "这个邮箱已经被注册了";
                if($errmsg)
                {
                    $message = array(
                        'statusCode' => 300,
                        "message" => "{$errmsg}"
                    );
                    exit(json_encode($message));
                }
                $args['userpassword'] = md5($args['userpassword']);
                $args['usergroupid'] = 9;
                $search = $this->ev->get('search');
                unset($args['userpassword2']);
                $id = $this->user->insertUser($args);
                $message = array(
                    'statusCode' => 200,
                    "message" => "操作成功",
                    "callbackType" => "forward",
                    "forwardUrl" => "index.php?edu-app-teacher"
                );
                exit(json_encode($message));
            }
        }
        else
        {
            $group = $this->user->getGroupById(9);
            $fields = $this->module->getMoudleFields($group['groupmoduleid'],array('iscurrentuser'=> false,'group' => $this->user->getGroupById(1)),'user');
            $forms = $this->html->buildHtml($fields);
            $this->tpl->assign('moduleid',$group['groupmoduleid']);
            $this->tpl->assign('fields',$fields);
            $this->tpl->assign('forms',$forms);
            $this->tpl->display('teacher_adduser');
        }
    }

    private function index()
    {
        $page = $this->ev->get('page')?$this->ev->get('page'):1;
        $search = $this->ev->get('search');
        $u = '';
        if($search)
        {
            foreach($search as $key => $arg)
            {
                $u .= "&search[{$key}]={$arg}";
            }
        }
        $args = array();
        $args[] = array('AND',"usergroupid = 9");
        $args[] = array('AND',"usersequence =  :usersequence","usersequence",$this->cuser['usersequence']);
        if($search['userid'])$args[] = array('AND',"userid = :userid",'userid',$search['userid']);
        if($search['username'])$args[] = array('AND',"username LIKE :username",'username','%'.$search['username'].'%');
        if($search['useremail'])$args[] = array('AND',"useremail  LIKE :useremail",'useremail','%'.$search['useremail'].'%');
        if($search['mobile'])$args[] = array('AND',"mobile LIKE :mobile",'mobile','%'.$search['mobile'].'%');
        if($search['stime'] || $search['etime'])
        {
            if(!is_array($args))$args = array();
            if($search['stime']){
                $stime = strtotime($search['stime']);
                $args[] = array('AND',"userregtime >= :userregtime",'userregtime',$stime);
            }
            if($search['etime']){
                $etime = strtotime($search['etime']);
                $args[] = array('AND',"userregtime <= :userregtime",'userregtime',$etime);
            }
        }
        $users = $this->user->getUserList($page,100,$args);
        $this->tpl->assign('users',$users);
        $this->tpl->assign('search',$search);
        $this->tpl->assign('u',$u);
        $this->tpl->assign('page',$page);
    	$this->tpl->display('teacher_index');
    }
}


?>