class ApiUrl{
  static const String baseUrl = 'http://c8f2-103-163-182-179.ngrok.io';
  static const String signup = '/signup';
  static const String singin = '/signin';
  static const String userUpdate = '/customer/profile/update';
  static const String userView = '/customer/viewprofile';
  static const String categoryView = '/getcategory';
  static const String allcategoryViewWithProduct = '/admin/show/all/product_with_category';
  static const String categoryItemsBySlug = '/all_category/with_product/';
  static const String addToCart = "/customer/cart/addtocart";
  static const String viewCart = '/customer/cart/all';
  static const String saveAddress = "/customer/address/create";
  static const String getOrderdetails = '/customer/get/orders';
  static const String saveOrderInfo = '/addOrder';
  static const String addReview = '/product/add/review/';
  static const String showReview = '/user/show/review/';
  static const String searchProduct = '/search/';
  static const String adminGetOrderStatus = '/admin/get/orderStatus/';
  static const String adminChangeOrderStatus = '/admin/order/change/status/';
  static const String deleteCart = '/customer/cart/delete';

}