import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Row(
            children: [
              Icon(Icons.location_on, color: Colors.white),
              SizedBox(width: 5),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text(
                    'P82+2R9, Rudramati Marga, Kathmandu 44605, N...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Icon(Icons.message, color: Colors.white), // Messenger icon
              SizedBox(width: 10), // Space between the two icons
              Icon(Icons.notifications_none, color: Colors.white),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search your food',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 15),

              // Combo Banner
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.yellow[700],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DHAMAKA\nCOMBO',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {}, // Add functionality
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          child: const Text(
                            'Order Now',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/images/combo.png',
                      height: 70,
                    ), // Replace with actual image asset
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // Categories Section
              _buildSectionHeader('Categories', () {}),
              const SizedBox(height: 10),
              _buildHorizontalList([
                _buildCategoryItem('Foods', 'assets/images/momo.jpg'),
                _buildCategoryItem('Pizza', 'assets/images/burger.jpg'),
                _buildCategoryItem('Bakery', 'assets/images/pizza.jpg'),
                _buildCategoryItem('Dessert', 'assets/images/dessert.jpg'),
                _buildCategoryItem('Drinks', 'assets/images/drink.jpg'),
              ]),
              const SizedBox(height: 15),

              // Popular Now Section
              _buildSectionHeader('Popular Now', () {}),
              const SizedBox(height: 10),
              _buildHorizontalList([
                _buildFoodItem(
                    'Chicken Burger', 'assets/images/burger.jpg', 300),
                _buildFoodItem('Pizza', 'assets/images/pizza.jpg', 800),
                _buildFoodItem('Noodles', 'assets/images/noodles.jpg', 500),
                _buildFoodItem('Chicken Tandoori',
                    'assets/images/chicken_tandoori.jpg', 600),
              ]),
              const SizedBox(height: 15),

              // Hunger End Special Section
              _buildSectionHeader('HUNGER END Special', () {}),
              const SizedBox(height: 10),
              _buildHorizontalList([
                _buildFoodItem(
                    'Chicken Biryani', 'assets/images/biryani.jpg', 300),
                _buildFoodItem(
                    'Keema Noodles', 'assets/images/noodles.jpg', 250),
                _buildFoodItem(
                    'Chicken Choila', 'assets/images/chicken_choila.png', 250),
                _buildFoodItem(
                    'Chicken Burger', 'assets/images/burger.jpg', 500),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: const Text(
            'See All',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalList(List<Widget> items) {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: items,
      ),
    );
  }

  Widget _buildCategoryItem(String name, String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Image.asset(image), // Replace with actual image
          ),
          const SizedBox(height: 5),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildFoodItem(String name, String image, int price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(image,
                fit: BoxFit.cover), // Replace with actual image
          ),
          const SizedBox(height: 5),
          Text(name, style: const TextStyle(fontSize: 12)),
          Text('Rs. $price',
              style: const TextStyle(fontSize: 12, color: Colors.orange)),
        ],
      ),
    );
  }
}
