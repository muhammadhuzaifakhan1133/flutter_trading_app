import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:trading_app/models/trading_model.dart';

class TradingServices {
  Future<List<Trading>> getTradingServices() async {
    var file = await rootBundle.loadString('lib/services/response.json');   
    var response = json.decode(file);
    List<Trading> tradings = [];
    for (var td in response) {
      tradings.add(Trading.fromJson(td));
    }
    return tradings;
  }
}