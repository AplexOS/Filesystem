<h2 id="hardware-test">Hardware Test</h2>
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
      <th scope="col">Description</th>
      <th scope="col">Status</th>
    </tr>
<?php
    foreach ($MiniOS->configs["hardware_test"] as $key => $value) {
        echo "<tr>";
            echo "<th scope='row'>".$value["index"]."</th>";
            echo "<td>".$key."</td>";
            echo "<td>".$value["description"]."</td>";
            echo "<td>";
            $ret = exec($value["cmd"]);
            if ($ret != null)
                echo "<img src='img/ok.png' width='30' height='30' id='".$key."_status'/>";
            else
                echo "<img src='img/error.png' width='30' height='30' id='".$key."_status'/>";
            echo "</td>";
        echo "</tr>";
    }
?>
  </table>
<div>
