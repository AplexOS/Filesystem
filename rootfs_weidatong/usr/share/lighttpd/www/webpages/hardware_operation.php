<h2 id="hardware-operation">Hardware Operation</h2>

<script>
function gpio_on()
{
    var str="GPIO29_ON";
    if (window.XMLHttpRequest)
    {
        // IE7+, Firefox, Chrome, Opera, Safari 浏览器执行的代码
        xmlhttp=new XMLHttpRequest();
    }
    else
    {
        //IE6, IE5 浏览器执行的代码
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange=function()
    {
        if (xmlhttp.readyState==4 && xmlhttp.status==200)
        {
            document.getElementById("txtHint").innerHTML=xmlhttp.responseText;
        }
    }
    xmlhttp.open("GET","gpio_operation.php?q="+str, true);
    xmlhttp.send();
}

function gpio_off()
{
    var str="GPIO29_OFF";
    if (window.XMLHttpRequest)
    {
        // IE7+, Firefox, Chrome, Opera, Safari 浏览器执行的代码
        xmlhttp=new XMLHttpRequest();
    }
    else
    {
        //IE6, IE5 浏览器执行的代码
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange=function()
    {
        if (xmlhttp.readyState==4 && xmlhttp.status==200)
        {
            document.getElementById("txtHint").innerHTML=xmlhttp.responseText;
        }
    }
    xmlhttp.open("GET","gpio_operation.php?q="+str, true);
    xmlhttp.send();

}
</script>

<div>
  <style>
    td {
      text-align: center;
    }
  </style>
  <table width="100%" border="1" align="center" >
    <tr>
      <th scope="col">Index</th>
      <th scope="col">Name</th>
      <th scope="col">ON</th>
      <th scope="col">OFF</th>
    </tr>
<?php

foreach ($MiniOS->configs["hardware_operation"] as $key => $value) {
    echo "<tr>";
    echo "<th socpe='row'>".$value["index"]."</th>";
    echo "<td>".$key."</td>";
    echo "<td>";
    echo '<button onclick="gpio_on()">'.'gpio_on'.'</button>';
    echo "</td>";
    echo "<td>";
    echo '<button onclick="gpio_off()">'.'gpio_off'.'</button>';
    echo "</td>";
    echo "</tr>";
}

?>
  </table>
<div>
