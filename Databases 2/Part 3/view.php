<html>
<body>
<center>
<?php
$mysqli = mysqli_connect("localhost", "root", "", "insurance");

if (mysqli_connect_errno()) {
	printf("Connect failed: %s\n", mysqli_connect_error());
	exit();
} else {
	$sql = "SELECT * FROM PRODUCT";
	$res = mysqli_query($mysqli, $sql);

	if ($res) {
	    while ($newArray = mysqli_fetch_array($res, MYSQLI_BOTH)) {
	        $prod_pname  = $newArray['PNAME'];
			$prod_anncost = $newArray['ANNCOST'];
			$prod_mintime = $newArray['MINTIME'];
			$prod_benefits = $newArray['BENEFITS'];
			echo "<p><b>Product Name:</b> ".$prod_pname."<br/>".
                 "<b>Annual Cost:</b> ".$prod_anncost."<br/>".
                 "<b>Minimum Time:</b> ".$prod_mintime."<br/>".
				 "<b>Minimum Time:</b> ".$prod_benefits."<br/></p>";
	   	}
	} else {
	printf("Could not retrieve records: %s\n", mysqli_error($mysqli));
	}

	mysqli_free_result($res);
	mysqli_close($mysqli);
}
?>
	<form name="goBack" method="post" action="index.html">
	<p><input type="submit" name="submit" value="Return to menu"></p>
	</form>
  </body>
</html>
