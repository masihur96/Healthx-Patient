class APIPath {
  // static const String baseUrl = "https://api.anujprokashon.com/api";
  static const String baseUrl = " https://hx-dev-api.healthxbd.com/api/v1";

  static String register = "$baseUrl/patients/signup/";

  static String registerWithGoogle = "$baseUrl/auth/google/callback";
  static String login = "$baseUrl/login";
  static String forgotPassword = "$baseUrl/auth/forgot-password/email";
  static String resetPassword = "$baseUrl/auth/reset-password/email";
  static String changePassword = "$baseUrl/auth/change-password/email";

  static String loginWithGoogle = "$baseUrl/auth/google/mobile";
  static String home = "$baseUrl/home";
  static String myProfile = "$baseUrl/auth";
  static String avatarProfile = "$baseUrl/my-profile/update-avatar";
  static String categories = "$baseUrl/all-genres";
  static String authors = "$baseUrl/all-authors";
  static String books = "$baseUrl/all-books";
  static String searchBooks = "$baseUrl/global-search";
  static String bookContent = "$baseUrl/all-books/preview/";
  static String story = "$baseUrl/all-books/story";
  static String topPaidBooks = "$baseUrl/top-paid-books";
  static String bookReviews = "$baseUrl/reviews";
  static String bookSubmitReviews = "$baseUrl/my-reviews";
  static String myWishlist = "$baseUrl/my-wishlist";
  static String bookSubmitCheckout = "$baseUrl/checkout";
  static String myOrders = "$baseUrl/my-orders";
  static String countries = "$baseUrl/all-country";
  static String divisions = "$baseUrl/all-division/";
  static String shippingCharges = "$baseUrl/shipping-charges";
  static String myOrderItems = "$baseUrl/my-order-items";
}
