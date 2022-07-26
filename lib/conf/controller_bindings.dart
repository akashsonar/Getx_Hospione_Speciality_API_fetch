import 'package:get/instance_manager.dart';
import 'package:getx_jsonplaceholder/controller/api_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiController());
  }
}
