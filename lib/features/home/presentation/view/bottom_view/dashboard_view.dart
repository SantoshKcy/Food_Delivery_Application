import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_application/app/di/di.dart';
// Entities
import 'package:food_delivery_application/features/category/domain/entity/category_entity.dart';
import 'package:food_delivery_application/features/category/presentation/view_model/category_bloc.dart';
import 'package:food_delivery_application/features/home/domain/entity/home_entity.dart';
// Blocs
import 'package:food_delivery_application/features/home/presentation/view_model/home_bloc.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();

    // ✅ Fetch data when the view is created
    Future.microtask(() {
      if (!mounted) return;
      context.read<CategoryBloc>().add(LoadCategories());

      if (!mounted) return;
      context.read<HomeBloc>().add(const LoadItemsByTag("Featured"));
      context.read<HomeBloc>().add(const LoadItemsByTag("Popular"));
      context.read<HomeBloc>().add(const LoadItemsByTag("Trending"));
      context.read<HomeBloc>().add(const LoadItemsByTag("Special"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<CategoryBloc>()),
        BlocProvider.value(value: getIt<HomeBloc>()),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              const SizedBox(height: 20),
              _buildFeatureBanner(),
              const SizedBox(height: 20),

              // ✅ *List Categories from CategoryBloc*
              _buildSectionHeader('🍔 Categories', () {}),
              const SizedBox(height: 10),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, categoryState) {
                  if (categoryState.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (categoryState.error != null) {
                    return Center(child: Text("Error: ${categoryState.error}"));
                  }
                  return _buildCategoryList(categoryState.categories);
                },
              ),

              const SizedBox(height: 20),

              // ✅ *List Items by Tags*
              _buildItemsByTag("Featured", "🌟"),
              const SizedBox(height: 20),
              _buildItemsByTag("Popular", "🔥"),
              const SizedBox(height: 20),
              _buildItemsByTag("Trending", "📈"),
              const SizedBox(height: 20),
              _buildItemsByTag("Special", "🎁"),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFFF7918),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            const Icon(Icons.location_on, color: Colors.white, size: 24),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                'P82+2R9, Rudramati Marga, Kathmandu',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {},
              child: const CircleAvatar(
                radius: 18,
                backgroundImage:
                    NetworkImage('https://i.pravatar.cc/150?img=5'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search your food',
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildFeatureBanner() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade700, Colors.orange.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🍽 Best Deals\nJust for You!',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child:
                const Text('Order Now', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: onTap,
          child: const Text(
            'See All',
            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryList(List<CategoryEntity> categories) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return _buildCategoryItem(category.name, category.image);
        },
      ),
    );
  }

  Widget _buildCategoryItem(String name, String image) {
    String fullImageUrl = "http://10.0.2.2:3000/uploads/$image";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.network(fullImageUrl,
                height: 70, width: 70, fit: BoxFit.cover),
          ),
          const SizedBox(height: 5),
          Text(name,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildItemsByTag(String tag, String emoji) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final items = state.taggedItems[tag] ?? [];

        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.errorMessage != null) {
          return Center(child: Text("Error: ${state.errorMessage}"));
        }
        if (items.isEmpty) {
          return const Center(child: Text("No items available"));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader("$emoji $tag", () {}),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return _buildItemCard(item);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildItemCard(HomeEntity item) {
    String fullImageUrl = "http://10.0.2.2:3000/uploads/${item.image}";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 150, // ✅ Set a fixed width for horizontal scrolling
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                fullImageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported, size: 100),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Rs. ${item.price}",
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: ElevatedButton(
                onPressed: () {
                  // Handle add to cart action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  minimumSize: const Size(double.infinity, 30),
                ),
                child: const Text("Add to Cart",
                    style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
