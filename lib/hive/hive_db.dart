import 'package:hive/hive.dart';

class SaveLocally {
  Future<Box> openBox() async {
    Box box = await Hive.openBox('user');
    return box;
  }

  Future savetoken(String token) async {
    try {
      var box = await openBox();

      await box.clear();

      await box.put("token", token);
      print('I am inside hive savetoken');

      print(box.values.toString() + 'whats in hive box');
      return true;
    } catch (e) {
      return false;
    }
  }
}
// catToken = eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjdXN0SUQiOiI2MWM5ZjhlZDUwOTdlMWQwZDM3ZmJkYTgiLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE2NDQzMTM1NDAsImV4cCI6MTY0NDM5OTk0MH0.ycrajzY3LW5OeWeFB8PFhvzpCN01KZbAtLd7lLw9Es4

// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjdXN0SUQiOiI2MWQyZjk3MjE2N2NmYTVkZmNjN2M2NzgiLCJyb2xlIjoidXNlciIsImlhdCI6MTY0NDMxNTgyOH0.5cZ8ID91RThukdnDNrTQBco88Bqh4BJ4mds7y_UouRU