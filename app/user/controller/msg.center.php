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
        $this->edu = $this->G->make('edu','edu');
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
		$this->tpl->assign('search',$search);
		if(!method_exists($this,$action))
		$action = "index";
		$this->$action();
		exit;
	}

    private function detail()
    {
        $msgid = $this->ev->get('msgid');
        $msg = $this->edu->getMsgById($msgid);
        $this->tpl->assign('msg',$msg);
        $this->tpl->display('msg_detail');
    }

	private function index()
	{
		$page = $this->ev->get('page')?$this->ev->get('page'):1;
		$user = $this->user->getUserById($this->_user['sessionuserid']);
		$msgs = $this->edu->getMyMsgList($user,$page);
		$this->tpl->assign('msgs',$msgs);
		$this->tpl->assign('page',$page);
		$this->tpl->display('msg');
	}

}


?>
