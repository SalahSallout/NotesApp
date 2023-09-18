import 'package:get/get.dart';

class HomeController extends GetxController {
  int counter = 0;

  void increasing() {
    counter++;
    update();
  }

  void decreasing() {
    counter--;
    update();
  }

  @override
  void onInit() {
    print("init HomeController........");
    super.onInit();
  }

  @override
  void onReady() {
    print("Ready HomeController.........");
    super.onReady();
  }

  @override
  void onClose() {
    print("Close HomeController.......");
    super.onClose();
  }
}
