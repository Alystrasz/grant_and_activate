library grant_and_activate;

import 'package:grant_and_activate/utils/activate_services.dart';
import 'package:grant_and_activate/utils/check_permissions.dart';


///
/// Checks Bluetooth and geolocation permissions, and enables associated
/// services; returns false if a permission has not been granted or a service
/// did not start, true otherwise.
///
/// This is the only endpoint available of this package.
///
Future<bool> checkPermissionsAndActivateServices() async {
  return await checkPermissions() && await activateServices();
}