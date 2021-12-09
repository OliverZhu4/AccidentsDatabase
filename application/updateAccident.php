<?php

if (isset($_POST['submit'])) {

    require_once("connect.php");

    $ID = $_POST['ID'];
    $Severity = $_POST['Severity'];
    
    $query = "Call updateSev(:ID,:Severity)";
    
    try
    {
      $prepared_stmt = $dbo->prepare($query);
      $prepared_stmt->bindValue(':ID', $ID, PDO::PARAM_STR);
      $prepared_stmt->bindValue(':Severity', $Severity, PDO::PARAM_STR);
      $prepared_stmt->execute();

    }
    catch (PDOException $ex)
    { // Error in database processing.
      echo $sql . "<br>" . $error->getMessage(); // HTTP 500 - Internal Server Error
    }
}

?>

<html>
  <head>
    <link rel="stylesheet" type="text/css" href="project3.css" />
  </head> 

  <body>
    <div id="navbar">
      <ul>
				<li><a href="index2.html"> Home</a></li>
				<li><a href="getByID.php"> Search(ID)</a></li>
				<li><a href="getAccident01.php"> Search(City) </a></li>
				<li><a href="deleteAccident.php"> Delete </a></li>
				<li><a href="updateAccident.php"> Update </a></li>
				<li><a href="insertAccident.php"> Insert </a></li>
				<li><a href="updateAccident.php"> Update </a></li>
      </ul>
    </div>
    
    <h1> Update the Severity of an Accident </h1>

    <form method="post">

      <label for="ID">ID of accident</label>
      <input type="text" name="ID" id="ID">

      <label for="Severity">Updated severity of accident</label>
      <input type="text" name="Severity" id="Severity">
      
      <input type="submit" name="submit" value="Submit">
    </form>
    <?php	
 	if (isset($_POST['submit'])){ ?>
          You have successfully updated the selected accident.
	<?php } ?>
  </body>
</html>


