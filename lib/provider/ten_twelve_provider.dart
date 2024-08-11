import 'package:flutter/material.dart';
import 'package:Soulna/models/ten_twelve_model.dart';

class TenTwelveProvider extends ChangeNotifier {
  TenTwelveModel? _tenTwelveModel;

  TenTwelveModel? get tenTwelveModel => _tenTwelveModel;

  void setTenTwelveModel(TenTwelveModel model) {
    _tenTwelveModel = model;
    notifyListeners();
  }
}
