<?php

/*
class  action extends app
{
    public function display()
    {
        $action = $this->ev->url(3);
        if(!method_exists($this,$action))
            $action = "index";
        $this->$action();
        exit;
    }

    private function index()
    {
        header("location:index.php?user-app-login");
    }

}
*/

class action extends app
{
    public function display()
    {
        $action = $this->ev->url(1);
        $this->favor = $this->G->make('favor','exam');
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
        $args = array();
        $args[] = array("AND","ehuserid = :ehuserid",'ehuserid',$this->_user['sessionuserid']);
        $args[] = array("AND","ehtype = 2");
        $histories = $this->favor->getExamHistoryListByArgs($page,30,$args);
        $this->tpl->assign('exams',$histories);
        $this->tpl->display('search');
    }
}



?>
