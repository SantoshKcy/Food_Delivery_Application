import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_application/core/sensors/proximity_provider.dart';

class OrderItem {
  final String status;
  final int totalPrice;
  final String orderDate;
  final String deliveryAddress;
  final List<CartItem> items;

  OrderItem({
    required this.status,
    required this.totalPrice,
    required this.orderDate,
    required this.deliveryAddress,
    required this.items,
  });
}

class CartItem {
  final String name;
  final int price;
  final String image;
  final int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
  });
}

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final List<OrderItem> orders = [
    OrderItem(
      status: "Pending",
      totalPrice: 800,
      orderDate: "March 5, 2025 - 12:45 PM",
      deliveryAddress: "Kathmandu, Nepal",
      items: [
        CartItem(name: "Chicken Pizza", price: 200, image: "assets/images/pizza.jpg", quantity: 1),
        CartItem(name: "Chicken Tandoori", price: 400, image: "assets/images/chicken_tandoori.jpg", quantity: 2),
        CartItem(name: "Chilly Momo", price: 200, image: "assets/images/chilly_momo.jpg", quantity: 1),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isNear = Provider.of<ProximityProvider>(context).isNear;

    return Scaffold(
      backgroundColor: isNear ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isNear ? Colors.black : const Color(0xFFFF7918),
        elevation: 0,
        title: Text(
          "My Orders",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isNear
          ? Container(color: Colors.black)
          : orders.isEmpty
              ? _buildEmptyOrders()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return _buildOrderCard(orders[index]);
                  },
                ),
    );
  }

  Widget _buildOrderCard(OrderItem order) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildOrderStatus(order.status),
              ],
            ),
            const SizedBox(height: 8),
            Text(order.orderDate, style: const TextStyle(fontSize: 14, color: Colors.black54)),
            const SizedBox(height: 8),
            Column(
              children: order.items.map((item) => _buildOrderItem(item)).toList(),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.red),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(order.deliveryAddress, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total: Rs. ${order.totalPrice}.00", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFFF7918))),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7918),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("View Details", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(CartItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(item.image, width: 50, height: 50, fit: BoxFit.cover),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text("Qty: ${item.quantity}", style: const TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ),
          Text("Rs. ${item.price * item.quantity}.00", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFFF7918))),
        ],
      ),
    );
  }
  
  _buildEmptyOrders() {}
  
  Widget _buildOrderStatus(String status) {
    Color statusColor;
    switch (status) {
      case "Delivered":
        statusColor = Colors.green;
        break;
      case "Pending":
        statusColor = Colors.orange;
        break;
      case "Cancelled":
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor, width: 1),
      ),
      child: Text(status, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: statusColor)),
    );
  }
}
