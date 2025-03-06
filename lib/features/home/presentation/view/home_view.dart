import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:food_delivery_application/core/theme/theme_provider.dart';
import 'package:food_delivery_application/core/sensors/proximity_provider.dart';
import 'package:food_delivery_application/features/home/presentation/view_model/home_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isNear = context.watch<ProximityProvider>().isNear;
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      backgroundColor: isNear ? Colors.black : (themeProvider.themeMode == ThemeMode.dark ? Colors.black : Colors.white),
      body: isNear
          ? Container(color: Colors.black)
          : BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.views.isEmpty || state.selectedIndex >= state.views.length) {
                  return const Center(child: Text("No View Available"));
                }
                return state.views.elementAt(state.selectedIndex);
              },
            ),
      bottomNavigationBar: isNear
          ? SizedBox.shrink()
          : BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Wishlist'),
                    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
                    BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: 'Order'),
                    BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: 'Account'),
                  ],
                  currentIndex: state.selectedIndex,
                  backgroundColor: themeProvider.themeMode == ThemeMode.dark ? Colors.black : Colors.white,
                  selectedItemColor: const Color(0xFFFF7918),
                  unselectedItemColor: themeProvider.themeMode == ThemeMode.dark ? Colors.white70 : Colors.black,
                  onTap: (index) {
                    context.read<HomeBloc>().add(ChangeTabEvent(index));
                  },
                );
              },
            ),
    );
  }
}
