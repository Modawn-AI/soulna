import 'package:Soulna/controller/auth_controller.dart';
import 'package:get/get.dart';

class MasterBindings extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<AuthController>(() => AuthController());
}