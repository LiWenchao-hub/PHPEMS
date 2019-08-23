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
        $this->basic = $this->G->make('basic','exam');
        $this->area = $this->G->make('area','exam');
        $this->section = $this->G->make('section','exam');
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
		if(!method_exists($this,$action))
		$action = "index";
		$this->$action();
		exit;
	}

    private function addquestype()
    {
        if($this->ev->get('insertquestype'))
        {
            $args = $this->ev->get('args');
            $this->basic->addQuestype($args);
            $message = array(
                'statusCode' => 200,
                "message" => "操作成功",
                "callbackType" => "forward",
                "forwardUrl" => "index.php?edu-app-exam-questype"
            );
            $this->G->R($message);
        }
        else
        {
            $this->tpl->display('exam_addquestype');
        }
    }

    private function modifyquestype()
    {
        if($this->ev->get('modifyquestype'))
        {
            $args = $this->ev->get('args');
            $page = $this->ev->get('page');
            $questid = $this->ev->get('questid');
            $this->basic->modifyQuestype($questid,$args);
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
            $questid = $this->ev->get('questid');
            $quest = $this->basic->getQuestypeById($questid);
            $this->tpl->assign('quest',$quest);
            $this->tpl->display('exam_modifyquestype');
        }
    }

    private function delquestype()
    {
        $questid = $this->ev->get('questid');
        $page = $this->ev->get('page');
        $this->basic->delQuestype($questid);
        $message = array(
            'statusCode' => 200,
            "message" => "操作成功",
            "callbackType" => "forward",
            "forwardUrl" => "reload"
        );
        $this->G->R($message);
    }

    private function questype()
    {
        $this->tpl->display('exam_questype');
    }

    private function delbasic()
    {
        $page = $this->ev->get('page');
        $basicid = $this->ev->get('basicid');
        $this->basic->delBasic($basicid);
        $message = array(
            'statusCode' => 200,
            "message" => "操作成功",
            "callbackType" => "forward",
            "forwardUrl" => "reload"
        );
        $this->G->R($message);
    }

    private function batdelbasic()
    {
        $page = $this->ev->get('page');
        $basicid = $this->ev->get('basicid');
        $this->basic->delBasic($basicid);
        $message = array(
            'statusCode' => 200,
            "message" => "操作成功",
            "callbackType" => "forward",
            "forwardUrl" => "reload"
        );
        $this->G->R($message);
    }

    private function closebasics()
    {
        $basicid = $this->ev->get('basicid');
        $userid = $this->ev->get('userid');
        $ob = $this->basic->getOpenBasicByUseridAndBasicid($userid,$basicid);
        $this->basic->delOpenBasic($ob['obid']);
        $message = array(
            'statusCode' => 200,
            "message" => "操作成功",
            "callbackType" => "forward",
            "forwardUrl" => "reload"
        );
        $this->G->R($message);
    }

    private function members()
    {
        $basicid = $this->ev->get('basicid');
        $search = $this->ev->get('search');
        $page = $this->ev->get('page');
        $args = array();
        $args[] = array("AND",'openbasics.obbasicid = :obbasicid','obbasicid',$basicid);
        $args[] = array("AND",'openbasics.obendtime >= :obendtime','obendtime',TIME);
        if($search['username'])
        {
            $args[] = array("AND",'user.username LIKE :username','username','%'.$search['username'].'%');
        }
        if($search['normal_favor'])$args[] = array('AND',"normal_favor = :normal_favor",'normal_favor',$search['normal_favor']);
        if($search['userreferrer'])$args[] = array('AND',"userreferrer = :userreferrer",'userreferrer',$search['userreferrer']);
        $members = $this->basic->getOpenBasicMember($args,$page);
        $basic = $this->basic->getBasicById($basicid);
        $this->tpl->assign('search',$search);
        $this->tpl->assign('basicid',$basicid);
        $this->tpl->assign('basic',$basic);
        $this->tpl->assign('members',$members);
        $this->tpl->assign('page',$page);
        $this->tpl->display('exam_members');
    }

    private function selectexams()
    {
        $search = $this->ev->get('search');
        $useframe = $this->ev->get('useframe');
        $target = $this->ev->get('target');
        $page = $this->ev->get('page');
        $page = $page > 0?$page:1;
        $this->pg->setUrlTarget('modal-body" class="ajax');
        $args = array();
        if($search)
        {
            if($search['subjectid'])$args[] = array("AND","examsubject = :examsubject",'examsubject',$search['subjectid']);
        }
        if(!count($args))$args = 1;
        $exams = $this->exam->getExamSettingList($page,10,$args);
        $subjects = $this->basic->getSubjectList();
        $this->tpl->assign('subjects',$subjects);
        $this->tpl->assign('target',$target);
        $this->tpl->assign('exams',$exams);
        $this->tpl->display('exams_ajax');
    }

    private function selectgroups()
    {
        $useframe = $this->ev->get('useframe');
        $target = $this->ev->get('target');
        $page = $this->ev->get('page');
        $page = $page > 0?$page:1;
        $this->pg->setUrlTarget('modal-body" class="ajax');
        $args = 1;
        $actors = $this->user->getUserGroupList($args,10,$page);
        $this->tpl->assign('page',$page);
        $this->tpl->assign('target',$target);
        $this->tpl->assign('actors',$actors);
        $this->tpl->display('exam_allowgroups');
    }

    private function getsubjectquestype()
    {
        $subjectid = $this->ev->get('subjectid');
        $subject = $this->basic->getSubjectById($subjectid);
        $r = array();
        if($subject['subjectsetting']['questypes'])
        {
            foreach($subject['subjectsetting']['questypes'] as $key => $p)
            {
                if($p)$r[] = $key;
            }
        }
        exit(json_encode($r));
    }

    private function getbasicmembernumber()
    {
        $basicid = $this->ev->get('basicid');
        $number = $this->basic->getOpenBasicNumber($basicid);
        echo $number;
    }

    private function setexamrange()
    {
        $page = $this->ev->get('page');
        $basicid = $this->ev->get('basicid');
        if($this->ev->get('setexamrange'))
        {
            $args = $this->ev->get('args');
            $args['basicsection'] = array();
            if(is_array($args['basicknows']))
                foreach($args['basicknows'] as $key => $p)
                {
                    $args['basicsection'][] = $key;
                }
            $args['basicexam']['opentime']['start'] = strtotime($args['basicexam']['opentime']['start']);
            $args['basicexam']['opentime']['end'] = strtotime($args['basicexam']['opentime']['end']);
            $args['basicsection'] = $args['basicsection'];
            $args['basicknows'] = $args['basicknows'];
            $args['basicexam'] = $args['basicexam'];
            $this->basic->setBasicConfig($basicid,$args);
            $message = array(
                'statusCode' => 200,
                "message" => "操作成功",
                "callbackType" => "forward",
                "forwardUrl" => "index.php?edu-app-exam-basic&page={$page}{$u}"
            );
            $this->G->R($message);
        }
        else
        {
            $basic = $this->basic->getBasicById($basicid);
            $subjects = $this->basic->getSubjectList();
            $areas = $this->area->getAreaList();
            $tmpknows = $this->section->getAllKnowsBySubject($basic['basicsubjectid']);
            $knows = array();
            $sections = $this->section->getSectionListByArgs(array(array("AND","sectionsubjectid = :sectionsubjectid",'sectionsubjectid',$basic['basicsubjectid'])));
            foreach($tmpknows as $p)
            {
                $knows[$p['knowssectionid']][] = $p;
            }
            $tpls = array();
            foreach(glob("app/exam/tpls/app/exampaper_paper*.tpl") as $p)
            {
                $tpls['ep'][] = substr(basename($p),0,-4);
            }
            foreach(glob("app/exam/tpls/app/exam_paper*.tpl") as $p)
            {
                $tpls['pp'][] = substr(basename($p),0,-4);
            }
            $this->tpl->assign('tpls',$tpls);
            $this->tpl->assign('basic',$basic);
            $this->tpl->assign('areas',$areas);
            $this->tpl->assign('sections',$sections);
            $this->tpl->assign('knows',$knows);
            $this->tpl->assign('subjects',$subjects);
            $this->tpl->display('exam_examrange');
        }
    }

    private function modifybasic()
    {
        $page = $this->ev->get('page');
        if($this->ev->get('modifybasic'))
        {
            $basicid = $this->ev->get('basicid');
            $args = $this->ev->get('args');
            $this->basic->setBasicConfig($basicid,$args);
            $message = array(
                'statusCode' => 200,
                "message" => "操作成功",
                "callbackType" => "forward",
                "forwardUrl" => "index.php?edu-app-exam&page={$page}"
            );
            $this->G->R($message);
        }
        else
        {
            $basicid = $this->ev->get('basicid');
            $basic = $this->basic->getBasicById($basicid);
            $subjects = $this->basic->getSubjectList();
            $areas = $this->area->getAreaList();
            $this->tpl->assign('areas',$areas);
            $this->tpl->assign('subjects',$subjects);
            $this->tpl->assign('basic',$basic);
            $this->tpl->display('exam_modifybasic');
        }
    }

    private function addbasic()
    {
        if($this->ev->get('insertbasic'))
        {
            $args = $this->ev->get('args');
            $page = $this->ev->get('page');
            $id = $this->basic->addBasic($args);
            $message = array(
                'statusCode' => 200,
                "message" => "操作成功",
                "callbackType" => "forward",
                "forwardUrl" => "index.php?edu-app-exam"
            );
            $this->G->R($message);
        }
        else
        {
            $subjects = $this->basic->getSubjectList();
            $areas = $this->area->getAreaList();
            $this->tpl->assign('areas',$areas);
            $this->tpl->assign('subjects',$subjects);
            $this->tpl->display('exam_addbasic');
        }
    }

    private function preview()
    {
        $examid = $this->ev->get('examid');
        $r = $this->exam->getExamSettingById($examid);
        $this->tpl->assign("setting",$r);
        if($r['examtype'] == 2)
        {
            $questions = array();
            $questionrows = array();
            foreach($r['examquestions'] as $key => $p)
            {
                $qids = '';
                $qrids = '';
                if($p['questions'])$qids = trim($p['questions']," ,");
                if($qids)
                    $questions[$key] = $this->exam->getQuestionListByIds($qids);
                if($p['rowsquestions'])$qrids = trim($p['rowsquestions']," ,");
                if($qrids)
                {
                    $qrids = explode(",",$qrids);
                    foreach($qrids as $t)
                    {
                        $qr = $this->exam->getQuestionRowsById($t);
                        if($qr)
                            $questionrows[$key][$t] = $qr;
                    }
                }
            }
            $args['examsessionquestion'] = array('questions'=>$questions,'questionrows'=>$questionrows);
            $args['examsessionsetting'] = $r;
            $args['examsessionstarttime'] = TIME;
            $args['examsession'] = $r['exam'];
            $args['examsessionscore'] = 0;
            $args['examsessiontime'] = $r['examsetting']['examtime'];
            $args['examsessiontype'] = 2;
            $args['examsessionkey'] = $r['examid'];
            $args['examsessionissave'] = 0;
        }
        else
        {
            $args['examsessionquestion'] = array('questions'=>$r['examquestions']['questions'],'questionrows'=>$r['examquestions']['questionrows']);
            $args['examsessionsetting'] = $r;
            $args['examsessionstarttime'] = TIME;
            $args['examsession'] = $r['exam'];
            $args['examsessiontime'] = $r['examsetting']['examtime'];
            $args['examsessiontype'] = 2;
            $args['examsessionkey'] = $r['examid'];
        }
        $questype = $this->basic->getQuestypeList();
        $this->tpl->assign('questype',$questype);
        $this->tpl->assign("sessionvars",$args);
        $this->tpl->display('exam_paper');
    }

    private function index()
    {
        $page = $this->ev->get('page');
        $search = $this->ev->get('search');
        $page = $page > 1?$page:1;
        $subjects = $this->basic->getSubjectList();
        $areas = $this->area->getAreaList();
        $user = $this->user->getUserById($this->_user['sessionuserid']);
        $area = '0';
        foreach($areas as $p)
        {
            if($p['area'] == $user['usersequence'])
            {
                $area = $p['areacode'];
                break;
            }
        }
        $args = array();
        $args[] = array("AND","basicareaid = :cbasicareaid",'cbasicareaid',$area);
        if($search['basicid'])$args[] = array("AND","basicid = :basicid",'basicid',$search['basicid']);
        else
        {
            if($search['keyword'])$args[] = array("AND","basic LIKE :basic",'basic',"%{$search['keyword']}%");
            if($search['basicareaid'])$args[] = array("AND","basicareaid = :basicareaid",'basicareaid',$search['basicareaid']);
            if($search['basicsubjectid'])$args[] = array("AND","basicsubjectid = :basicsubjectid",'basicsubjectid',$search['basicsubjectid']);
            if($search['basicapi'])$args[] = array("AND","basicapi = :basicapi",'basicapi',$search['basicapi']);
            if($search['basicclosed'])
            {
                if($search['basicclosed'] == 1)$basicclosed = 1;
                else
                    $basicclosed = 0;
                $args[] = array("AND","basicclosed = :basicclosed",'basicclosed',$basicclosed);
            }
        }
        $basics = $this->basic->getBasicList($page,100,$args);

        $this->tpl->assign('areas',$areas);
        $this->tpl->assign('subjects',$subjects);
        $this->tpl->assign('basics',$basics);
        $this->tpl->display('exam_index');
    }
}


?>
