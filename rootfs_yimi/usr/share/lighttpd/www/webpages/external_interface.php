<h2 id="external-interface">External Interface</h2>
<div>
  <style>
    td {
      text-align: center;
    }
  </style>
  <table width="100%" border="1" align="center" >
    <tr>
      <th scope="col">Index</th>
      <th scope="col">External Interface</th>
      <th scope="col">Description</th>
    </tr>
<?php
    foreach ($MiniOS->configs["external_interface"] as $key => $value) {
        echo "<tr>";
            echo "<th scope='row'>".$value["index"]."</th>";
            echo "<td>".$key."</td>";
            echo "<td>".$value["description"]."</td>";
        echo "</tr>";
    }
?>
  </table>
<div>
