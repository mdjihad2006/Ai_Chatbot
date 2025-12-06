import 'package:get/get.dart';

import '../controllers/about_secession_controller.dart';

class AboutSecessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutSecessionController>(
      () => AboutSecessionController(),
    );
  }
}
