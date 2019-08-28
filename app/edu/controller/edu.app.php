<?php
/*
 * Created on 2016-5-19
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
include("../../../info/connect_mysql.php");

//require_once dirname(__FILE__) . '/../../../medoo/Medoo.php';

class action extends app
{
	public function display()
	{
		$this->course = $this->G->make('course','course');
        $this->basic = $this->G->make('basic','exam');
        $this->edu = $this->G->make('edu','edu');
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
	    $action = $this->ev->url(3);
		if(!method_exists($this,$action))
		$action = "index";
		$this->$action();
		exit;
	}

    private function batopen()
    {
        $pdid = $this->ev->get('pdid');
        $detail = $this->edu->getPlanDetailById($pdid);
        $plan = $this->edu->getPlanById($detail['pdplanid']);
        $args = array();
        $args[] = array("AND","usergroupid IN (8,10)");
        $args[] = array("AND","normal_favor = :normal_favor","normal_favor",$plan['planyear']);
        $args[] = array("AND","userreferrer = :userreferrer","userreferrer",$plan['major']);
        $users = $this->user->getUserList(1,10,$args);
        $this->tpl->assign('users',$users);
        $this->tpl->assign('detail',$detail);
        $this->tpl->display('edu_batopen');
    }

    private function gobatopen()
    {
        $page = $this->ev->get('page');
        $page = $page > 1?$page:1;
        $pdid = $this->ev->get('pdid');
        $detail = $this->edu->getPlanDetailById($pdid);
        $plan = $this->edu->getPlanById($detail['pdplanid']);
        $args = array();
        $args[] = array("AND","usergroupid IN (8,10)");
        $args[] = array("AND","normal_favor = :normal_favor","normal_favor",$plan['planyear']);
        $args[] = array("AND","userreferrer = :userreferrer","userreferrer",$plan['major']);
        $users = $this->user->getUserList($page,10,$args,"userid asc");
        $course = array();
        $basic = array();
        foreach($detail['pdcourse'] as $p)
        {
            if(!$course[$p])
            {
                $course[$p] = $this->course->getCourseById($p);
            }
//            if(!$basic[$course[$p]['csbasicid']])
//            {
//                $basic[$course[$p]['csbasicid']] = $this->basic->getBasicById($course[$p]['csbasicid']);
//            }
            foreach($users['data'] as $u)
            {
                $args = array('ocuserid'=>$u['userid'],'occourseid'=>$p,'ocendtime' => TIME + 365*24*3600);
                $this->course->openCourse($args);
                $this->basic->openBasic(array('obuserid'=>$u['userid'],'obbasicid'=>$course[$p]['csbasicid'],'obendtime' => TIME + 365*24*3600));
            }
        }
        if(count($users['data']) < 10)
        {
            $this->tpl->assign('ok','1');
        }
        $this->tpl->assign('page',$page);
        $this->tpl->assign('users',$users);
        $this->tpl->assign('detail',$detail);
        $this->tpl->display('edu_gobatopen');
    }

    private function delmajor()
    {
        $majorid = $this->ev->get('majorid');
        $this->edu->delMajor($majorid);
        $message = array(
            'statusCode' => 200,
            "message" => "操作成功",
            "callbackType" => "forward",
            "forwardUrl" => "index.php?edu-app-edu-major"
        );
        $this->G->R($message);
    }

    private function addmajor()
    {
        if($this->ev->get('submit'))
        {
            $args = $this->ev->get('args');
            $major = $this->edu->getMajorByCode($args['majorcode']);
            if($major)
            {
                $message = array(
                    'statusCode' => 300,
                    "message" => "操作失败，请专业代码已经存在"
                );
                $this->G->R($message);
            }
            $this->edu->addMajor($args);
            $message = array(
                'statusCode' => 200,
                "message" => "操作成功",
                "callbackType" => "forward",
                "forwardUrl" => "index.php?edu-app-edu-major"
            );
            $this->G->R($message);
        }
        else
        $this->tpl->display('edu_addmajor');
    }

	private function major()
    {
        $page = $this->ev->get('page');
        $page = $page>1?$page:1;
        $args = array();
        $search = $this->ev->get('search');
        if($search['majorcode'])
            $args[] = array("AND","majorcode = :majorcode","majorcode",$search['majorcode']);
        if($search['major'])
            $args[] = array("AND","major like :major","major","%{$search['major']}%");
        $majors = $this->edu->getMajorList($args,$page,50);
        $this->tpl->assign('search',$search);
        $this->tpl->assign('majors',$majors);
        $this->tpl->display('edu_major');
    }

    private function delsubject()
    {
        $this->section = $this->G->make('section','exam');
        $subjectid = $this->ev->get('subjectid');
        $section = $this->section->getSectionByArgs(array(array("AND","sectionsubjectid = :sectionsubjectid",'sectionsubjectid',$subjectid)));
        if($section)
        {
            $message = array(
                'statusCode' => 300,
                "message" => "操作失败，请删除该科目下所有章节后再删除本科目"
            );
        }
        else
        {
            $this->basic->delSubject($subjectid);
            $message = array(
                'statusCode' => 200,
                "message" => "操作成功",
                "callbackType" => "forward",
                "forwardUrl" => "reload"
            );
        }
        $this->G->R($message);
    }

    private function addsubject()
    {
        if($this->ev->get('insertsubject'))
        {
            $args = array('subject' => $this->ev->get('subject'),'subjectsetting' => $this->ev->get('setting'));
            $data = $this->basic->getSubjectByName($args['subject']);
            if($data)
            {
                $message = array(
                    'statusCode' => 300,
                    "message" => "操作失败，该科目已经存在"
                );
                $this->G->R($message);
            }
            $this->basic->addSubject($args);
            $message = array(
                'statusCode' => 200,
                "message" => "操作成功",
                "callbackType" => "forward",
                "forwardUrl" => "index.php?edu-app-edu-subject"
            );
            $this->G->R($message);
        }
        else
        {
            $subjects = $this->basic->getSubjectList();
            $questypes = $this->basic->getQuestypeList();
            $this->tpl->assign('questypes',$questypes);
            $this->tpl->assign('subjects',$subjects);
            $this->tpl->display('edu_addsubject');
        }
    }

    private function modifysubject()
    {
        if($this->ev->get('modifysubject'))
        {
            $args = $this->ev->get('args');
            $subjectid = $this->ev->get('subjectid');
            $this->basic->modifySubject($subjectid,$args);
            $message = array(
                'statusCode' => 200,
                "message" => "操作成功",
                "callbackType" => "forward",
                "forwardUrl" => "reload"
            );
            $this->G->R($message);
        }
        else
        {
            $subjectid = $this->ev->get('subjectid');
            $subject = $this->basic->getSubjectById($subjectid);
            $questypes = $this->basic->getQuestypeList();
            $this->tpl->assign('questypes',$questypes);
            $this->tpl->assign('subject',$subject);
            $this->tpl->display('edu_modifysubject');
        }
    }

    /*课程开通*/
    private function subject()
    {
        $search = $this->ev->get('search');
        if($search['NumberID']!=""||$search['planyear']!="") {
            $args = "select * from x2_plan left join x2_major on x2_major.majorcode=x2_plan.planmajor where 1=1 ";
            if ($search['planyear']) {
                $args = $args . "and x2_plan.planyear=" . $search['planyear'];
            }
            if ($search['NumberID']) {
                $args = $args . "  and x2_major.major=(select userreferrer from x2_user where NumberID=" . $search['NumberID'] . ")";
            }
            $con = mysqli_connect("127.0.0.1", "root", "DRsXT5ZJ6Oi55LPQ", "exam");
            if (mysqli_connect_errno($con)) {
                echo "连接 MySQL 失败: " . mysqli_connect_error();
            }
            // 执行查询
            $result = mysqli_query($con, $args);
            $rows = mysqli_fetch_all($result);
            mysqli_close($con);
            $plans["data"] = $rows;
            $this->tpl->assign('plans', $plans);
            $this->tpl->display('edu_subject');
        }else{
            $this->tpl->display('edu_subject');
        }

//        $database=new Medoo\Medoo([
//
//            'database_type' => 'mysql',
//
//            'database_name' => 'exam',
//
//            'server' => '127.0.0.1',
//
//            'username' => 'root',
//
//            'password' => 'DRsXT5ZJ6Oi55LPQ',
//
//            //可选
//
//            'port' => 3306,
//
//            'charset' => 'utf8',
//
//            // DB连接驱动选项，了解更多 http://www.php.net/manual/en/pdo.setattribute.php
//
//            'option' => [
//
//                PDO::ATTR_CASE => PDO::CASE_NATURAL
//
//            ]]);

//       $datas=$database->select("x2_plan",array("[>]x2_major"=>array("majorcode"=>"planmajor"),array("x2_plan.*,x2_major.*")));




    }



    private function deldetail()
    {
        $pdid = $this->ev->get('pdid');
        $this->edu->delPlanDetail($pdid);
        $message = array(
            'statusCode' => 200,
            "message" => "操作成功",
            "callbackType" => "forward",
            "forwardUrl" => "reload"
        );
        $this->G->R($message);
    }

    private function modifydetail()
    {
        $pdid = $this->ev->get('pdid');
        $detail = $this->edu->getPlanDetailById($pdid);
        if($this->ev->get('submit'))
        {
            $args = $this->ev->get('args');
            $this->edu->modifyPlanDetail($pdid,$args);
            $message = array(
                'statusCode' => 200,
                "message" => "操作成功",
                "callbackType" => "forward",
                "forwardUrl" => "reload"
            );
            $this->G->R($message);
        }
        else
        {
            $plan = $this->edu->getPlanById($detail['pdplanid']);
            $courses = $this->course->getAllCourses();
            $this->tpl->assign('detail',$detail);
            $this->tpl->assign('plan',$plan);
            $this->tpl->assign('courses',$courses);
            $this->tpl->display('edu_modifydetail');
        }
    }

    private function adddetail()
    {
        if($this->ev->get('submit'))
        {
            $args = $this->ev->get('args');
            $this->edu->addPlanDetail($args);
            $message = array(
                'statusCode' => 200,
                "message" => "操作成功",
                "callbackType" => "forward",
                "forwardUrl" => "index.php?edu-app-edu-detail&planid=".$args['pdplanid']
            );
            $this->G->R($message);
        }
        else
        {
            $planid = $this->ev->get('planid');
            $plan = $this->edu->getPlanById($planid);
            $courses = $this->course->getAllCourses();
            $this->tpl->assign('plan',$plan);
            $this->tpl->assign('courses',$courses);
            $this->tpl->display('edu_adddetail');
        }
    }

    private function copy()
    {
        $planid = $this->ev->get('planid');
        $plan = $this->edu->getPlanById($planid);
        $args = array();
        $args[] = array("AND","pdplanid = :pdplanid","pdplanid",$planid);
        $details = $this->edu->getPlanDetailList($args,1,500);
        $args = $plan;
        unset($args['planid']);
        $args['planyear'] = date('Y');
        $id = $this->edu->addPlan($args);
        foreach($details['data'] as $p)
        {
            $detail = array();
            $detail['pdgrade'] = $p['pdgrade'];
            $detail['pdcourse'] = $p['pdcourse'];
            $detail['pdplanid'] = $id;
            $this->edu->addPlanDetail($detail);
        }
        $message = array(
            'statusCode' => 200,
            "message" => "操作成功",
            "callbackType" => "forward",
            "forwardUrl" => "reload"
        );
        $this->G->R($message);
    }

    private function subjectdetail()
    {
        $page = $this->ev->get('page')?$this->ev->get('page'):1;
        $planid = $this->ev->get('planid');
        $plan = $this->edu->getPlanById($planid);
        $args = array();
        $args[] = array("AND","pdplanid = :pdplanid","pdplanid",$planid);
        $details = $this->edu->getPlanDetailList($args,$page);
        $courses = $this->course->getAllCourses();
        $this->tpl->assign('courses',$courses);
        $this->tpl->assign('plan',$plan);
        $this->tpl->assign('details',$details);
        $this->tpl->display('edu_subjectdetail');
    }

    private function detail()
    {
        $page = $this->ev->get('page')?$this->ev->get('page'):1;
        $planid = $this->ev->get('planid');
        $plan = $this->edu->getPlanById($planid);
        $args = array();
        $args[] = array("AND","pdplanid = :pdplanid","pdplanid",$planid);
        $details = $this->edu->getPlanDetailList($args,$page);
        $courses = $this->course->getAllCourses();
        $this->tpl->assign('courses',$courses);
        $this->tpl->assign('plan',$plan);
        $this->tpl->assign('details',$details);
        $this->tpl->display('edu_detail');
    }

    private function del()
    {
        $planid = $this->ev->get('planid');
        $this->edu->delPlan($planid);
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
        $planid = $this->ev->get('planid');
        $plan = $this->edu->getPlanById($planid);
        if($this->ev->get('submit'))
        {
            $args = $this->ev->get('args');
            $this->edu->modifyPlan($planid,$args);
            $message = array(
                'statusCode' => 200,
                "message" => "操作成功",
                "callbackType" => "forward",
                "forwardUrl" => "index.php?edu-app-edu"
            );
            $this->G->R($message);
        }
        else
        {
            $majors = $this->edu->getAllMajor();
            $this->tpl->assign('majors',$majors);
            $this->tpl->assign('plan',$plan);
            $this->tpl->display('edu_modify');
        }
    }

    private function add()
    {
        if($this->ev->get('submit'))
        {
            $args = $this->ev->get('args');
            $this->edu->addPlan($args);
            $message = array(
                'statusCode' => 200,
                "message" => "操作成功",
                "callbackType" => "forward",
                "forwardUrl" => "index.php?edu-app-edu"
            );
            $this->G->R($message);
        }
        else
        {
            $majors = $this->edu->getAllMajor();
            $this->tpl->assign('majors',$majors);
            $this->tpl->display('edu_add');
        }
    }

    private function index()
    {
        $page = $this->ev->get('page')?$this->ev->get('page'):1;
        $search = $this->ev->get('search');
        $args = array();
        //学年
        if($search['planyear'])
            $args[] = array("AND","planyear = :planyear","planyear",$search['planyear']);
        //专业代码
        if($search['planmajor'])
            $args[] = array("AND","planmajor like :planmajor","planmajor",'%'.$search['planmajor'].'%');
        //专业名称
        if($search['major'])
            $args[] = array("AND","major like :major","major",'%'."{$search['major']}".'%');
        /*   
        echo("<pre>") ;  
        var_dump($args);
        echo("</pre>") ;  
        */
        $plans = $this->edu->getPlanList($args,$page);
        $this->tpl->assign('plans',$plans);
        $this->tpl->display('edu_index');
    }


}


?>
