import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String _name = '';
  String _token = '';
  int _type = 0;

  String get name => _name;
  String get token => _token;
  int get type => _type;
  bool get isLogged => _token.isNotEmpty;
  bool get isMovel => _type == 1;
  bool get isHospital => _type == 2;

  void setUser(String name, String token) {
    _name = name;
    _token = token;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('name', name);
      prefs.setString('token', token);
    });

    notifyListeners();
  }

  void setType(int type) {
    _type = type;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('type', type);
    });

    notifyListeners();
  }

  void loadUser() {
    // Carrega as informações do usuário usando shared_preferences ou flutter_secure_storage
    // Exemplo usando shared_preferences:
    SharedPreferences.getInstance().then((prefs) {
      _name = prefs.getString('name') ?? '';
      _token = prefs.getString('token') ?? '';
      _type = prefs.getInt('type') ?? 0;

      notifyListeners();
    });
  }

  void logout() {
    _name = '';
    _token = '';
    _type = 0;

    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('name');
      prefs.remove('token');
      prefs.remove('type');
    });

    notifyListeners();
  }
}
