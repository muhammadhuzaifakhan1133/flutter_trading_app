import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:trading_app/ui/home/home_controller.dart';
import 'package:trading_app/utils/color_constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorConstants.white,
          leading: Icon(
            Icons.menu,
            color: ColorConstants.black,
          ),
          title: Wrap(
            spacing: 10.0,
            children: [
              Icon(
                Icons.keyboard_arrow_left,
                color: ColorConstants.black,
              ),
              Icon(
                Icons.message,
                color: ColorConstants.black,
              ),
            ],
          ),
          // row in bottom
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                        border: Border.all(color: ColorConstants.primary!)),
                    child: Text("1",
                        style: TextStyle(color: ColorConstants.white!)),
                  ),
                  SizedBox(
                    width: context.width * 0.2,
                    child: Divider(
                      thickness: 1,
                      color: ColorConstants.primary,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: ColorConstants.primary!)),
                    child: Text("2",
                        style: TextStyle(color: ColorConstants.primary!)),
                  ),
                  SizedBox(
                    width: context.width * 0.2,
                    child: Divider(
                      thickness: 1,
                      color: ColorConstants.primary,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: ColorConstants.primary!)),
                    child: Text("3",
                        style: TextStyle(color: ColorConstants.primary!)),
                  ),
                  SizedBox(
                    width: context.width * 0.2,
                    child: Divider(
                      thickness: 1,
                      color: ColorConstants.primary,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: ColorConstants.primary!)),
                    child: Text("4",
                        style: TextStyle(color: ColorConstants.primary!)),
                  ),
                ],
              ),
            ),
          )),
      bottomNavigationBar: ConvexAppBar(
        activeColor: ColorConstants.primary,
        color: ColorConstants.black,
        backgroundColor: ColorConstants.white,
        items: [
          TabItem(icon: Icon(Icons.home), title: "Home"),
          TabItem(icon: Icon(Icons.menu_book_sharp), title: "Education"),
          TabItem(icon: Icon(Icons.wifi_tethering_sharp), title: "Signals"),
          TabItem(icon: Icon(Icons.menu), title: "Pr"),
          TabItem(icon: Icon(Icons.person), title: "Profile"),
        ],
      ),
      body: Obx(() {
        if (homeController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Stack(
            children: [
              Container(
                width: context.width,
                height: context.height * 0.2,
                color: ColorConstants.primary,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  "Please choose an Investment target",
                  style: TextStyle(
                      color: ColorConstants.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
              Center(
                child: Container(
                  width: context.width * 0.8,
                  height: 380,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorConstants.white,
                    border: Border.all(color: ColorConstants.primary!),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: homeController.expansionTiles.length,
                          itemBuilder: (context, index) {
                            return homeController.expansionTiles[index];
                          },
                        ),
                      ),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorConstants.primary,
                                      ),
                                      child: Text(
                                        "Next",
                                        style: TextStyle(
                                            color: ColorConstants.white,
                                            fontSize: 15),
                                      )),
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: ColorConstants.white,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
