<?php

class edu_edu
{
	public $G;

	public function __construct(&$G)
	{
		$this->G = $G;
	}

	public function _init()
	{
		$this->pdosql = $this->G->make('pdosql');
		$this->db = $this->G->make('pepdo');
		$this->ev = $this->G->make('ev');
	}

	//根据应用名获取应用信息
	public function getMajorByCode($majorcode)
	{
		$data = array(false,'major',array(array("AND","majorcode = :majorcode","majorcode",$majorcode)));
		$sql = $this->pdosql->makeSelect($data);
		return $this->db->fetch($sql);
	}

    public function getMajorByName($major)
    {
        $data = array(false,'major',array(array("AND","major = :major","major",$major)));
        $sql = $this->pdosql->makeSelect($data);

        return $this->db->fetch($sql);
    }

    public function getMajorById($majorid)
    {
        $data = array(false,'major',array(array("AND","majorid = :majorid","majorid",$majorid)));
        $sql = $this->pdosql->makeSelect($data);
        return $this->db->fetch($sql);
    }

    public function getAllMajor()
    {
        $data = array(false,'major',array(),false,false,false);
        $sql = $this->pdosql->makeSelect($data);
        return $this->db->fetchAll($sql,'majorcode');
    }

    public function addMajor($args)
    {
        $data = array('major',$args);
        $sql = $this->pdosql->makeInsert($data);
        return $this->db->exec($sql);
    }

	//修改应用信息
	public function delMajor($majorid)
	{
		$data = array('major',array(array("AND","majorid = :majorid","majorid",$majorid)));
		$sql = $this->pdosql->makeDelete($data);
		return $this->db->exec($sql);
	}

	//获取本地应用列表
	public function getMajorList($args,$page,$number = 30,$order = "majorid desc")
    {
        $data = array(
            'select' => false,
            'table' => 'major',
            'query' => $args,
            'orderby' => $order
        );
        return $this->db->listElements($page,$number,$data);
	}

    public function getPlanById($planid)
    {
        $data = array(false,array('major','plan'),array(array("AND","planmajor = majorcode"),array("AND","planid = :planid","planid",$planid)));
        $sql = $this->pdosql->makeSelect($data);
        return $this->db->fetch($sql);
    }

    //得到年级,由于前台页面html追加规则限制，此处从小到大排列
    public function getGrade(){
        $data = array('DISTINCT(planyear)',array('major','plan'),array(array("AND","planmajor = majorcode"),array("ORDER BY","planyear ASC")));
        $sql = $this->pdosql->makeSelect($data);
        return $this->db->fetchAll($sql);
    }

    //通过年级得到专业
    public function getMajor($grade){
        $data = array('major',array('major','plan'),array(array("AND","planmajor = majorcode"),array("and","planyear=:planyear","planyear",$grade),array("ORDER BY","convert(major using gbk) DESC")));
        $sql = $this->pdosql->makeSelect($data);
        return $this->db->fetchAll($sql);
    }

    public function getPlanByArgs($args)
    {
        $args[] = array("AND","planmajor = majorcode");
        $data = array(false,array('major','plan'),$args);
        $sql = $this->pdosql->makeSelect($data);
        //var_dump($sql);
        return $this->db->fetch($sql);
    }

    public function getPlansByArgs($args)
    {
        $args[] = array("AND","planmajor = majorcode");
        $data = array(false,array('major','plan'),$args,false,false,false);
        $sql = $this->pdosql->makeSelect($data);
        //var_dump($sql);
        return $this->db->fetchAll($sql);
    }

    public function addPlan($args)
    {
        $data = array('plan',$args);
        $sql = $this->pdosql->makeInsert($data);
        $this->db->exec($sql);
        return $this->db->lastInsertId();
    }

    public function modifyPlan($planid,$args)
    {
        $data = array(
            'table' => 'plan',
            'value' => $args,
            'query' => array(array("AND","planid = :planid","planid",$planid))
        );
        return $this->db->updateElement($data);
    }

