<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Products</title>
  <style>
    .container {
      max-width: 350px;
      margin: 50px auto;
      text-align: center;
    }
    select {
      width: 100%;
      min-height: 150px;
      margin-bottom: 20px;
    }

    input[type="submit"] {
      margin-bottom: 20px;
    }
  </style>
</head>

<body>

  <div class="container mt-5">
    <form action="" method="post" class="mb-3">
        <select name="Prodcuts[]" multiple>
          <option value = "101">Term Plan</option>
          <option value = "102">Whole Life</option>
          <option value = "103">Retirement Plan</option>
          <option value = "201">Comprehensive</option>
          <option value = "202">Third-Party</option>
          <option value = "301">Individual</option>
          <option value = "302">Family</option>
          <option value = "303">Critical Illness</option>
          <option value = "401">Natural Causes</option>
          <option value = "402">Burglaries</option>
        </select>
        <input type="submit" name="submit" vlaue="Choose options">
    </form>

    <?php
      if(isset($_POST['submit'])){
        if(!empty($_POST['Prodcuts'])) {
          foreach($_POST['Prodcuts'] as $selected)
		  {
            echo '  ' . $selected;
          }          
        } else {
          echo 'Please select the value.';
        }
      }
    ?>
  </div>

</body>

</html>