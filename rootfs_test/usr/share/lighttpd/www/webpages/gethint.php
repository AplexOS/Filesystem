<?php

$q=$_GET["q"];

exec("./test_allled.sh", $output);

echo $q;

?>
