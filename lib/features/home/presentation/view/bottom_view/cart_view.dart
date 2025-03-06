import 'package:flutter/material.dart';
import 'package:food_delivery_application/features/home/presentation/view/bottom_view/checkout_view.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<CartItem> cartItems = [
    CartItem(
        name: "Chicken Pizza",
        price: 200,
        image: "assets/images/pizza.jpg",
        quantity: 1,
        isChecked: true),
    CartItem(
        name: "Chicken Tandoori",
        price: 400,
        image: "assets/images/chicken_tandoori.jpg",
        quantity: 2,
        isChecked: true),
    CartItem(
        name: "Chilly Momo",
        price: 200,
        image: "assets/images/chilly_momo.jpg",
        quantity: 1,
        isChecked: true),
  ];

  int deliveryCharge = 150;

  @override
  Widget build(BuildContext context) {
    int totalItems = cartItems.fold(0, (sum, item) => sum + item.quantity);
    int totalPrice =
        cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7918),
        elevation: 0,
        title: const Text(
          "My Cart",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return _buildCartItem(cartItems[index]);
                },
              ),
            ),
            const SizedBox(height: 10),

            // Payment Summary
            _buildPaymentSummary(totalItems, totalPrice),

            const SizedBox(height: 10),

            // Proceed to Checkout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CheckoutView()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7918), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Proceed to Checkout",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // 🔹 Build Each Cart Item Row
  Widget _buildCartItem(CartItem item) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Checkbox(
              value: item.isChecked,
              activeColor: const Color(0xFFFF7918),
              onChanged: (bool? value) {
                setState(() {
                  item.isChecked = value!;
                });
              },
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                item.image,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Rs. ${item.price}",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFFFF7918),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (item.quantity > 1) item.quantity--;
                          });
                        },
                        icon: const Icon(Icons.remove_circle_outline,
                            color: Colors.grey, size: 24),
                      ),
                      Text(
                        '${item.quantity}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            item.quantity++;
                          });
                        },
                        icon: const Icon(Icons.add_circle_outline,
                            color: Colors.grey, size: 24),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  cartItems.remove(item);
                });
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Build Payment Summary
  Widget _buildPaymentSummary(int totalItems, int totalPrice) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Payment Summary",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildSummaryRow("Total Items (3)", "Rs. $totalPrice"),
          _buildSummaryRow("Delivery Charge", "Rs. $deliveryCharge"),
          _buildSummaryRow("Discount", "- Rs. 0.00", isDiscount: true),
          const Divider(),
          _buildSummaryRow("Total", "Rs. ${totalPrice + deliveryCharge}",
              isBold: true),
        ],
      ),
    );
  }

  // 🔹 Build Summary Row
  Widget _buildSummaryRow(String title, String value,
      {bool isBold = false, bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isDiscount ? Colors.red : Colors.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isDiscount ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// 🔹 Cart Item Model
class CartItem {
  String name;
  int price;
  String image;
  int quantity;
  bool isChecked;

  CartItem(
      {required this.name,
      required this.price,
      required this.image,
      required this.quantity,
      required this.isChecked});
}
