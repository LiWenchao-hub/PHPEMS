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
		$action = $this->ev->url(3);
        $this->edu = $this->G->make('edu','edu');
		$this->progress = $this->G->make('progress','user');
        $this->basic = $this->G->make('basic','exam');
        $this->course = $this->G->make('course','course');
		if(!method_exists($this,$action))
		$action = "index";
		$this->$action();

		exit;
	}

    private function index()
    {
        $page = $this->ev->get('page');
        $user = $this->user->getUserById($this->_user['sessionuserid']);
        $args = array();
        $args[] = array("AND","planyear = :planyear","planyear",$user['normal_favor']);
        $args[] = array("AND","major = :planmajor","planmajor",$user['userreferrer']);
        $plan = $this->edu->getPlanByArgs($args);
        $args = array();
        $args[] = array("AND","pdplanid = :pdplanid","pdplanid",$plan['planid']);
        $details = $this->edu->getPlanDetailList($args,$page);
        $courses = $this->course->getAllCourses();
        $this->tpl->assign('user',$user);
        $this->tpl->assign('courses',$courses);
        $this->tpl->assign('details',$details);
        $this->tpl->assign('page',$page);
        $this->tpl->display('center-plane');
    }
}


?>
