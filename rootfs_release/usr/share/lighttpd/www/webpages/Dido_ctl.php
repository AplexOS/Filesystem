<h2 id="DIDO-operation">DIDO Operation</h2>

<script type="text/javascript">

var DO_num = 0;
var DI_num = 0;
var ws;

// websocket init
function init() {
    // Connect to Web Socket
    var ip_addr = document.location.hostname;
    window.WebSocket = window.WebSocket || window.MozWebSocket;
    ws = new WebSocket('ws://' + ip_addr +':9001');

    // Set event handlers.
    ws.onopen = function() {
    };

    ws.onmessage = function(e) {
        DI_num = parseInt(e.data);  // Get server DI_num;
        if (((DI_num >> 7) >> 8) == 1)
        {
            var gpio_in = DI_num & 0xff;
            //window.alert(gpio_in);
            for (var i = 0; i < 8; i++)
            {
                var DI_id = "DI_"+ i.toString();
                if ((gpio_in >> i) & 1)
                {
                    document.getElementById(DI_id).innerHTML = "HIGH";
                }
                else
                {
                    document.getElementById(DI_id).innerHTML = "LOW";
                }
            }
        }
        else if (((DI_num >> 7) >> 8) == 2)
        {
            DO_num = DI_num;
        }
    };

    ws.onclose = function() {
    };

    ws.onerror = function(e) {
        console.log(e)
    };
}


function gpio_value(direction, gpio_num, read_write, can_id) {
    if (direction)
    {
        DO_num |= (direction << gpio_num);
    }
    else
    {
        var num = 0xff & ~(!direction << gpio_num);
        DO_num &= num;
    }
    DO_num &= ~(0x3 << 15); // clean read or write bit
    DO_num |= ((read_write << 7) << 8) | (can_id << 8);  //merge

    return DO_num;
}

function gpio_output_high(gpio_num) {
    var num = gpio_value(1, gpio_num, 2, 11);
    ws.send(num);
}

function gpio_output_low(gpio_num) {
    var num = gpio_value(0, gpio_num, 2, 11);
    ws.send(num);
}

function get_di_state(){
    var num = gpio_value(0, 0, 1, 11);
    ws.send(num);
}

function onCloseClick() {
    ws.close();
}

init();
</script>

<div onload="init();">
    <style>
    td {
        text-align: center;
    }
    </style>

    <h3>    DI</h3>
    <table width="100%" border="1" align="center" >
    <tr>
        <th scope="col">Index</th>
        <th scope="col">Name</th>
        <th scope="col"><button onclick='get_di_state()'>STATE</button></th>
    </tr>

<?php
for ($i = 0; $i < 8; $i++) {
    echo "<tr>";
    echo "<th socpe='row'>".$i."</th>";
    echo "<td>"."DI_".$i."</td>";
    echo "<td>";
    echo "<p id='DI_".$i."'> </p>";
    echo "</td>";
    echo "</tr>";
}
?>
    </table>

    <h3>    DO</h3>
    <table width="100%" border="1" align="center" >
    <tr>
      <th scope="col">Index</th>
      <th scope="col">Name</th>
      <th scope="col">HIGH</th>
      <th scope="col">LOW</th>
    </tr>
<?php
for ($i = 0; $i < 8; $i++) {
    echo "<tr>";
    echo "<th socpe='row'>".$i."</th>";
    echo "<td>"."DO_".$i."</td>";
    echo "<td>";
    echo "<button onclick='gpio_output_high(".$i.")'>"."HIGH"."</button>";
    echo "</td>";
    echo "<td>";
    echo "<button onclick='gpio_output_low(".$i.")'>"."LOW"."</button>";
    echo "</td>";
    echo "</tr>";
}

?>
    </table>
<div>
