<?php

$q=$_GET["q"];

function gpio29_on()
{
    $cmd1 = "echo 29 > /sys/class/gpio/export";
    $cmd2 = "echo out > /sys/class/gpio/gpio29/direction";
    $cmd3 = "echo 1 > /sys/class/gpio/gpio29/value ";

    exec($cmd1);
    exec($cmd2);
    exec($cmd3);
}

function gpio29_off()
{
    $cmd1 = "echo 0 > /sys/class/gpio/gpio29/value ";
    $cmd2 = "echo 29 > /sys/class/gpio/unexport";

    exec($cmd1);
    exec($cmd2);
}

if ($q == "GPIO29_ON")
{
    gpio29_on();
}
else if ($q == "GPIO29_OFF")
{
    gpio29_off();
}

?>
