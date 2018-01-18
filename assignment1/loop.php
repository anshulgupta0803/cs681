<!DOCTYPE html>
<html>
	<body>
	<?php
		$val = 1300000;

		$time1 = microtime(true);
		for ($i = 1; $i <= $val; $i++);
		$time2 = microtime(true);

		echo "\tTime taken = " . ($time2 - $time1) . " sec\n";
	?>
	</body>
</html>

