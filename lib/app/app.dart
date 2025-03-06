import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_application/app/di/di.dart';
import 'package:food_delivery_application/core/sensors/proximity_provider.dart'; // Import ProximityProvider
import 'package:food_delivery_application/core/theme/app_theme.dart';
import 'package:food_delivery_application/core/theme/theme_provider.dart'; // Import ThemeProvider
import 'package:food_delivery_application/features/splash/presentation/view/splash_view.dart';
import 'package:food_delivery_application/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:provider/provider.dart'; // Import Provider

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ThemeProvider()), // ✅ Theme Provider
        ChangeNotifierProvider(
            create: (context) =>
                ProximityProvider()), // ✅ Proximity Provider (Global)
      ],
      child: Builder(
        builder: (context) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Food Delivery Application',
            theme: AppTheme.getApplicationTheme(
                isDarkMode: themeProvider.themeMode == ThemeMode.dark),
            darkTheme: AppTheme.getApplicationTheme(isDarkMode: true),
            themeMode: themeProvider.themeMode, // Apply dynamic theme mode
            home: BlocProvider.value(
              value: getIt<SplashCubit>(),
              child: const SplashView(),
            ),
          );
        },
      ),
    );
  }
}
