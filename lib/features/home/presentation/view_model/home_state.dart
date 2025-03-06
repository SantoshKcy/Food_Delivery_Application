// part of 'home_bloc.dart';

// class HomeState extends Equatable {
//   final Map<String, List<HomeEntity>> taggedItems; // ✅ Store items by tag
//   final bool isLoading;
//   final String? errorMessage;
//   final int selectedIndex;

//   // ✅ List of bottom nav views
//   final List<Widget> views;

//   const HomeState({
//     required this.taggedItems,
//     required this.isLoading,
//     this.errorMessage,
//     required this.selectedIndex,
//     required this.views,
//   });

//   /// ✅ **Initial factory constructor**
//   factory HomeState.initial() {
//     return const HomeState(
//       taggedItems: {}, // ✅ Initialize as empty map
//       isLoading: false,
//       errorMessage: null,
//       selectedIndex: 0,
//       views: [], // No views yet; we'll initialize them via an event
//     );
//   }

//   /// ✅ **Copy with optional overrides**
//   HomeState copyWith({
//     Map<String, List<HomeEntity>>? taggedItems,
//     bool? isLoading,
//     String? errorMessage,
//     int? selectedIndex,
//     List<Widget>? views,
//   }) {
//     return HomeState(
//       taggedItems: taggedItems ?? this.taggedItems,
//       isLoading: isLoading ?? this.isLoading,
//       errorMessage: errorMessage,
//       selectedIndex: selectedIndex ?? this.selectedIndex,
//       views: views ?? this.views,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         taggedItems,
//         isLoading,
//         errorMessage,
//         selectedIndex,
//         views,
//       ];
// }
part of 'home_bloc.dart';

class HomeState extends Equatable {
  final Map<String, List<HomeEntity>> taggedItems; // ✅ Store items by tag
  final bool isLoading;
  final String? errorMessage;
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.taggedItems,
    required this.isLoading,
    this.errorMessage,
    required this.selectedIndex,
    required this.views,
  });

  /// ✅ Initial state factory constructor
  factory HomeState.initial() {
    return const HomeState(
      taggedItems: {}, // ✅ Initialize as empty map
      isLoading: false,
      errorMessage: null,
      selectedIndex: 0,
      views: [], // No views yet; initialized via an event
    );
  }

  /// ✅ Copy with method
  HomeState copyWith({
    Map<String, List<HomeEntity>>? taggedItems,
    bool? isLoading,
    String? errorMessage,
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return HomeState(
      taggedItems: taggedItems ?? this.taggedItems,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [
        taggedItems,
        isLoading,
        errorMessage,
        selectedIndex,
        views,
      ];
}
// part of 'home_bloc.dart';

// class HomeState extends Equatable {
//   final bool isLoading;
//   final Map<String, List<HomeEntity>> taggedItems;
//   final List<Widget> views;
//   final String? errorMessage;
//   final int selectedIndex;
//   final HomeEntity? selectedItem; // New field

//   const HomeState({
//     required this.isLoading,
//     required this.taggedItems,
//     required this.views,
//     required this.errorMessage,
//     required this.selectedIndex,
//     this.selectedItem, // Initialize the selected item to null
//   });

//   factory HomeState.initial() {
//     return const HomeState(
//       isLoading: false,
//       taggedItems: {},
//       views: [],
//       errorMessage: null,
//       selectedIndex: 0,
//       selectedItem: null, // Initialize as null
//     );
//   }

//   HomeState copyWith({
//     bool? isLoading,
//     Map<String, List<HomeEntity>>? taggedItems,
//     List<Widget>? views,
//     String? errorMessage,
//     int? selectedIndex,
//     HomeEntity? selectedItem, // New field to copy
//   }) {
//     return HomeState(
//       isLoading: isLoading ?? this.isLoading,
//       taggedItems: taggedItems ?? this.taggedItems,
//       views: views ?? this.views,
//       errorMessage: errorMessage ?? this.errorMessage,
//       selectedIndex: selectedIndex ?? this.selectedIndex,
//       selectedItem: selectedItem ?? this.selectedItem, // Update if needed
//     );
//   }

//   @override
//   List<Object?> get props => [
//     isLoading,
//     taggedItems,
//     views,
//     errorMessage,
//     selectedIndex,
//     selectedItem, // Include selectedItem for equality comparison
//   ];
// }
