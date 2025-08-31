<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Logout Successful</title>
  <style>
    body {
      margin:0;
      padding:0;
      font-family:Arial, sans-serif;
      display:flex;
      justify-content:center;
      align-items:center;
      height:100vh;
      background:linear-gradient(135deg, #ff7e5f, #feb47b);
      color:#333;
    }
    .container {
      background:#fff;
      padding:30px;
      border-radius:15px;
      box-shadow:0 4px 10px rgba(0,0,0,0.2);
      text-align:center;
      width:350px;
      animation:fadeIn 0.8s ease-in-out;
    }
    @keyframes fadeIn {
      from { opacity:0; transform:translateY(20px); }
      to { opacity:1; transform:translateY(0); }
    }

    .tick {
      width:70px;
      height:70px;
      border-radius:50%;
      border:4px solid #4CAF50;
      display:flex;
      justify-content:center;
      align-items:center;
      margin:0 auto 15px;
      position:relative;
    }
    .tick::after {
      content:"";
      width:20px;
      height:40px;
      border-right:4px solid #4CAF50;
      border-bottom:4px solid #4CAF50;
      transform:rotate(45deg);
      position:absolute;
      top:8px;
      left:22px;
      opacity:0;
      animation:tick 0.6s forwards 0.3s;
    }
    @keyframes tick {
      to { opacity:1; }
    }

    h2 { margin-bottom:10px; color:#4CAF50; }
    p { font-size:14px; color:#555; margin-bottom:20px; }

    .redirect {
      font-size:13px;
      color:#888;
    }

    .btn {
      display:inline-block;
      padding:10px 20px;
      background:#ff7e5f;
      color:#fff;
      text-decoration:none;
      border-radius:8px;
      transition:0.3s;
    }
    .btn:hover { background:#e76b4a; }
  </style>
</head>
<body>
  <div class="container">
    <div class="tick"></div>
    <h2>Logout Successful</h2>
    <p>You have been logged out securely.</p>
    <a href="/index.html" class="btn">Go to Login</a>
    <p class="redirect">Redirecting to login in <span id="countdown">5</span> seconds...</p>
  </div>

  <script>
    let timeLeft = 5;
    let timer = setInterval(() => {
      timeLeft--;
      document.getElementById("countdown").innerText = timeLeft;
      if(timeLeft <= 0){
        clearInterval(timer);
        window.location.href = "${pageContext.request.contextPath}/login";
      }
    }, 1000);
  </script>
</body>
</html>
