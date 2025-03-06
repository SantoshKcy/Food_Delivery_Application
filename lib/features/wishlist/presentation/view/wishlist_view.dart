import 'package:flutter/material.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  List<WishlistItem> wishlistItems = [
    WishlistItem(
        name: "Chicken Biryani",
        price: 300,
        image: "assets/images/chicken-biryani.jpg"),
    WishlistItem(
        name: "Chicken Tandoori",
        price: 320,
        image: "assets/images/chicken_tandoori.jpg"),
    WishlistItem(
        name: "Chilly Momo",
        price: 380,
        image: "assets/images/chilly_momo.jpg"),
  ];

  // Function to show a snackbar message
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7918),
        elevation: 0,
        title: const Text(
          "My Favourite",
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
        child: wishlistItems.isEmpty
            ? _buildEmptyWishlist() // Show empty message if no items
            : ListView.builder(
                itemCount: wishlistItems.length,
                itemBuilder: (context, index) {
                  return _buildWishlistItem(wishlistItems[index]);
                },
              ),
      ),
    );
  }

  // 🔹 Build Each Wishlist Item Row
  Widget _buildWishlistItem(WishlistItem item) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
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
                ],
              ),
            ),
            Row(
              children: [
                // Add to Cart Icon
                IconButton(
                  onPressed: () {
                    _showSnackbar("${item.name} added to cart 🛒");
                  },
                  icon:
                      const Icon(Icons.add_shopping_cart, color: Colors.green),
                ),
                // Delete from Wishlist Icon
                IconButton(
                  onPressed: () {
                    setState(() {
                      wishlistItems.remove(item);
                    });
                    _showSnackbar("${item.name} removed from wishlist ❌");
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Show Empty Wishlist Message
  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Your haven't add any food to wishlist",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// 🔹 Wishlist Item Model
class WishlistItem {
  String name;
  int price;
  String image;

  WishlistItem({required this.name, required this.price, required this.image});
}
