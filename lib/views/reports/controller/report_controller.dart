import 'package:get/get.dart';

class ReportController extends GetxController {
  bool isForward = false;

  changeIsForward() {
    isForward = !isForward;
    update();
  }
}
