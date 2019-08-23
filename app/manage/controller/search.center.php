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
        //die(var_dump($action));
        $this->search = $this->G->make('search','exam');

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
        $args = array(array("AND","prsuserid = :prsuserid",'prsuserid',$this->_user['sessionuserid']));
        //$search = $this->search->getUserProgressesListByArgs($args,$page);
        $courses = array();
        $basics = array();
        foreach($search['data'] as $p)
        {
            if(!$courses[$p['prscourseid']])
                $courses[$p['prscourseid']] = $this->course->getCourseById($p['prscourseid']);
            if(!$basics[$p['prsexamid']])
                $basics[$p['prsexamid']] = $this->basic->getBasicById($p['prsexamid']);
        }
        $this->tpl->assign('status',array('未完成','已完成'));
        $this->tpl->assign('basics',$basics);
        $this->tpl->assign('courses',$courses);
        $this->tpl->assign('search',$search);
        $this->tpl->display('search');
    }
}



?>
