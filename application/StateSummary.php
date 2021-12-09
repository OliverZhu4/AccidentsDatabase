<?php

if (isset($_POST['submit'])) {

    require_once("connect.php");

    $query = "Select *
	     from state_summary
             order by Count DESC";

try
    {
      $prepared_stmt = $dbo->prepare($query);
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
      </ul>
    </div>
    
    <h1> Report by State</h1>

    <form method="post">
      
      <input type="submit" name="submit" value="Submit">
    </form>
    <?php
      if (isset($_POST['submit'])) {
        if ($result && $prepared_stmt->rowCount() > 0) { ?>
    
              <h2>Results</h2>

              <table>
                <thead>
                  <tr>
		    <th>State</th>
		    <th>Count</th>
                    <th>SeverityAverage</th>
                  </tr>
                </thead>
                <tbody>
            
                  <?php foreach ($result as $row) { ?>
                
                    <tr>
		      <td><?php echo $row["State"]; ?></td>
		      <td><?php echo $row["Count"]; ?></td>
                      <td><?php echo $row["SeverityAverage"]; ?></td>
                    </tr>
                  <?php } ?>
                </tbody>
            </table>
  
        <?php } else { ?>
          Sorry No results found for <?php echo $_POST['City']; ?>.
        <?php }
    } ?>


    
  </body>
</html>






