// import 'dart:async';
// import 'dart:developer';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:food_delivery_application/features/home/presentation/view/bottom_view/order_view.dart';
// import 'package:sensors_plus/sensors_plus.dart';

// // Domain Entities
// import 'package:food_delivery_application/features/home/domain/entity/home_entity.dart';

// // Domain Use Cases
// import 'package:food_delivery_application/features/home/domain/usecase/get_items_by_tag_use_case.dart';

// // Import CategoryBloc
// import 'package:food_delivery_application/features/category/presentation/view_model/category_bloc.dart';

// // Import Bottom Views
// import 'package:food_delivery_application/features/home/presentation/view/bottom_view/dashboard_view.dart';
// import 'package:food_delivery_application/features/home/presentation/view/bottom_view/wishlist_view.dart';
// import 'package:food_delivery_application/features/home/presentation/view/bottom_view/cart_view.dart';

// import 'package:food_delivery_application/features/home/presentation/view/bottom_view/account_view.dart';

// part 'home_event.dart';
// part 'home_state.dart';

// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   final GetItemsByTagUseCase _getItemsByTagUseCase;
//   final CategoryBloc _categoryBloc;

//   StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;

//   HomeBloc({
//     required GetItemsByTagUseCase getItemsByTagUseCase,
//     required CategoryBloc categoryBloc,
//   })  : _getItemsByTagUseCase = getItemsByTagUseCase,
//         _categoryBloc = categoryBloc,
//         super(HomeState.initial()) {
//     on<LoadItemsByTag>(_onLoadItemsByTag);
//     on<ChangeTabEvent>(_onChangeTab);
//     on<InitializeHomeViews>(_onInitializeHomeViews);

//     add(const InitializeHomeViews());
//     _categoryBloc.add(LoadCategories());

//     add(const LoadItemsByTag("Featured"));
//     add(const LoadItemsByTag("Popular"));

//     // 🔹 Start listening to gyroscope events
//     _listenToGyroscope();
//   }

//   /// ✅ **1. Initialize Bottom Nav Views**
//   void _onInitializeHomeViews(
//     InitializeHomeViews event,
//     Emitter<HomeState> emit,
//   ) {
//     final initialViews = [
//       const DashboardView(),
//       const WishlistView(),
//       const CartView(),
//       const OrderView(),
//       const AccountView(),
//     ];
//     emit(state.copyWith(views: initialViews));
//   }

//   /// ✅ **2. Load Items By Tag**
//   Future<void> _onLoadItemsByTag(
//     LoadItemsByTag event,
//     Emitter<HomeState> emit,
//   ) async {
//     log("🔍 Bloc: Loading items with tag '${event.tag}'");

//     emit(state.copyWith(isLoading: true));

//     final result = await _getItemsByTagUseCase.call(event.tag);

//     result.fold(
//       (failure) {
//         log("❌ Bloc Error: ${failure.message}");
//         emit(state.copyWith(isLoading: false, errorMessage: failure.message));
//       },
//       (items) {
//         log("✅ Bloc: Received ${items.length} items for tag '${event.tag}'");
//         emit(state.copyWith(
//           isLoading: false,
//           taggedItems: {
//             ...state.taggedItems,
//             event.tag: items,
//           },
//           errorMessage: null,
//         ));
//       },
//     );
//   }

//   /// ✅ **3. Change Bottom Nav Tab**
//   void _onChangeTab(ChangeTabEvent event, Emitter<HomeState> emit) {
//     emit(state.copyWith(selectedIndex: event.newIndex));
//   }

//   /// 🔹 **4. Listen to Gyroscope for Auto Navigation**
//   void _listenToGyroscope() {
//     _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
//       if (event.y > 1.5) {
//         _navigateToTab(-1); // Tilt Left → Previous Tab
//       } else if (event.y < -1.5) {
//         _navigateToTab(1); // Tilt Right → Next Tab
//       }
//     });
//   }

//   /// 🔹 **5. Navigate Tabs Based on Tilt**
//   void _navigateToTab(int direction) {
//     int newIndex = (state.selectedIndex + direction) % state.views.length;
//     if (newIndex < 0) newIndex = state.views.length - 1;

//     add(ChangeTabEvent(newIndex));
//   }

//   @override
//   Future<void> close() {
//     _gyroscopeSubscription?.cancel();
//     return super.close();
//   }
// }
