<?php

if (isset($_POST['submit'])) {

    require_once("connect.php");

    $ID = $_POST['ID'];
    $City = $_POST['City'];
    $State = $_POST['State'];
    $Description = $_POST['Description'];
    $Severity = $_POST['Severity'];
    $Starttime = $_POST['Starttime'];
    
    $query = "Call insertAccident(:ID, :City, :State, :Description, :Severity, :Starttime)";
    
    try
    {
      $prepared_stmt = $dbo->prepare($query);
      $prepared_stmt->bindValue(':ID', $ID, PDO::PARAM_STR);
      $prepared_stmt->bindValue(':City', $City, PDO::PARAM_STR);
      $prepared_stmt->bindValue(':State', $State, PDO::PARAM_STR);
      $prepared_stmt->bindValue(':Description', $Description, PDO::PARAM_STR);
      $prepared_stmt->bindValue(':Severity', $Severity, PDO::PARAM_INT);
      $prepared_stmt->bindValue(':Starttime', $Starttime, PDO::PARAM_STR);
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
    
    <h1> Insert an Accident </h1>

    <form method="post">

      <label for="ID">ID of accident</label>
      <input type="text" name="ID" id="ID">

      <label for="City">City of accident</label>
      <input type="text" name="City" id="City">

      <label for="State">State of accident</label>
      <input type="text" name="State" id="State">

      <label for="Description">Description of accident</label>
      <input type="text" name="Description" id="Description">

      <label for="Severity">Severity of accident</label>
      <input type="text" name="Severity" id="Severity">

      <label for="Starttime">Starttime of accident</label>
      <input type="text" name="Starttime" id="Starttime">
      
      <input type="submit" name="submit" value="Submit">
    </form>
    <?php	
 	if (isset($_POST['submit'])){ ?>
          You have successfully inserted the selected accident.
	<?php } ?>
  </body>
</html>


