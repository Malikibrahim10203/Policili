import 'package:get/get.dart';

class RemembermeController extends GetxController {
  RxBool isChecked = false.obs;

  void changeValue(bool? newValue) {
    isChecked.value = newValue ?? false;
  }
}