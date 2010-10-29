<?php

$file = "http://okcis.intocareers.org/occ/occ140010.xml";  


$fp = fopen($file, "r"); 
$topics = array("Overview", "Common Tasks", "Things to Know",
"Work Activities",
"Working Conditions",
"Physical Demands",
"Skills and Abilities",
"WorkKeys",
"Knowledge",
"Preparation",
"Helpful high school courses",
"Hiring Practices",
"Licensing / Certification",
"Wages",
"Outlook",
"Interests",
"Advancement Opportunities",
"Bibliography");



while (!feof($fp)) {
$data = fgets($fp);
if(preg_match( '/Topic Sequence/' , $data)){
$meaningfulData = fgets($fp);

//preg_match_all('/\>*\</', $meaningfulData, $matches);
$meaningfulData = substr($meaningfulData, 7, -10);
$data = substr($data, 17, 2);
if($data < 10){
	$data = substr($data, 0, 1);
}

//echo $data."\n";

if(in_array($meaningfulData, $topics)){
	echo "The Occupation is " . $meaningfulData . ", the topic is " . $data . "\n";
}
//echo $matches;
//echo "\n";
	

}
}

fclose($fp); 

?>
