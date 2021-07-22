import 'dart:io';
import 'package:grant_and_activate/utils/Service.dart';
import 'package:grant_and_activate/utils/toast_messages.dart';
import 'package:permission_handler/permission_handler.dart';


///
/// Checks both Bluetooth and locations permissions; if a permission is missing,
/// asks user for it.
///
/// Returns false if at least one permission has been denied, true otherwise.
///
/// If the user refused location permission too many times, redirects to the
/// application settings screen.
///
Future<bool> checkPermissions(
  List<Service> services
) async {

  if (services.contains(Service.Bluetooth)) {
    var status = await Permission.bluetooth.status;
    if (!status.isGranted) {
      var result = await Permission.bluetooth.request();
      if (!result.isGranted) {
        return false;
      }
    }
  }

  if (services.contains(Service.Location)) {
    var locationStatus = await Permission.locationWhenInUse.status;
    if (!locationStatus.isGranted) {
      var result = await Permission.locationWhenInUse.request();
      if (!result.isGranted) {
        showLocationPermissionMissingToast();
        sleep(new Duration(seconds: 2));

        if (!await Permission.locationWhenInUse.shouldShowRequestRationale) {
          openAppSettings();
        }

        return false;
      }
    }
  }

  return true;
}