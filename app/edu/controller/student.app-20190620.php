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
        $this->progress = $this->G->make('progress','user');
        $this->basic = $this->G->make('basic','exam');
        $this->favor = $this->G->make('favor','exam');
        $this->course = $this->G->make('course','course');
        $this->edu = $this->G->make('edu','edu');
        $majors = $this->edu->getAllMajor();
        $this->tpl->assign('majors',$majors);
        $grade = array();
        $t = date('Y')+1;
        for($i = 0;$i < 5;$i++)
        {
            $grade[] = $t - $i;
        }
        $this->tpl->assign('grade',$grade);
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
        $this->tpl->assign('u',$this->u);
        if(!method_exists($this,$action))
        {
            $action = "index";
        }
        $this->$action();
        exit;
    }
// 批量开通课程
    private function batopen()
    {
        $page = $this->ev->get('page');
        $page = $page > 1?$page:1;
        $userid = $this->ev->get('userid');
        $pdid = $this->ev->get('pdid');
        $detail = $this->edu->getPlanDetailById($pdid);
        $course = array();
        $basic = array();
        foreach($detail['pdcourse'] as $p)
        {
            if(!$course[$p])
            {
                $course[$p] = $this->course->getCourseById($p);
            }
            $args = array('ocuserid' => $userid,'occourseid'=>$p,'ocendtime' => TIME + 365*24*3600);
            $this->course->openCourse($args);
            $this->basic->openBasic(array('obuserid' => $userid,'obbasicid'=>$course[$p]['csbasicid'],'obendtime' => TIME + 365*24*3600));
        }
        $message = array(
            'statusCode' => 200,
            "message" => "操作成功",
            "callbackType" => "forward",
            "forwardUrl" => "index.php?edu-app-student"
        );
        $this->G->R($message);
    }

    private function open()
    {
        $userid = $this->ev->get('userid');
        $page = $this->ev->get('page')?$this->ev->get('page'):1;
        $user = $this->user->getUserById($userid);
        $args = array();
        $args[] = array("AND","planyear = :planyear","planyear",$user['normal_favor']);
        $args[] = array("AND","major = :major","major",$user['userreferrer']);
        $plan = $this->edu->getPlanByArgs($args);
        if($plan)
        {
            $args = array();
            $args[] = array("AND","pdplanid = :pdplanid","pdplanid",$plan['planid']);
            $details = $this->edu->getPlanDetailList($args,$page);
            $courses = $this->course->getAllCourses();
            $this->tpl->assign('courses',$courses);
        }
        $this->tpl->assign('user',$user);
        $this->tpl->assign('plan',$plan);
        $this->tpl->assign('details',$details);
        $this->tpl->display('student_open');
    }

    private function document()
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
        $args[] = array('AND',"usergroupid IN (8,10)");
        $args[] = array('AND',"usersequence =  :usersequence","usersequence",$this->cuser['usersequence']);
        if($search['usertruename'])$args[] = array('AND',"usertruename = :usertruename",'usertruename',$search['usertruename']);
        if($search['userid'])$args[] = array('AND',"userid = :userid",'userid',$search['userid']);
        if($search['normal_schID'])$args[] = array('AND',"normal_schID = :normal_schID",'normal_schID',$search['normal_schID']);
        if($search['username'])$args[] = array('AND',"username LIKE :username",'username','%'.$search['username'].'%');
        if($search['useremail'])$args[] = array('AND',"useremail  LIKE :useremail",'useremail','%'.$search['useremail'].'%');
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
        if($search['mobile'])$args[] = array('AND',"mobile = :mobile",'mobile',$search['mobile']);
        if($search['normal_favor'])$args[] = array('AND',"normal_favor = :normal_favor",'normal_favor',$search['normal_favor']);
        if($search['userreferrer'])$args[] = array('AND',"userreferrer = :userreferrer",'userreferrer',$search['userreferrer']);
        if($search['normal_rest'])
        {
            if($search['normal_rest'] == 1)
                $args[] = array('AND',"normal_rest = 1");
            else
                $args[] = array('AND',"normal_rest = 0");
        }
        if($search['normal_finish'])
        {
            if($search['normal_finish'] == 1)
                $args[] = array('AND',"normal_finish = 1");
            else
                $args[] = array('AND',"normal_finish = 0");
        }
        if($search['userischeck'])
        {
            if($search['userischeck'] == 1)
                $args[] = array('AND',"userischeck = 1");
            else
                $args[] = array('AND',"userischeck = 0");
        }
        $users = $this->user->getUserList($page,100,$args);
        $this->tpl->assign('users',$users);
        $this->tpl->assign('search',$search);
        $this->tpl->assign('u',$u);
        $this->tpl->assign('page',$page);
        $this->tpl->display('student_document');
    }

    private function showscore()
    {
        $userid = $this->ev->get('userid');
        $user = $this->user->getUserById($userid);
        $this->module = $this->G->make('module');
        $appid = 'user';
        $app = $this->G->make('apps','core')->getApp($appid);
        $this->tpl->assign('app',$app);
        $fields = array();
        $tpfields = explode(',',$app['appsetting']['outfields']);
        foreach($tpfields as $f)
        {
            $tf = $this->module->getFieldByNameAndModuleid($f);
            if($tf && $tf['fieldappid'] == 'user')
            {
                $fields[$tf['fieldid']] = $tf;
            }
        }
        $page = $this->ev->get('page');
        $search = $this->ev->get('search');
        $basicid = intval($this->ev->get('basicid'));
        $basic = $this->basic->getBasicById($basicid);
        $page = $page > 0?$page:1;
        $args = array();
        $args[] = array('AND',"ehtype = '2'");
        $args[] = array('AND',"ehstatus = '1'");
        $args[] = array('AND',"ehuserid = :ehuserid",'ehuserid',$userid);
        if($search['stime'])
        {
            $stime = strtotime($search['stime']);
            $args[] = array('AND',"ehstarttime >= :stime",'stime',$stime);
        }
        if($search['etime'])
        {
            $etime = strtotime($search['etime']);
            $args[] = array('AND',"ehstarttime <= :etime",'etime',$etime);
        }
        if($search['sscore'])
        {
            $args[] = array('AND',"ehscore >= :sscore",'sscore',$search['sscore']);
        }
        if($search['escore'])
        {
            $args[] = array('AND',"ehscore <= :escore",'escore',$search['escore']);
        }
        $exams = $this->favor->getExamHistoryListByArgs($page,30,$args);
        $this->tpl->assign('user',$user);
        $this->tpl->assign('search',$search);
        $this->tpl->assign('basic',$basic);
        $this->tpl->assign('page',$page);
        $this->tpl->assign('fields',$fields);
        $this->tpl->assign('exams',$exams);
        $this->tpl->display('student_showscore');
    }

    private function score()
    {
        $this->module = $this->G->make('module');
        $appid = 'user';
        $app = $this->G->make('apps','core')->getApp($appid);
        $this->tpl->assign('app',$app);
        $fields = array();
        $tpfields = explode(',',$app['appsetting']['outfields']);
        foreach($tpfields as $f)
        {
            $tf = $this->module->getFieldByNameAndModuleid($f);
            if($tf && $tf['fieldappid'] == 'user')
            {
                $fields[$tf['fieldid']] = $tf;
            }
        }
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
        $args[] = array('AND',"usergroupid IN (8,10)");
        $args[] = array('AND',"usersequence =  :usersequence","usersequence",$this->cuser['usersequence']);
        if($search['userid'])$args[] = array('AND',"userid = :userid",'userid',$search['userid']);
        if($search['userreferrer'])$args[] = array('AND',"userreferrer = :userreferrer",'userreferrer',$search['userreferrer']);
        if($search['usertruename'])$args[] = array('AND',"usertruename = :usertruename",'usertruename',$search['usertruename']);
        if($search['normal_schID'])$args[] = array('AND',"normal_schID = :normal_schID",'normal_schID',$search['normal_schID']);
        if($search['username'])$args[] = array('AND',"username LIKE :username",'username','%'.$search['username'].'%');
        if($search['useremail'])$args[] = array('AND',"useremail  LIKE :useremail",'useremail','%'.$search['useremail'].'%');
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
        if($search['mobile'])$args[] = array('AND',"mobile = :mobile",'mobile',$search['mobile']);
        if($search['normal_favor'])$args[] = array('AND',"normal_favor = :normal_favor",'normal_favor',$search['normal_favor']);
        if($search['userreferrer'])$args[] = array('AND',"userreferrer = :userreferrer",'userreferrer',$search['userreferrer']);
        if($search['normal_rest'])
        {
            if($search['normal_rest'] == 1)
                $args[] = array('AND',"normal_rest = 1");
            else
                $args[] = array('AND',"normal_rest = 0");
        }
        if($search['normal_finish'])
        {
            if($search['normal_finish'] == 1)
                $args[] = array('AND',"normal_finish = 1");
            else
                $args[] = array('AND',"normal_finish = 0");
        }
        if($search['userischeck'])
        {
            if($search['userischeck'] == 1)
                $args[] = array('AND',"userischeck = 1");
            else
                $args[] = array('AND',"userischeck = 0");
        }
        $exams = $this->favor->getExamHistoryListByArgs($page,30,$args);
        $this->tpl->assign('exams',$exams);
        $this->tpl->assign('fields',$fields);
        $this->tpl->assign('search',$search);
        $this->tpl->assign('u',$u);
        $this->tpl->assign('page',$page);
        $this->tpl->display('student_score');
    }

    private function outscore()
    {
        $this->favor = $this->G->make('favor','exam');
        $this->files = $this->G->make('files');
        $search = $this->ev->get('search');
        $args = array();
        $userid = $this->ev->get('userid');
        if($userid)
        {
            $fname = 'data/score/'.TIME.'-'.$userid.'-score.csv';
            //$args[] = array('AND',"usersequence =  :usersequence","usersequence",$this->cuser['usersequence']);
            $args[] =  array('AND',"ehuserid = :ehuserid",'ehuserid',$userid);
            $args[] =  array('AND',"ehneedresit = 0");
            $args[] =  array('AND',"ehtype = 2");
            $args[] = array('AND',"usergroupid IN (8,10)");
            $args[] = array('AND',"usersequence =  :usersequence","usersequence",$this->cuser['usersequence']);
            if($search['stime'])
            {
                $stime = strtotime($search['stime']);
                $args[] = array('AND',"ehstarttime >= :stime",'stime',$stime);
            }
            if($search['etime'])
            {
                $etime = strtotime($search['etime']);
                $args[] = array('AND',"ehstarttime <= :etime",'etime',$etime);
            }
            if($search['sscore'])
            {
                $args[] = array('AND',"ehscore >= :sscore",'sscore',$search['sscore']);
            }
            if($search['escore'])
            {
                $args[] = array('AND',"ehscore <= :escore",'escore',$search['escore']);
            }
            if($search['examid'])
            {
                $args[] = array('AND',"ehexamid = :ehexamid",'ehexamid',$search['examid']);
            }
            $sf = array('ehusername','ehscore','ehexam','ehstarttime');
            $rs = $this->favor->getAllExamHistoryByArgs($args,$sf);
            $r = array();
            foreach($rs as $p)
            {
                $tmp = array('ehexam' => iconv("UTF-8","GBK",$p['ehexam']),'ehscore' => $p['ehscore']);
                $tmp['ehstarttime'] = date('Y-m-d H:i:s',$p['ehstarttime']);
                $r[] = $tmp;
            }
            if($this->files->outCsv($fname,$r))
                $message = array(
                    'statusCode' => 200,
                    "message" => "成绩导出成功，转入下载页面，如果浏览器没有相应，请<a href=\"{$fname}\">点此下载</a>",
                    "callbackType" => 'forward',
                    "forwardUrl" => "{$fname}"
                );
            else
                $message = array(
                    'statusCode' => 300,
                    "message" => "成绩导出失败"
                );
        }
        else
            $message = array(
                'statusCode' => 300,
                "message" => "请选择用户"
            );
        exit(json_encode($message));
    }

    private function batoutscore()
    {
        $this->favor = $this->G->make('favor','exam');
        $this->files = $this->G->make('files');
        $search = $this->ev->get('search');
        $args = array();
        $appid = 'user';
        $app = $this->G->make('apps','core')->getApp($appid);
        $this->tpl->assign('app',$app);
        $fields = array();
        $tpfields = explode(',',$app['appsetting']['outfields']);
        foreach($tpfields as $f)
        {
            $tf = $this->module->getFieldByNameAndModuleid($f);
            if($tf && $tf['fieldappid'] == 'user')
            {
                $fields[$tf['fieldid']] = $tf;
            }
        }

        $fname = 'data/score/'.TIME.'-'.$userid.'-score.csv';
        $args[] =  array('AND',"ehneedresit = 0");
        $args[] =  array('AND',"ehtype = 2");
        $args[] = array('AND',"usergroupid IN (8,10)");
        $args[] = array('AND',"usersequence =  :usersequence","usersequence",$this->cuser['usersequence']);
        if($search['stime'])
        {
            $stime = strtotime($search['stime']);
            $args[] = array('AND',"ehstarttime >= :stime",'stime',$stime);
        }
        if($search['etime'])
        {
            $etime = strtotime($search['etime']);
            $args[] = array('AND',"ehstarttime <= :etime",'etime',$etime);
        }
        if($search['sscore'])
        {
            $args[] = array('AND',"ehscore >= :sscore",'sscore',$search['sscore']);
        }
        if($search['escore'])
        {
            $args[] = array('AND',"ehscore <= :escore",'escore',$search['escore']);
        }
        if($search['examid'])
        {
            $args[] = array('AND',"ehexamid = :ehexamid",'ehexamid',$search['examid']);
        }
        if($search['userid'])$args[] = array('AND',"userid = :userid",'userid',$search['userid']);
        if($search['username'])$args[] = array('AND',"username LIKE :username",'username','%'.$search['username'].'%');
        if($search['useremail'])$args[] = array('AND',"useremail  LIKE :useremail",'useremail','%'.$search['useremail'].'%');
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
        if($search['mobile'])$args[] = array('AND',"mobile = :mobile",'mobile',$search['mobile']);
        if($search['normal_favor'])$args[] = array('AND',"normal_favor = :normal_favor",'normal_favor',$search['normal_favor']);
        if($search['userreferrer'])$args[] = array('AND',"userreferrer = :userreferrer",'userreferrer',$search['userreferrer']);
        $sf = array('ehusername','ehscore','ehexam','ehstarttime');
        foreach($fields as $p)
        {
            $sf[] = $p['field'];
        }
        $rs = $this->favor->getAllExamHistoryByArgs($args,$sf);
        $r = array();
        foreach($rs as $p)
        {
            $tmp = array('ehusername' => iconv("UTF-8","GBK",$p['ehusername']),'ehexam' => iconv("UTF-8","GBK",$p['ehexam']),'ehscore' => $p['ehscore']);
            $tmp['ehstarttime'] = date('Y-m-d H:i:s',$p['ehstarttime']);
            foreach($fields as $ps)
            {
                $tmp[$ps['field']] = iconv("UTF-8","GBK",$p[$ps['field']]);
            }
            $r[] = $tmp;
        }
        if($this->files->outCsv($fname,$r))
            $message = array(
                'statusCode' => 200,
                "message" => "成绩导出成功，转入下载页面，如果浏览器没有相应，请<a href=\"{$fname}\">点此下载</a>",
                "callbackType" => 'forward',
                "forwardUrl" => "{$fname}"
            );
        else
            $message = array(
                'statusCode' => 300,
                "message" => "成绩导出失败"
            );
        exit(json_encode($message));
    }

    private function showprocess()
    {
        $userid = $this->ev->get('userid');
        $user = $this->user->getUserById($userid);
        $page = $this->ev->get('page');
        $args = array(array("AND","prsuserid = userid"));
        $args[] = array("AND","prsuserid = :prsuserid","prsuserid",$userid);
        $progresses = $this->progress->getUserProgressesListByArgs($args,$page);
        $courses = array();
        $basics = array();
        foreach($progresses['data'] as $p)
        {
            if(!$courses[$p['prscourseid']])
                $courses[$p['prscourseid']] = $this->course->getCourseById($p['prscourseid']);
            if(!$basics[$p['prsexamid']])
                $basics[$p['prsexamid']] = $this->basic->getBasicById($p['prsexamid']);
        }
        $this->tpl->assign('status',array('未完成','已完成'));
        $this->tpl->assign('basics',$basics);
        $this->tpl->assign('user',$user);
        $this->tpl->assign('courses',$courses);
        $this->tpl->assign('progresses',$progresses);
        $this->tpl->display('student_showprocess');
    }

    private function show()
    {
        $userid = $this->ev->get('userid');
        $user = $this->user->getUserById($userid);
        $group = $this->user->getGroupById($user['usergroupid']);
        $fields = $this->module->getMoudleFields($group['groupmoduleid'],array('iscurrentuser'=> $userid == $this->_user['sessionuserid'],'group' => $this->user->getGroupById(1)),'user');
        $infos = $this->html->buildInfo($fields,$user);
        $this->tpl->assign('moduleid',$group['groupmoduleid']);
        $this->tpl->assign('infos',$infos);
        $this->tpl->assign('user',$user);
        $this->tpl->display('student_show');
    }

    private function outprocess()
    {
        $this->files = $this->G->make('files');
        $search = $this->ev->get('search');
        $args = array();
        $userid = $this->ev->get('userid');
        if($userid)
        {
            $fname = 'data/score/'.TIME.'-'.$userid.'-process.csv';
            $args[] =  array('AND',"prsuserid = :prsuserid",'prsuserid',$userid);
            $rs = $this->progress->getProgressesByArgs($args);
            $r = array();
            foreach($rs as $p)
            {
                $tmp = array();
                $tmp['course'] = iconv("UTF-8","GBK",$p['cstitle']);
                $tmp['prspersent'] = $p['prspersent'].'%';
                $tmp['basic'] = iconv("UTF-8","GBK",$p['basic']);
                $tmp['basicpersent'] = $p['prsexamstatus']?'100%':'0%';
                $r[] = $tmp;
            }
            if($this->files->outCsv($fname,$r))
                $message = array(
                    'statusCode' => 200,
                    "message" => "成绩导出成功，转入下载页面，如果浏览器没有相应，请<a href=\"{$fname}\">点此下载</a>",
                    "callbackType" => 'forward',
                    "forwardUrl" => "{$fname}"
                );
            else
                $message = array(
                    'statusCode' => 300,
                    "message" => "成绩导出失败"
                );
        }
        else
            $message = array(
                'statusCode' => 300,
                "message" => "请选择用户"
            );
        exit(json_encode($message));
    }

    private function batoutprocess()
    {
        $this->files = $this->G->make('files');
        $search = $this->ev->get('search');
        $args = array();
        $fname = 'data/score/'.TIME.'-'.$userid.'-process.csv';
        $args[] = array('AND',"usergroupid IN (8,10)");
        $args[] = array('AND',"usersequence =  :usersequence","usersequence",$this->cuser['usersequence']);
        if($search['userid'])$args[] = array('AND',"userid = :userid",'userid',$search['userid']);
        if($search['username'])$args[] = array('AND',"username LIKE :username",'username','%'.$search['username'].'%');
        if($search['useremail'])$args[] = array('AND',"useremail  LIKE :useremail",'useremail','%'.$search['useremail'].'%');
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
        if($search['mobile'])$args[] = array('AND',"mobile = :mobile",'mobile',$search['mobile']);
        if($search['normal_favor'])$args[] = array('AND',"normal_favor = :normal_favor",'normal_favor',$search['normal_favor']);
        if($search['userreferrer'])$args[] = array('AND',"userreferrer = :userreferrer",'userreferrer',$search['userreferrer']);
        $rs = $this->progress->getAllUserProgressesByArgs($args);
        $r = array();
        foreach($rs as $p)
        {
            $tmp = array();
            $tmp['username'] = iconv("UTF-8","GBK",$p['username']);
            $tmp['course'] = iconv("UTF-8","GBK",$p['cstitle']);
            $tmp['prspersent'] = $p['prspersent'].'%';
            $tmp['basic'] = iconv("UTF-8","GBK",$p['basic']);
            $tmp['basicpersent'] = $p['prsexamstatus']?'100%':'0%';
            $r[] = $tmp;
        }
        if($this->files->outCsv($fname,$r))
            $message = array(
                'statusCode' => 200,
                "message" => "成绩导出成功，转入下载页面，如果浏览器没有相应，请<a href=\"{$fname}\">点此下载</a>",
                "callbackType" => 'forward',
                "forwardUrl" => "{$fname}"
            );
        else
            $message = array(
                'statusCode' => 300,
                "message" => "成绩导出失败"
            );
        exit(json_encode($message));
    }

    private function progress()
    {
        $this->log = $this->G->make('log','course');
        $this->content = $this->G->make('content','course');
        $page = $this->ev->get('page');
        $prsid = $this->ev->get('prsid');
        $progress = $this->progress->getProgressById($prsid);
        $logs = $this->log->getLogsByCsid($progress['prscourseid'],$progress['prsuserid']);
        $oknumber = $this->log->getPassedLogsNumberByCsid($progress['prscourseid'],$progress['prsuserid']);
        $args = array();
        $args[] = array("AND","coursecsid = :coursecsid","coursecsid",$progress['prscourseid']);
        $course = $this->course->getCourseById($progress['prscourseid']);
        $courses = $this->content->getCourseList($args,$page,30);
        $oknumber = intval($oknumber*100/$courses['number']);
        $user = $this->user->getUserById($progress['prsuserid']);
        $this->tpl->assign('user',$user);
        $this->tpl->assign('courses',$courses);
        $this->tpl->assign('logs',$logs);
        $this->tpl->assign('course',$course);
        $this->tpl->assign('progress',$progress);
        $this->tpl->assign('oknumber',$oknumber);
        $this->tpl->assign('courses',$courses);
        $this->tpl->display('student_process');
    }

    private function info()
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
        $args[] = array('AND',"usergroupid IN (8,10)");
        $args[] = array('AND',"usersequence =  :usersequence","usersequence",$this->cuser['usersequence']);
        if($search['userid'])$args[] = array('AND',"userid = :userid",'userid',$search['userid']);
        if($search['usertruename'])$args[] = array('AND',"usertruename LIKE :usertruename",'usertruename','%'.$search['usertruename'].'%');
        if($search['normal_schID'])$args[] = array('AND',"normal_schID = :normal_schID",'normal_schID',$search['normal_schID']);
        if($search['username'])$args[] = array('AND',"username LIKE :username",'username','%'.$search['username'].'%');
        if($search['useremail'])$args[] = array('AND',"useremail  LIKE :useremail",'useremail','%'.$search['useremail'].'%');
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
        if($search['mobile'])$args[] = array('AND',"mobile = :mobile",'mobile',$search['mobile']);
        if($search['normal_favor'])$args[] = array('AND',"normal_favor = :normal_favor",'normal_favor',$search['normal_favor']);
        if($search['userreferrer'])$args[] = array('AND',"userreferrer = :userreferrer",'userreferrer',$search['userreferrer']);
        if($search['normal_rest'])
        {
            if($search['normal_rest'] == 1)
                $args[] = array('AND',"normal_rest = 1");
            else
                $args[] = array('AND',"normal_rest = 0");
        }
        if($search['normal_finish'])
        {
            if($search['normal_finish'] == 1)
                $args[] = array('AND',"normal_finish = 1");
            else
                $args[] = array('AND',"normal_finish = 0");
        }
        if($search['userischeck'])
        {
            if($search['userischeck'] == 1)
                $args[] = array('AND',"userischeck = 1");
            else
                $args[] = array('AND',"userischeck = 0");
        }
        if($search['subject'])
        {
            $courses = $this->course->getAllCourses(array(array("AND","cssubjectid = :cssubjectid","cssubjectid",$search['subject'])));
            $ids = array();
            foreach($courses as $p)
            {
                $ids[] = $p['csid'];
            }
            $ids = implode(',',$ids);
            if(!$ids)$ids = '0';
            $args[] = array("AND","prscourseid in ({$ids})");
        }
        $progresses = $this->progress->getUserProgressesListByArgs($args,$page,100);
        $courses = array();
        $times = array();
        foreach($progresses['data'] as $p)
        {
            if(!$courses[$p['prscourseid']])
                $courses[$p['prscourseid']] = $this->course->getCourseById($p['prscourseid']);
            $times[$p['prsid']] = $this->course->getAllOpenCourseByUseridAndCsid($p['prsuserid'],$p['prscourseid']);
        }
        $this->tpl->assign('status',array('未完成','已完成'));
        $this->tpl->assign('times',$times);
        $this->tpl->assign('courses',$courses);
        $this->tpl->assign('progresses',$progresses);
        $this->tpl->assign('search',$search);
        $this->tpl->assign('u',$u);
        $this->tpl->assign('page',$page);
        $this->tpl->display('student_info');
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
                "forwardUrl" => "index.php?edu-app-student&page={$page}{$this->u}"
            );
            exit(json_encode($message));
        }
		elseif($this->ev->get('setteachsubject'))
        {
            $userid = $this->ev->get('userid');
            $user = $this->user->getUserById($userid);
            $modules = $this->module->getModulesByApp('user');
            if($modules[$user['groupmoduleid']]['modulecode'] != 'teacher')
            {
                $message = array(
                    'statusCode' => 300,
                    "message" => "此用户不是教师"
                );
                exit(json_encode($message));
            }
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
                "forwardUrl" => "index.php?edu-app-student&page={$page}{$this->u}"
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
                    "forwardUrl" => "index.php?edu-app-student&page={$page}{$this->u}"
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
            $this->tpl->display('student_modifyuser');
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
                    "forwardUrl" => "index.php?edu-app-student"
                );
                exit(json_encode($message));
            }
        }
        else
        {
            $this->tpl->display('student_batadduser');
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

                $search = $this->ev->get('search');
                unset($args['userpassword2']);
                $id = $this->user->insertUser($args);
                $message = array(
                    'statusCode' => 200,
                    "message" => "操作成功",
                    "callbackType" => "forward",
                    "forwardUrl" => "index.php?edu-app-student"
                );
                exit(json_encode($message));
            }
        }
        else
        {
            $modules = $this->module->getModulesByApp('user');
            $tmpmodules = array(
                '9' => $modules['9']
            );
            $fields = $this->module->getMoudleFields(9,array('iscurrentuser'=> false,'group' => $this->user->getGroupById(1)),'user');
            $forms = $this->html->buildHtml($fields);
            $this->tpl->assign('moduleid',9);
            $this->tpl->assign('fields',$fields);
            $this->tpl->assign('forms',$forms);
            $this->tpl->assign('modules',$tmpmodules);
            $this->tpl->display('student_adduser');
        }
    }

    private function modifyschoolstatus()
    {
        $userid = $this->ev->get('userid');
        if($this->ev->get('modifyuserinfo'))
        {
            $targs = $this->ev->get('args');
            if($targs['normal_finish'])
            $id = $this->user->modifyUserInfo(array('normal_finish' => 1),$userid);
            $message = array(
                'statusCode' => 200,
                "message" => "操作成功",
                "callbackType" => "forward",
                "forwardUrl" => "reload"
            );
            exit(json_encode($message));
        }
        else
        {
            $user = $this->user->getUserById($userid);
            $this->tpl->assign('user',$user);
            $this->tpl->display('student_modifyschoolstatus');
        }
    }

    private function modifystudystatus()
    {
        $userid = $this->ev->get('userid');
        if($this->ev->get('modifyuserinfo'))
        {
            $args = $this->ev->get('args');
            $id = $this->user->modifyUserInfo(array('normal_rest' => $args['normal_rest']),$userid);
            $message = array(
                'statusCode' => 200,
                "message" => "操作成功",
                "callbackType" => "forward",
                "forwardUrl" => "reload"
            );
            exit(json_encode($message));
        }
        else
        {
            $user = $this->user->getUserById($userid);
            $this->tpl->assign('user',$user);
            $this->tpl->display('student_modifystudystatus');
        }
    }

    private function modifymajor()
    {
        $userid = $this->ev->get('userid');
        if($this->ev->get('modifyuserinfo'))
        {
            $args = $this->ev->get('args');
            $id = $this->user->modifyUserInfo($args,$userid);
            $message = array(
                'statusCode' => 200,
                "message" => "操作成功",
                "callbackType" => "forward",
                "forwardUrl" => "reload"
            );
            exit(json_encode($message));
        }
        else
        {
            $user = $this->user->getUserById($userid);
            $majors = $this->edu->getAllMajor();
            $this->tpl->assign('majors',$majors);
            $this->tpl->assign('user',$user);
            $this->tpl->display('student_modifymajor');
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
        $args[] = array('AND',"usergroupid IN (8,10)");
        $args[] = array('AND',"usersequence =  :usersequence","usersequence",$this->cuser['usersequence']);
        if($search['userid'])$args[] = array('AND',"userid = :userid",'userid',$search['userid']);
        if($search['normal_schID'])$args[] = array('AND',"normal_schID = :normal_schID",'normal_schID',$search['normal_schID']);
        if($search['username'])$args[] = array('AND',"username LIKE :username",'username','%'.$search['username'].'%');
        if($search['useremail'])$args[] = array('AND',"useremail  LIKE :useremail",'useremail','%'.$search['useremail'].'%');
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
        if($search['mobile'])$args[] = array('AND',"mobile = :mobile",'mobile',$search['mobile']);
        if($search['normal_favor'])$args[] = array('AND',"normal_favor = :normal_favor",'normal_favor',$search['normal_favor']);
        if($search['userreferrer'])$args[] = array('AND',"userreferrer = :userreferrer",'userreferrer',$search['userreferrer']);
        if($search['normal_rest'])
        {
            if($search['normal_rest'] == 1)
                $args[] = array('AND',"normal_rest = 1");
            else
                $args[] = array('AND',"normal_rest = 0");
        }
        if($search['normal_finish'])
        {
            if($search['normal_finish'] == 1)
                $args[] = array('AND',"normal_finish = 1");
            else
                $args[] = array('AND',"normal_finish = 0");
        }
        if($search['userischeck'])
        {
            if($search['userischeck'] == 1)
                $args[] = array('AND',"userischeck = 1");
            else
                $args[] = array('AND',"userischeck = 0");
        }
        $users = $this->user->getUserList($page,100,$args);
        $this->tpl->assign('users',$users);
        $this->tpl->assign('search',$search);
        $this->tpl->assign('u',$u);
        $this->tpl->assign('page',$page);
    	$this->tpl->display('student_index');
    }
}


?>
