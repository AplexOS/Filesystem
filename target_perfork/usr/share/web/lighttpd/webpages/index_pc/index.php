

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"> 
	<title>Aplex</title>
	<link rel="stylesheet" href="bootstrap.min.css">  
	<script src="=jquery.min.js"></script>
	<script src="bootstrap.min.js"></script>
</head>
<body>

<div class="container">
	<div class="row clearfix">
		<div class="col-md-12 column">
			<div class="page-header">
				<h1>
					Aplex
				</h1>
			</div>
			<div class="jumbotron">
				<h1>
					Hello, Apache2!
				</h1>
				
				
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
						服务列表
					</h3>
				</div>
				<div class="panel-body  " id="apache_div" >
				<a href="phpinfo.php" target="_blank">查看web服务器版本!</a>
				</div>
				<div class="panel-body " id="qt_div">
					<a href="matrix.php" target="_blank">进入QT桌面!</a>
					
				</div>
			</div>
		</div>
	</div>
</div>
<!-- <script type="text/javascript" >
	function file_get(){
		;
	}
	function div_click(obj)
	{
		if(obj.id == "apache_div")
		{
			alert("查看web服务器版本");
		}
		else if (obj.id == "qt_div")
		{
			alert("进入QT桌面");
		}
	}

</script> -->
</body>
</html>