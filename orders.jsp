<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin - Order Management</title>
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
    /* Search */
    .search-box { margin-bottom: 15px; }
    .search-box input { padding: 8px; width: 280px; border: 1px solid #ccc; border-radius: 6px; }
    /* Table */
    table { width: 100%; border-collapse: collapse; background: #fff; border-radius: 12px; overflow: hidden; box-shadow: 0 3px 6px rgba(0,0,0,0.1); }
    th, td { padding: 12px; text-align: center; border-bottom: 1px solid #eee; }
    th { background: #ff7e5f; color: #fff; }
    tr:hover { background: #f9f9f9; }
    .action-btn { padding: 5px 10px; margin: 0 3px; border: none; border-radius: 5px; cursor: pointer; font-size: 12px; }
    .view-btn { background: #36A2EB; color: #fff; }
    .update-btn { background: #4BC0C0; color: #fff; }
    .delete-btn { background: #FF6384; color: #fff; }
    /* Modal */
    .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); justify-content: center; align-items: center; }
    .modal-content { background: #fff; padding: 20px; border-radius: 12px; width: 450px; position: relative; box-shadow: 0 5px 15px rgba(0,0,0,0.3); }
    .modal-content h2 { margin-bottom: 15px; color: #333; }
    .modal-content label { display: block; margin: 8px 0 4px; font-size: 14px; color: #555; }
    .modal-content input, .modal-content select { width: 100%; padding: 8px; margin-bottom: 10px; border: 1px solid #ccc; border-radius: 6px; }
    .close { position: absolute; top: 10px; right: 15px; font-size: 18px; cursor: pointer; color: #333; }
  </style>
</head>
<body>

  <!-- Sidebar -->
  <div class="sidebar">
    <h2>Admin</h2>
    <ul>
      <li><a href="dashboard.html">Dashboard</a></li>
      <li><a href="products.html">Products</a></li>
      <li><a href="orders.html" class="active">Orders</a></li>
      <li><a href="#">Users</a></li>
      <li><a href="#">Payments</a></li>
      <li><a href="#">Reports</a></li>
      <li><a href="#">Settings</a></li>
    </ul>
  </div>

  <!-- Main Content -->
  <div class="main">
    <!-- Topbar -->
    <div class="topbar">
      <h1>Order Management</h1>
      <div class="profile">
        <span>Admin</span>
        <img src="https://i.pravatar.cc/35" alt="profile">
      </div>
    </div>

    <!-- Search -->
    <div class="search-box">
      <input type="text" id="searchInput" placeholder="Search by Order ID or Customer name...">
    </div>

    <!-- Orders Table -->
    <table>
      <thead>
        <tr>
          <th>Order ID</th>
          <th>Customer</th>
          <th>Date</th>
          <th>Total</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody id="orderTableBody"></tbody>
    </table>
  </div>

  <!-- Modal -->
  <div class="modal" id="orderModal">
    <div class="modal-content">
      <span class="close" onclick="closeModal()">&times;</span>
      <h2>Order Details</h2>
      <form id="orderForm">
        <input type="hidden" id="orderId">
        <label>Customer Name</label>
        <input type="text" id="customerName" readonly>
        <label>Date</label>
        <input type="text" id="orderDate" readonly>
        <label>Total Amount</label>
        <input type="text" id="orderTotal" readonly>
        <label>Status</label>
        <select id="orderStatus">
          <option value="Pending">Pending</option>
          <option value="Processing">Processing</option>
          <option value="Shipped">Shipped</option>
          <option value="Delivered">Delivered</option>
          <option value="Cancelled">Cancelled</option>
        </select>
        <button type="submit" class="action-btn update-btn" style="width:100%; margin-top:10px;">Update Order</button>
      </form>
    </div>
  </div>

  <script>
    let orders = [
      { id: "ORD1001", customer: "Ravi Sharma", date: "2025-08-10", total: 2499, status: "Pending" },
      { id: "ORD1002", customer: "Priya Verma", date: "2025-08-11", total: 1599, status: "Processing" },
      { id: "ORD1003", customer: "Amit Singh", date: "2025-08-12", total: 499, status: "Shipped" },
      { id: "ORD1004", customer: "Neha Gupta", date: "2025-08-13", total: 799, status: "Delivered" },
      { id: "ORD1005", customer: "Rahul Mehta", date: "2025-08-14", total: 999, status: "Cancelled" }
    ];

    const modal = document.getElementById("orderModal");
    const form = document.getElementById("orderForm");

    function renderOrders(data) {
      const tableBody = document.getElementById("orderTableBody");
      tableBody.innerHTML = "";
      data.forEach(o => {
        const row = `
          <tr>
            <td>${o.id}</td>
            <td>${o.customer}</td>
            <td>${o.date}</td>
            <td>₹${o.total}</td>
            <td>${o.status}</td>
            <td>
              <button class="action-btn view-btn" onclick="viewOrder('${o.id}')">View</button>
              <button class="action-btn delete-btn" onclick="deleteOrder('${o.id}')">Delete</button>
            </td>
          </tr>
        `;
        tableBody.innerHTML += row;
      });
    }

    // Search
    document.getElementById("searchInput").addEventListener("keyup", function() {
      const value = this.value.toLowerCase();
      const filtered = orders.filter(o => o.customer.toLowerCase().includes(value) || o.id.toLowerCase().includes(value));
      renderOrders(filtered);
    });

    // Open Modal
    function viewOrder(id) {
      const order = orders.find(o => o.id === id);
      document.getElementById("orderId").value = order.id;
      document.getElementById("customerName").value = order.customer;
      document.getElementById("orderDate").value = order.date;
      document.getElementById("orderTotal").value = "₹" + order.total;
      document.getElementById("orderStatus").value = order.status;
      modal.style.display = "flex";
    }

    // Close Modal
    function closeModal() { modal.style.display = "none"; }
    window.onclick = function(e) { if (e.target == modal) closeModal(); }

    // Update Order
    form.addEventListener("submit", function(e) {
      e.preventDefault();
      const id = document.getElementById("orderId").value;
      const status = document.getElementById("orderStatus").value;
      const index = orders.findIndex(o => o.id === id);
      orders[index].status = status;
      renderOrders(orders);
      closeModal();
    });

    // Delete Order
    function deleteOrder(id) {
      if (confirm("Are you sure you want to delete this order?")) {
        orders = orders.filter(o => o.id !== id);
        renderOrders(orders);
      }
    }

    // Initial Load
    renderOrders(orders);
  </script>

</body>
</html>
