import '../core/app_export.dart';
import 'pref_utils.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
  }
}
