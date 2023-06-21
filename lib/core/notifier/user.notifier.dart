import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNotifier extends ChangeNotifier {
  int _type = 0;

  int get type => _type;
  bool get isMovel => _type == 1;
  bool get isHospital => _type == 2;

  void setType(int type) {
    _type = type;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('type', type);
    });

    notifyListeners();
  }

  void loadUser() {
    SharedPreferences.getInstance().then((prefs) {
      _type = prefs.getInt('type') ?? 0;

      notifyListeners();
    });
  }
}
