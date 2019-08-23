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
		if(!method_exists($this,$action))
		$action = "index";
		$this->$action();
		exit;
	}

	private function getActorsByModule()
	{
		$moduleid = $this->ev->get('moduleid');
		$actors = $this->user->getGroupsByModuleid($moduleid);
		foreach($actors as $actor)
		{
			echo '<option value="'.$actor['groupid'].'">'.$actor['groupname'].'</option>';
		}
	}

	private function getMajorByYear()
	{
		$year = $this->ev->get('year');
        $args = array();
        $args[] = array("AND","planyear = :planyear","planyear",$year);
        $plans = $this->edu->getPlansByArgs($args);
        echo "<option value=\"0\">不限</option>";
        foreach($plans as $plan)
        {
            echo "<option value=\"{$plan['major']}\">{$plan['major']}</option>";
        }
	}

    private function getSubjectByMajor()
    {
        $this->course = $this->G->make('course','course');
    	$year = $this->ev->get('year');
        $major = $this->ev->get('major');
        $args = array();
        $args[] = array("AND","planyear = :planyear","planyear",$year);
        $args[] = array("AND","major = :major","major",$major);
        $plan = $this->edu->getPlanByArgs($args);
        $args = array();
        $args[] = array("AND","pdplanid = :pdplanid","pdplanid",$plan['planid']);
        $details = $this->edu->getPlanDetailList($args,1,100);
        $courses = $this->course->getAllCourses();
        $subjects = array();
        foreach($details['data'] as $detail)
		{
			foreach($detail['pdcourse'] as $cs)
			{
				if(!$subjects[$courses[$cs]['cssubjectid']])
				{
                    $subjects[$courses[$cs]['cssubjectid']] = $this->subjects[$courses[$cs]['cssubjectid']];
				}
			}
		}
        echo "<option value=\"0\">不限</option>";
		foreach($subjects as $subject)
		{
            echo "<option value=\"{$subject['subjectid']}\">{$subject['subject']}</option>";
		}
    }

	private function index()
	{
		//
	}
}


?>
