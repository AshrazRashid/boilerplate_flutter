import 'package:permission_handler/permission_handler.dart';
import 'package:society_management/utils/snackbar_util.dart';

class PermissionService {
  static PermissionService? _instance;
  // Getter to return the instance, creating it if necessary
  static PermissionService get instance {
    _instance ??= PermissionService._internal();
    return _instance!;
  }

  // Private named constructor
  PermissionService._internal();

  // Public factory constructor
  factory PermissionService() {
    return instance;
  }

  Future<bool> askContactPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      _handleInvalidPermissions(
          permissionStatus, "Access to contact data is required");
      return false;
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(
      PermissionStatus permissionStatus, String message) {
    if (permissionStatus == PermissionStatus.denied) {
      SnackbarUtil.error(message: message);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      SnackbarUtil.error(message: "Can not get permission");
    }
  }
}
