<h2 id="LED_test">LED test</h2>
<head>

<script>
function showHint(str)
{
    if (str.length==0)
    {
        return;
    }
    if (window.XMLHttpRequest)
    {
        xmlhttp=new XMLHttpRequest();
    }
    else
    {
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange=function()
    {
        if (xmlhttp.readyState==4 && xmlhttp.status==200)
        {
            //document.getElementById("txtHint").innerHTML=xmlhttp.responseText;
            console.log(xmlhttp.responseText);
        }
    }
    xmlhttp.open("GET","gethint.php?q="+str,true);
    xmlhttp.send();
}
</script>

</head>
<div>
  <style>
    td {
      text-align: center;
    }
  </style>
  <table width="100%" border="1" align="center" >
    <tr>
      <th scope="col">Modules</th>
      <th scope="col">Command</th>
    </tr>
    <tr>
      <th scope="col">LED</th>
      <td>
        <button onclick="showHint('date')"> test_led </button>
      </td>
    </tr>
  </table>
<div>
