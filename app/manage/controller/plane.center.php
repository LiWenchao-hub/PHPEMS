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
       // die("9999");
        $page = $this->ev->get('page');
        $contents = $this->course->getOpenCourseListByUserid($this->_user['sessionuserid'],$page);
        $this->tpl->assign('contents',$contents);
        $this->tpl->assign('page',$page);
        $this->tpl->display('center-plane');
    }
}


?>
