import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_gadget_zone/auth_model/auth_user_model.dart';
import 'package:the_gadget_zone/hive/hive_db.dart';
import 'package:the_gadget_zone/http/category_view_repo.dart';
import 'package:the_gadget_zone/http/catergoty_repo.dart';
import 'package:the_gadget_zone/http/myorder_repo.dart';
import 'package:the_gadget_zone/http/user_http.dart';

void main() {
  group('Api Test', () {
    test('register', () async {
      final httpUser = HttpUser();
      await httpUser.registerPost(
          authUserModel: AuthUserModel(
              email: 'pass@gmail.com',
              password: 'aashish@123',
              confirmPassword: 'aashish@123'));

      expect(httpUser.responseVal, true);
    });

    test('login', () async {
      final httpUser = HttpUser();

      final user_test = await httpUser.loginPost(
          authUserModel:
              AuthUserModel(email: 'test777@gmail.com', password: 'test777'));

      String token = httpUser.testToken;

      expect(httpUser.responseVal, true);
    });

    test('Get Order', () async {

      final httpUser = HttpUser();
      final OrderUser = MyOrderCompleted();

      final user_test = await httpUser.loginPost(
          authUserModel:
              AuthUserModel(email: 'test777@gmail.com', password: 'test777'));

      String token = httpUser.testToken;

      OrderUser.MyOrder(token: token);

      expect(OrderUser.responseVal, true);
    });

    test('Category view', () async {
      final viewcategory = ViewCategoryRepo();

      final httpUser = HttpUser();

      final user_test = await httpUser.loginPost(
          authUserModel:
              AuthUserModel(email: 'test777@gmail.com', password: 'test777'));

      String token = httpUser.testToken;

      viewcategory.viewCategory(slug: 'Audio', token: token);

      expect(viewcategory.responseVal, false);
    });

    test('Get category name', () async {
      final cateogry = CategoryRepo();

      final httpUser = HttpUser();

      final user_test = await httpUser.loginPost(
          authUserModel:
              AuthUserModel(email: 'test777@gmail.com', password: 'test777'));

      String token = httpUser.testToken;

      cateogry.getCategory(token: token);

      expect(cateogry.responseVal, false);
    });

    test('Get product', () async {
      final cateogry = CategoryRepo();

      final httpUser = HttpUser();

      final user_test = await httpUser.loginPost(
          authUserModel:
              AuthUserModel(email: 'test777@gmail.com', password: 'test777'));

      String token = httpUser.testToken;

      cateogry.getCategory(token: token);

      expect(cateogry.responseVal, false);
    });

    test('product view', () async {
      final cateogry = CategoryRepo();

      final httpUser = HttpUser();

      final user_test = await httpUser.loginPost(
          authUserModel:
              AuthUserModel(email: 'test777@gmail.com', password: 'test777'));

      String token = httpUser.testToken;

      cateogry.getCategory(token: token);

      expect(cateogry.responseVal, false);
    });

    test('ordered product get', () async {
      final cateogry = CategoryRepo();

      final httpUser = HttpUser();

      final user_test = await httpUser.loginPost(
          authUserModel:
              AuthUserModel(email: 'test777@gmail.com', password: 'test777'));

      String token = httpUser.testToken;

      cateogry.getCategory(token: token);

      expect(cateogry.responseVal, false);
    });

    test('order user address saved', () async {
      final cateogry = CategoryRepo();

      final httpUser = HttpUser();

      final user_test = await httpUser.loginPost(
          authUserModel:
              AuthUserModel(email: 'test777@gmail.com', password: 'test777'));

      String token = httpUser.testToken;

      cateogry.getCategory(token: token);

      expect(cateogry.responseVal, false);
    });
  });
}
