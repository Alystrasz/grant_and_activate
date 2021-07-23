library grant_and_activate;

import 'package:grant_and_activate/utils/Service.dart';
import 'package:grant_and_activate/utils/activate_services.dart';
import 'package:grant_and_activate/utils/check_permissions.dart';


///
/// Checks Bluetooth and geolocation permissions, and enables associated
/// services; returns false if a permission has not been granted or a service
/// did not start, true otherwise.
///
/// This is the only endpoint available of this package.
///
Future<bool> checkPermissionsAndActivateServices(
  List<Service> services
) async {
  if (services.length == 0) throw ArgumentError('No input services provided.');
  return await checkPermissions(services) && await activateServices(services);
}