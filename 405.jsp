<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>404 - Page Not Found</title>
  <style>
    * {margin:0; padding:0; box-sizing:border-box; font-family:Arial,sans-serif;}
    body {
      height:100vh; display:flex; justify-content:center; align-items:center;
      background:linear-gradient(135deg,#ff7e5f,#feb47b);
      color:#fff; text-align:center; padding:20px;
    }
    .container {
      max-width:600px; padding:40px; border-radius:15px;
      background:rgba(0,0,0,0.5); box-shadow:0 6px 14px rgba(0,0,0,0.3);
    }
    h1 {font-size:60px; margin-bottom:15px;}
    h2 {font-size:22px; margin-bottom:10px;}
    p {font-size:16px; margin-bottom:20px;}
    a {
      display:inline-block; padding:12px 24px; background:#fff;
      color:#ff7e5f; font-weight:bold; border-radius:8px; text-decoration:none;
      transition:0.3s;
    }
    a:hover {background:#ff7e5f; color:#fff;}
  </style>
</head>
<body>
  <div class="container">
    <h1>405</h1>
    <h2>Oops! Method not allowed</h2>
    <p>For security and functional reasons, this page does not support reloading or direct access via the browser address bar.</p>
    <a href="${pageContext.request.contextPath}/login">Go Back Home</a>
  </div>
</body>
</html>
