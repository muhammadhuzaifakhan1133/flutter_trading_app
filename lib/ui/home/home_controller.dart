import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trading_app/models/trading_model.dart';
import 'package:trading_app/services/trading_services.dart';
import 'package:trading_app/utils/color_constants.dart';

class HomeController extends GetxController {
  TradingServices tradingServices = TradingServices();
  Map<String, List<Trading>> tradingMap = {};
  RxBool isLoading = true.obs;
  List<Category> categories = [];
  List<ExpansionTile> expansionTiles = [];

  @override
  void onInit() {
    super.onInit();
    mapTradings();
  }

  mapTradings() async {
    List<Trading> tradings = await tradingServices.getTradingServices();

    // bring all same category tradings together
    for (var td in tradings) {
      tradingMap.putIfAbsent(td.category!, () => []);
      tradingMap[td.category!]!.add(td);
    }

    // sort tradingMap by keys
    tradingMap = Map.fromEntries(tradingMap.entries.toList()
      ..sort((e1, e2) => e1.key.compareTo(e2.key)));

    // create categories for tradings
    for (var key in tradingMap.keys) {
      List<String> strCategories = key.split("/");
      List<Category> tempCategories = categories;
      for (String ctg in strCategories) {
        if (tempCategories.isEmpty) {
          tempCategories.add(Category(name: ctg));
          tempCategories = tempCategories.last.categories;
        } else {
          bool isExist = false;
          int i = 0;
          for (i = 0; i < tempCategories.length; i++) {
            Category category = tempCategories[i];
            if (category.name == ctg) {
              isExist = true;
              break;
            }
          }
          if (!isExist) {
            tempCategories.add(Category(name: ctg));
            tempCategories = tempCategories.last.categories;
          } else {
            tempCategories = tempCategories[i].categories;
          }
        }
      }
    }

    // now add trading to categories
    for (var key in tradingMap.keys) {
      List<String> strCategories = key.split("/");
      List<Category> tempCategories = categories;
      Category? category;
      for (String ctg in strCategories) {
        bool isExist = false;
        int i = 0;
        for (i = 0; i < tempCategories.length; i++) {
          category = tempCategories[i];
          if (category.name == ctg) {
            isExist = true;
            break;
          }
        }
        if (isExist) {
          tempCategories = tempCategories[i].categories;
        }
      }
      category!.tradings = tradingMap[key]!;
    }

    // create expansion tiles
    for (Category category in categories) {
      expansionTiles.add(createExpansionTiles(category));
    }

    isLoading.value = false;
  }

  createExpansionTiles(Category category) {
    if (category.categories.isEmpty) {
      return ExpansionTile(
        title: Text(category.name!),
        onExpansionChanged: (value) {
          category.isExpand.value = value;
        },
        leading: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Obx(
                () => category.isExpand.value
                    ? const Icon(Icons.arrow_drop_up)
                    : const Icon(Icons.arrow_drop_down),
              ),
              const SizedBox(
                width: 10.0,
              ),
              CircleAvatar(
                radius: 15.0,
                backgroundColor: ColorConstants.primary,
                child: Text(category.name![0]),
              )
            ],
          ),
        ),
        trailing: Obx(() {
          return Checkbox(
            value: category.isChecked.value,
            onChanged: (value) {
              category.toggleCheck();
            },
          );
        }),
        children: [
          for (Trading trading in category.tradings)
            ListTile(
              leading: Obx(() {
                return Checkbox(
                  value: trading.isChecked.value,
                  onChanged: (value) {
                    trading.isChecked.value = !(trading.isChecked.value);
                  },
                );
              }),
              title: Text(trading.name!),
            )
        ],
      );
    } else {
      return ExpansionTile(
        title: Text(category.name!),
        onExpansionChanged: (value) {
          category.isExpand.value = value;
        },
        leading: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Obx(
                () => category.isExpand.value
                    ? const Icon(Icons.arrow_drop_up)
                    : const Icon(Icons.arrow_drop_down),
              ),
              const SizedBox(
                width: 10.0,
              ),
              CircleAvatar(
                radius: 15.0,
                backgroundColor: ColorConstants.primary,
                child: Text(category.name![0]),
              )
            ],
          ),
        ),
        trailing: Obx(() {
          return Checkbox(
            value: category.isChecked.value,
            onChanged: (value) {
              category.toggleCheck();
            },
          );
        }),
        children: [
          for (Category ctg in category.categories) createExpansionTiles(ctg)
        ],
      );
    }
  }
}

class Category {
  String? name;
  List<Category> categories = [];
  List<Trading> tradings = [];
  RxBool isExpand = false.obs;
  RxBool isChecked = false.obs;
  Category({required this.name, tradings, categories}) {
    this.tradings = tradings ?? [];
    this.categories = categories ?? [];
  }

  toggleCheck() {
    isChecked.value = !(isChecked.value);
    for (Trading tr in tradings) {
      tr.isChecked.value = !(tr.isChecked.value);
    }
    for (Category ctg in categories) {
      ctg.toggleCheck();
    }
  }
}
