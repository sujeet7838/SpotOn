import 'package:get/get.dart';

class PartyController extends GetxController {
  RxInt index = 0.obs;

  void changeIndex(int newIndex) {
    index.value = newIndex;
  }
}