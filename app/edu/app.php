<?php

class app
{
	public $G;
	public $data = array();
	public $sessionvars;

	public function __construct(&$G)
	{
		$this->G = $G;
		$this->ev = $this->G->make('ev');
		$this->tpl = $this->G->make('tpl');
		$this->sql = $this->G->make('sql');
		$this->pdosql = $this->G->make('pdosql');
		$this->db = $this->G->make('pepdo');
		$this->pg = $this->G->make('pg');
		$this->html = $this->G->make('html');
		$this->session = $this->G->make('session');
		$this->_user = $this->session->getSessionUser();
		if(!$this->_user['sessionuserid'])
		{
			if($this->ev->get('userhash'))
			exit(json_encode(array(
				'statusCode' => 301,
				"message" => "请您重新登录",
			    "callbackType" => 'forward',
			    "forwardUrl" => "index.php?user-app-login"
			)));
			else
			{
				header("location:index.php?user-app-login");
				exit;
			}
		}

		$this->user = $this->G->make('user','user');
		$user = $this->user->getUserById($this->_user['sessionuserid']);
        if($user['groupmoduleid'] != 24)
        {
            $message = array(
                'statusCode' => 301,
                "message" => "您无权管理教务中心",
                "callbackType" => 'forward',
                "forwardUrl" => "index.php?user-app-login"
            );
            $this->G->R($message);
        }
		$this->exam = $this->G->make('exam','exam');
		$this->basic = $this->G->make('basic','exam');
		$this->questypes = $this->basic->getQuestypeList();
		$this->subjects = $this->basic->getSubjectList();
		$this->tpl->assign('questypes',$this->questypes);
		$this->tpl->assign('subjects',$this->subjects);
		$this->tpl->assign('_user',$user);
		$this->tpl->assign('userhash',$this->ev->get('userhash'));
	}
}

?>