class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3000/api/v1/";
  // For iPhone
  //static const String baseUrl = "http://localhost:3000/api/v1/";

  // ====================== Auth Routes ======================
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  static const String uploadImage = "auth/uploadImage";
  static const String getItemById = "item/getItem/:id";
  static const String getCartItemsByUserId = '/cart/items';
  static const String deleteCartItem = '/cart/item';
  static const String getWishlistItemsByUserId = '/wishlist/items';
  static const String deleteWishlistItem = '/cart/item';
  static const String getAllCategories = "category/getCategories";
  static const String getItemsByTag = "${baseUrl}item/getItemsByTag";
  static const String order = '/order/';
  static const String getOrder = '/order/';
  static const String getCustomer = '/auth/getCustomer/';
  static const String updateCustomer = '/auth/updateCustomer/';
}
