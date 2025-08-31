<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin - Product Management</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }
    body { display: flex; min-height: 100vh; background: #f4f6f9; }
    /* Sidebar */
    .sidebar { width: 220px; background: linear-gradient(180deg, #ff7e5f, #feb47b); color: #fff; padding: 20px; }
    .sidebar h2 { text-align: center; margin-bottom: 30px; }
    .sidebar ul { list-style: none; }
    .sidebar ul li { margin: 15px 0; }
    .sidebar ul li a { color: #fff; text-decoration: none; display: block; padding: 8px 12px; border-radius: 6px; transition: background 0.3s; }
    .sidebar ul li a:hover, .sidebar ul li a.active { background: rgba(255, 255, 255, 0.2); }
    /* Main */
    .main { flex: 1; padding: 20px; }
    .topbar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
    .topbar h1 { font-size: 22px; color: #333; }
    .topbar .profile { display: flex; align-items: center; }
    .topbar .profile img { width: 35px; height: 35px; border-radius: 50%; margin-left: 10px; }
    /* Buttons */
    .btn { background: linear-gradient(90deg, #ff7e5f, #feb47b); color: #fff; padding: 8px 15px; border: none; border-radius: 6px; cursor: pointer; font-size: 14px; transition: opacity 0.3s; }
    .btn:hover { opacity: 0.85; }
    /* Search */
    .search-box { margin-bottom: 15px; }
    .search-box input { padding: 8px; width: 250px; border: 1px solid #ccc; border-radius: 6px; }
    /* Table */
    table { width: 100%; border-collapse: collapse; background: #fff; border-radius: 12px; overflow: hidden; box-shadow: 0 3px 6px rgba(0,0,0,0.1); }
    th, td { padding: 12px; text-align: center; border-bottom: 1px solid #eee; }
    th { background: #ff7e5f; color: #fff; }
    tr:hover { background: #f9f9f9; }
    .product-img { width: 40px; height: 40px; object-fit: cover; border-radius: 6px; }
    .action-btn { padding: 5px 10px; margin: 0 3px; border: none; border-radius: 5px; cursor: pointer; font-size: 12px; }
    .edit-btn { background: #36A2EB; color: #fff; }
    .delete-btn { background: #FF6384; color: #fff; }
    /* Modal */
    .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); justify-content: center; align-items: center; }
    .modal-content { background: #fff; padding: 20px; border-radius: 12px; width: 400px; position: relative; box-shadow: 0 5px 15px rgba(0,0,0,0.3); }
    .modal-content h2 { margin-bottom: 15px; color: #333; }
    .modal-content label { display: block; margin: 8px 0 4px; font-size: 14px; color: #555; }
    .modal-content input, .modal-content select { width: 100%; padding: 8px; margin-bottom: 10px; border: 1px solid #ccc; border-radius: 6px; }
    .close { position: absolute; top: 10px; right: 15px; font-size: 18px; cursor: pointer; color: #333; }
  </style>
</head>
<body>

  <!-- Sidebar (same as before) -->
  <div class="sidebar">
    <h2 id="subDomainName">${sessionScope.subDomainName}</h2>
    <form id="menuForm" method="post">
      <ul>
        <li><a href="#" onclick="submitMenu('dashboard')">Dashboard</a></li>
        <li><a class="active" href="#" onclick="submitMenu('products')">Products</a></li>
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
    <!-- Topbar -->
    <div class="topbar">
      <h1>Product Management</h1>
      <div class="profile">
        <span>${sessionScope.userName}</span>
        <img src="https://i.pravatar.cc/35" alt="profile">
      </div>
    </div>

    <!-- Add Product Button -->
    <div style="margin-bottom: 15px;">
      <button class="btn" onclick="openModal()">+ Add Product</button>
    </div>

    <!-- Search -->
    <div class="search-box">
      <input type="text" id="searchInput" placeholder="Search product by name...">
    </div>

    <!-- Product Table -->
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Image</th>
          <th>Name</th>
          <th>Category</th>
          <th>Price</th>
          <th>Stock</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody id="productTableBody">
        <%
          String jsonData = (String) request.getAttribute("products");
          if (jsonData != null) {
              JSONArray arr = new JSONArray(jsonData);
              for (int i = 0; i < arr.length(); i++) {
                  JSONObject p = arr.getJSONObject(i);
        %>
          <tr>
            <td><%= p.getInt("id") %></td>
            <td><img src="<%= p.getString("image") %>" class="product-img"></td>
            <td><%= p.getString("name") %></td>
            <td><%= p.getString("category") %></td>
            <td>?<%= p.getDouble("price") %></td>
            <td><%= p.getInt("stock") %></td>
            <td><%= p.getString("status") %></td>
            <td>
              <button class="action-btn edit-btn" onclick="editProduct(<%= p.getInt("id") %>)">Edit</button>
              <button class="action-btn delete-btn" onclick="deleteProduct(<%= p.getInt("id") %>)">Delete</button>
            </td>
          </tr>
        <%
              }
          }
        %>
      </tbody>
    </table>
  </div>

  <!-- Modal (same as before) -->
  <div class="modal" id="productModal"> ... </div>

  <script>
    // Now products come from server, no hardcoded array
    function submitMenu(actionUrl) {
      const form = document.getElementById('menuForm');
      form.action = actionUrl;
      form.submit();
    }

    function openModal() { document.getElementById("productModal").style.display = "flex"; }
    function closeModal() { document.getElementById("productModal").style.display = "none"; }
  </script>
</body>
</html>
