import 'package:flutter/material.dart';
import 'package:ppue/models/PP.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPPNotifier extends ChangeNotifier {
  PPModel? _data;
  GlobalKey<FormState>? _formIdentificacao;
  PPModel? get data => _data;
  GlobalKey<FormState>? get formIdentificacao => _formIdentificacao;

  void setFormIdentificacao(GlobalKey<FormState> form) {
    _formIdentificacao = form;
  }

  void setData(PPModel data) {
    this._data = data;

    notifyListeners();
  }

  void clearData() {
    this._data = null;

    notifyListeners();
  }
}
