import 'package:get/get.dart';

class Trading {
  int? id;
  String? name;
  String? displayName;
  int? digits;
  String? category;
  List<dynamic>? alliases;
  Map? latestAllias;
  RxBool isChecked = false.obs;

  Trading(
      {this.id,
      this.name,
      this.displayName,
      this.digits,
      this.category,
      this.alliases,
      this.latestAllias});

  Trading.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['displayName'];
    digits = json['digits'];
    category = json['category'];
    if (json['alliases'] != null) {
      alliases = [];
      json['alliases'].forEach((v) {
        alliases!.add(v);
      });
    }
    latestAllias = json['latestAllias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['displayName'] = displayName;
    data['digits'] = digits;
    data['category'] = category;
    if (alliases != null) {
      data['alliases'] = alliases!.map((v) => v.toJson()).toList();
    }
    data['latestAllias'] = latestAllias;
    return data;
  }
}
