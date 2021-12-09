<?php

if (isset($_POST['submit'])) {

    require_once("connect.php");

    $ID = $_POST['ID'];

    $query = "Call getById(:ID)";

try
    {
      $prepared_stmt = $dbo->prepare($query);
      $prepared_stmt->bindValue(':ID', $ID, PDO::PARAM_STR);
      $prepared_stmt->execute();
      $result = $prepared_stmt->fetchAll();

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
    
    <h1> Search Accident by ID</h1>

    <form method="post">

      <label for="ID">ID</label>
      <input type="text" name="ID">
      
      <input type="submit" name="submit" value="Submit">
    </form>
    <?php
      if (isset($_POST['submit'])) {
        if ($result && $prepared_stmt->rowCount() > 0) { ?>
    
              <h2>Results</h2>

              <table>
                <thead>
                  <tr>
                    <th>ID</th>
		    <th>City</th>
		    <th>State</th>
                    <th>Description</th>
                    <th>Severity</th>
                    <th>Start_Time</th>
                  </tr>
                </thead>
                <tbody>
            
                  <?php foreach ($result as $row) { ?>
                
                    <tr>
                      <td><?php echo $row["ID"]; ?></td>
		      <td><?php echo $row["City"]; ?></td>
		      <td><?php echo $row["State"]; ?></td>
                      <td><?php echo $row["Description"]; ?></td>
                      <td><?php echo $row["Severity"]; ?></td>
                      <td><?php echo $row["Start_Time"]; ?></td>
                    </tr>
                  <?php } ?>
                </tbody>
            </table>
  
        <?php } else { ?>
          Sorry No results found for <?php echo $_POST['ID']; ?>.
        <?php }
    } ?>


    
  </body>
</html>






