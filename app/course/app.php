<?php

class app
{
    public $G;

    public function __construct(&$G)
    {
        $this->G = $G;
        $this->ev = $this->G->make('ev');
        $this->tpl = $this->G->make('tpl');
        $this->sql = $this->G->make('sql');
        $this->pdosql = $this->G->make('pdosql');

        $this->db = $this->G->make('pdodb');
        $this->pg = $this->G->make('pg');
        $this->html = $this->G->make('html');
        $this->files = $this->G->make('files');
        $this->session = $this->G->make('session');
        $this->category = $this->G->make('category');
        $this->course = $this->G->make('course','course');
        $this->content = $this->G->make('content','course');
        $this->user = $this->G->make('user','user');
        $this->_user = $_user = $this->session->getSessionUser();
         if(!$this->_user['sessionuserid'] )
        {
            if($this->ev->get('userhash'))
                exit(json_encode(array(
                    'statusCode' => 301,
                    "message" => "请您重新登陆",
                    "callbackType" => 'forward',
                    "forwardUrl" => "index.php?user-app-login"
                )));
            else
            {
                //echo "111";
                header("location:index.php?user-app-login");
                exit;
            }
        }
        
        $this->tpl->assign('_user',$this->user->getUserById($this->_user['sessionuserid']));
        $this->rcats = $rcats = $this->category->getCategoriesByArgs("catparent  = '0'");
        $this->tpl->assign('rcats',$rcats);
        $this->tpl->assign('userhash',$this->ev->get('userhash'));
        $this->log = $this->G->make('log','course');
    }
}

?>