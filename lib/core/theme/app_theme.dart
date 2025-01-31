// import 'package:flutter/material.dart';

// ThemeData getApplicationTheme() {
//   return ThemeData(
//     primarySwatch: Colors.orange,
//     scaffoldBackgroundColor: Colors.white,
//     fontFamily: 'Poppins Bold',
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         textStyle: const TextStyle(
//             fontSize: 16,
//             color: Colors.white,
//             fontWeight: FontWeight.w500,
//             fontFamily: 'Poppins Regular'),
//         backgroundColor: Colors.orange,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//       ),
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:food_delivery_application/app/constants/theme_constant.dart';

class AppTheme {
  AppTheme._();

  static getApplicationTheme({required bool isDarkMode}) {
    return ThemeData(
        // Change app bar color
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: ThemeConstant.appBarColor,
          centerTitle: true,
          titleTextStyle: TextStyle(
              color: Colors.red, fontSize: 30, fontFamily: 'Poppins Regular'),
        ),

        // Change elevated button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            foregroundColor: Colors.white,
            backgroundColor: ThemeConstant.primaryColor,
            textStyle:
                const TextStyle(fontSize: 20, fontFamily: 'Poppins Regular'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        // Change text field theme
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(),
          labelStyle: TextStyle(fontSize: 20, fontFamily: 'Poppins Regular'),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ThemeConstant.primaryColor,
            ),
          ),
        ),
        // Circular progress bar theme
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: ThemeConstant.primaryColor,
        ),
        //Bottom navigation bar theme
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFFff7918),
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
        // Define global text theme with Poppins Regular and Bold
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'Poppins Regular',
            fontSize: 16,
            fontWeight: FontWeight.w400, // Regular
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Poppins Regular',
            fontSize: 14,
            fontWeight: FontWeight.w400, // Regular
          ),
          titleLarge: TextStyle(
            fontFamily: 'Poppins Regular',
            fontSize: 20,
            fontWeight: FontWeight.bold, // Bold
          ),
          headlineMedium: TextStyle(
            fontFamily: 'Poppins Regular',
            fontSize: 18,
            fontWeight: FontWeight.bold, // Bold
          ),
          headlineSmall: TextStyle(
            fontFamily: 'Poppins Regular',
            fontSize: 16,
            fontWeight: FontWeight.w400, // Regular
          ),
          labelLarge: TextStyle(
            fontFamily: 'Poppins Regular',
            fontSize: 14,
            fontWeight: FontWeight.bold, // Bold
          ),
        ));
  }
}
