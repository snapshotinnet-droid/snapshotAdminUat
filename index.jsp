<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Login</title>
  <style>
    * {margin:0; padding:0; box-sizing:border-box; font-family:Arial,sans-serif;}
    body {
      height:100vh; display:flex; justify-content:center; align-items:center;
      background:linear-gradient(135deg,#ff7e5f,#feb47b);
    }
    .container {
      width:350px; padding:30px; border-radius:15px;
      background:rgba(255,255,255,0.95); box-shadow:0 6px 14px rgba(0,0,0,0.2);
      text-align:center;
    }
    h1 {margin-bottom:20px; color:#ff7e5f;}
    h3 {margin-bottom:20px; color:#ff7e5f;}
    .form-group {margin-bottom:15px; text-align:left;}
    label {font-weight:bold; display:block; margin-bottom:6px; color:#333;}
    input {
      width:100%; padding:10px; border:1px solid #ccc; border-radius:8px;
      font-size:14px;
    }
    button {
      width:100%; padding:12px; margin-top:10px;
      background:#ff7e5f; border:none; color:#fff;
      font-size:16px; font-weight:bold; border-radius:8px;
      cursor:pointer; transition:0.3s;
    }
    button:hover {background:#feb47b;}
    .links {margin-top:15px; font-size:14px;}
    .links a {color:#ff7e5f; text-decoration:none; font-weight:bold;}
    .links a:hover {text-decoration:underline;}
  </style>
</head>
<body>
  <div class="container">
    <h1>Admin Login</h1>
      <h3 id="subDomainName">${sessionScope.subDomainName}</h3>
     <form action="dashboard" method="post">
      <div class="form-group">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" placeholder="Enter email" required>
      </div>
      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password"  placeholder="Enter password" required>
      </div>
      <button type="submit">Login</button>
    </form>
   
    <div class="links">       
      <p>Don't have an account? <a href="${pageContext.request.contextPath}/signup" onclick="this.closest('form').submit(); return false;">Sign Up</a></p>
    </div>
  
  </div>
    
    
    
 




</body>
</html>
