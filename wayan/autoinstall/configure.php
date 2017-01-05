<?php
include_once('/root/webuzo_sdk.php');
$file = fopen("/root/hostname.txt","r");
$data = array();
while(! feof($file)){
  array_push($data, trim(fgets($file)));
}
fclose($file);
// var_dump($_GET);exit;
$ip = $data[0];
#$user = generate(); //$data[1];
$user = $data[1];
$email = $data[2];
#$pass = generate(null); //$data[3];
$pass = $data[3];
$host = $data[4];
$ns1 = $data[5];
$ns2 = $data[6];

//buat objek
//$object = new Webuzo_API($webuzo_user, $webuzo_password, $host);
$object = new Webuzo_API();
//eksekusi configure
$execute = $object->webuzo_configure($ip, $user, $email, $pass, $host, $ns1, $ns2, $license = "" );

/* var_dump($execute); exit;
function generate($prefix = 'u') {
	$num = rand(1000,9999);
	return (!empty($prefix))? $prefix.$num : $num.'Z';
} */
?>

