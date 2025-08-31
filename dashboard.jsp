<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard</title>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: Arial, sans-serif;
    }
    body {
      display: flex;
      min-height: 100vh;
      background: #f4f6f9;
    }
    /* Sidebar */
    .sidebar {
      width: 220px;
      background: linear-gradient(180deg, #ff7e5f, #feb47b);
      color: #fff;
      padding: 20px;
    }
    .sidebar h2 {
      text-align: center;
      margin-bottom: 30px;
    }
    .sidebar ul {
      list-style: none;
    }
    .sidebar ul li {
      margin: 15px 0;
    }
    .sidebar ul li a {
      color: #fff;
      text-decoration: none;
      display: block;
      padding: 8px 12px;
      border-radius: 6px;
      transition: background 0.3s;
    }
    .sidebar ul li a:hover {
      background: rgba(255, 255, 255, 0.2);
    }

    /* Main */
    .main {
      flex: 1;
      padding: 20px;
    }
    .topbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }
    .topbar h1 {
      font-size: 22px;
      color: #333;
    }
    .topbar .profile {
      display: flex;
      align-items: center;
    }
    .topbar .profile img {
      width: 35px;
      height: 35px;
      border-radius: 50%;
      margin-left: 10px;
    }

    /* Cards */
    .cards {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
      margin-bottom: 30px;
    }
    .card {
      background: #fff;
      padding: 20px;
      border-radius: 12px;
      box-shadow: 0 3px 6px rgba(0,0,0,0.1);
      text-align: center;
    }
    .card h3 {
      font-size: 16px;
      color: #666;
      margin-bottom: 10px;
    }
    .card p {
      font-size: 22px;
      font-weight: bold;
      color: #333;
    }

    /* Charts */
    .charts {
      display: grid;
      grid-template-columns: 2fr 1fr;
      gap: 20px;
    }
    .chart-box {
      background: #fff;
      padding: 20px;
      border-radius: 12px;
      box-shadow: 0 3px 6px rgba(0,0,0,0.1);
    }
    .chart-box h3 {
      margin-bottom: 10px;
      color: #333;
      font-size: 16px;
    }
  </style>
</head>
<body>

  <!-- Sidebar -->
  <div class="sidebar">
    <h2 id="subDomainName">${sessionScope.subDomainName}</h2>
     <form id="menuForm"  method="post">
    <ul>
      <li><a href="#" onclick="submitMenu('dashboard')">Dashboard</a></li>
      <li><a href="#" onclick="submitMenu('products')">Products</a></li>
      <li><a href="#" onclick="submitMenu('orders')">Orders</a></li>
      <li><a href="#" onclick="submitMenu('users')">Users</a></li>
      <li><a href="#" onclick="submitMenu('payments')">Payments</a></li>
      <li><a href="#" onclick="submitMenu('reports')">Reports</a></li>
      <li><a href="#" onclick="submitMenu('settings')">Settings</a></li>
      <li><a href="#" onclick="submitMenu('logout')">Logout</a></li>
    </ul>
    <input type="hidden" id="menuAction" name="menuAction">
  </form>
  </div>

  <!-- Main Content -->
  <div class="main">
    <div class="topbar">
      <h1>Dashboard</h1>
      <div class="profile">
        <span>${sessionScope.userName}</span>
        <img src="https://i.pravatar.cc/35" alt="profile">
      </div>
    </div>

    <!-- Cards -->
    <div class="cards">
      <div class="card">
        <h3>Total Orders</h3>
        <p id="totalOrders">0</p>
      </div>
      <div class="card">
        <h3>Total Revenue</h3>
        <p id="totalRevenue">₹0</p>
      </div>
      <div class="card">
        <h3>Total Products</h3>
        <p id="totalProducts">0</p>
      </div>
      <div class="card">
        <h3>Total Users</h3>
        <p id="totalUsers">0</p>
      </div>
    </div>

    <!-- Charts -->
    <div class="charts">
      <div class="chart-box">
        <h3>Sales Overview</h3>
        <canvas id="salesChart"></canvas>
      </div>
      <div class="chart-box">
        <h3>Orders Distribution</h3>
        <canvas id="ordersChart"></canvas>
      </div>
    </div>
  </div>

  <script>
    // Mock Data (replace with API later)
    const dashboardData = {
      totalOrders: 1250,
      totalRevenue: 875000,
      totalProducts: 320,
      totalUsers: 540,
      sales: [12000, 19000, 15000, 22000, 30000, 28000, 35000],
      salesLabels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul"],
      ordersDistribution: [500, 300, 200, 150, 100],
      orderLabels: ["Pending", "Processing", "Shipped", "Delivered", "Cancelled"]
    };

    // Fill Cards
    document.getElementById("totalOrders").innerText = dashboardData.totalOrders;
    document.getElementById("totalRevenue").innerText = "₹" + dashboardData.totalRevenue.toLocaleString();
    document.getElementById("totalProducts").innerText = dashboardData.totalProducts;
    document.getElementById("totalUsers").innerText = dashboardData.totalUsers;

    // Sales Chart (Line)
    new Chart(document.getElementById("salesChart"), {
      type: "line",
      data: {
        labels: dashboardData.salesLabels,
        datasets: [{
          label: "Sales (₹)",
          data: dashboardData.sales,
          borderColor: "#ff7e5f",
          backgroundColor: "rgba(255,126,95,0.2)",
          fill: true,
          tension: 0.3
        }]
      }
    });

    // Orders Chart (Pie)
    new Chart(document.getElementById("ordersChart"), {
      type: "pie",
      data: {
        labels: dashboardData.orderLabels,
        datasets: [{
          data: dashboardData.ordersDistribution,
          backgroundColor: ["#FF6384","#36A2EB","#FFCE56","#4BC0C0","#9966FF"]
        }]
      }
    });
  </script>
  
  
  <script>
  function submitMenu(actionUrl) {
    const form = document.getElementById('menuForm');
    form.action = actionUrl;
    form.submit();
  }
</script>




</body>
</html>