    //修改应用信息
    public function delPlan($planid)
    {
        $data = array('plan',array(array("AND","planid = :planid","planid",$planid)));
        $sql = $this->pdosql->makeDelete($data);
        return $this->db->exec($sql);
    }

    //获取本地应用列表
    public function getPlanList($args,$page,$number = 30,$order = "planid desc")
    {
        $args[] = array("AND","planmajor = majorcode");
        $data = array(
            'select' => false,
            'table' => array('major','plan'),
            'query' => $args,
            'orderby' => $order
        );
        return $this->db->listElements($page,$number,$data);
    }

    public function getPlanDetailById($pdid)
    {
        $data = array(false,'plandetail',array(array("AND","pdid = :pdid","pdid",$pdid)));
        $sql = $this->pdosql->makeSelect($data);
        return $this->db->fetch($sql,'pdcourse');
    }

    public function addPlanDetail($args)
    {
        $data = array('plandetail',$args);
        $sql = $this->pdosql->makeInsert($data);
        return $this->db->exec($sql);
    }

    public function modifyPlanDetail($pdid,$args)
    {
        $data = array(
            'table' => 'plandetail',
            'value' => $args,
            'query' => array(array("AND","pdid = :pdid","pdid",$pdid))
        );
        return $this->db->updateElement($data);
    }

    //修改应用信息
    public function delPlanDetail($pdid)
    {
        $data = array('plandetail',array(array("AND","pdid = :pdid","pdid",$pdid)));
        $sql = $this->pdosql->makeDelete($data);
        return $this->db->exec($sql);
    }

    //获取本地应用列表
    public function getPlanDetailList($args,$page,$number = 20,$order = "field(pdgrade,'第一学期','第二学期','第三学期','第四学期','第五学期','第六学期','第七学期','第八学期')")
    {
        $data = array(
            'select' => false,
            'table' => 'plandetail',
            'query' => $args,
            'orderby' => $order,
            'serial' => 'pdcourse'
        );
        return $this->db->listElements($page,$number,$data);
    }

    public function getMsgById($msgid)
    {
        $data = array(false,'msg',array(array("AND","msgid = :msgid","msgid",$msgid)));
        $sql = $this->pdosql->makeSelect($data);
        return $this->db->fetch($sql);
    }

    public function addMsg($args)
    {
        $data = array('msg',$args);
        $sql = $this->pdosql->makeInsert($data);
        return $this->db->exec($sql);
    }

    public function modifyMsg($msgid,$args)
    {
        $data = array(
            'table' => 'msg',
            'value' => $args,
            'query' => array(array("AND","msgid = :msgid","msgid",$msgid))
        );
        return $this->db->updateElement($data);
    }

    //修改应用信息
    public function delMsg($msgid)
    {
        $data = array('msg',array(array("AND","msgid = :msgid","msgid",$msgid)));
        $sql = $this->pdosql->makeDelete($data);
        return $this->db->exec($sql);
    }

    //获取本地应用列表
    public function getMsgList($args,$page,$number = 20,$order = "msgid desc")
    {
        $data = array(
            'select' => false,
            'table' => 'msg',
            'query' => $args,
            'orderby' => $order
        );
        return $this->db->listElements($page,$number,$data);
    }

    public function getMyMsgList($user,$page,$number = 20,$order = "msgid desc")
    {
        $args = array();
        $args[] = array("AND","(msggroups = 0 AND msgusers = 0)");
        $args[] = array("OR","(find_in_set(:NumberID,msgusers))","NumberID",$user['NumberID']);
        $args[] = array("OR","(find_in_set(:major,msggroups))","major","{$user['normal_favor']}-{$user['userreferrer']}");
        $data = array(
            'select' => false,
            'table' => 'msg',
            'query' => $args,
            'orderby' => $order
        );
        return $this->db->listElements($page,$number,$data);
    }
}

?>