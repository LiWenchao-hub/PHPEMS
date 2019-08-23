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

    private function delmajor()
    {
        $majorid = $this->ev->get('majorid');
        $this->edu->delMajor($majorid);
        $message = array(
            'statusCode' => 200,
            "message" => "操作成功",
            "callbackType" => "forward",
            "forwardUrl" => "index.php?edu-app-setting-major"
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
                "forwardUrl" => "index.php?edu-app-setting-major"
            );
            $this->G->R($message);
        }
        else
        $this->tpl->display('setting_addmajor');
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
        $this->tpl->display('setting_major');
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
                "forwardUrl" => "index.php?edu-app-setting-subject"
            );
            $this->G->R($message);
        }
        else
        {
            $subjects = $this->basic->getSubjectList();
            $questypes = $this->basic->getQuestypeList();
            $this->tpl->assign('questypes',$questypes);
            $this->tpl->assign('subjects',$subjects);
            $this->tpl->display('setting_addsubject');
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
            $this->tpl->display('setting_modifysubject');
        }
    }

    private function teachers()
    {
        $subjectid = $this->ev->get('subjectid');
        $args = array();
        $args[] = array("AND","usergroupid = 9");
        $teachers = $this->user->getUsersByArgs($args);
        foreach($teachers as $key => $teacher)
        {
            $teacher['teacher_subjects'] = unserialize($teacher['teacher_subjects']);
            if(!in_array($subjectid,$teacher['teacher_subjects']))
            {
                unset($teachers[$key]);
            }
        }
        $this->tpl->assign('subjectid',$subjectid);
        $this->tpl->assign('teachers',$teachers);
        $this->tpl->display('setting_teachers');
    }

    private function index()
    {
        $this->tpl->display('setting_index');
    }

}


?>
