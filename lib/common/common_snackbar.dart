import 'package:get/get.dart';
import 'package:wikitrack/utils/AppColors.dart';

SnackbarController commonSnackBar({String? message}) {
  return Get.snackbar("Wikitrack", message!,
      backgroundColor: AppColors.primaryColor,
      colorText: AppColors.whiteColor,
      snackPosition: SnackPosition.BOTTOM);
}
