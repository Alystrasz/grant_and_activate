import 'package:grant_and_activate/utils/classes.dart';
import 'package:permission_handler/permission_handler.dart';


///
/// Checks permissions; if a permission is missing, asks user for it.
///
/// Returns false if permission has been denied, true otherwise.
///
/// If the user refused location permission too many times, redirects to the
/// application settings screen.
///
Future<bool> checkPermissions(
  Feature service
) async {

  switch (service) {
    case Feature.Bluetooth:
      var status = await Permission.bluetooth.status;
      if (!status.isGranted) {
        var result = await Permission.bluetooth.request();
        if (!result.isGranted) {
          return false;
        }
      }
      break;

    case Feature.Location:
      var locationStatus = await Permission.locationWhenInUse.status;
      if (!locationStatus.isGranted) {
        var result = await Permission.locationWhenInUse.request();
        if (!result.isGranted) {

          if (!await Permission.locationWhenInUse.shouldShowRequestRationale) {
            openAppSettings();
          }

          return false;
        }
      }
      break;

    default:
      throw new UnimplementedError("Cannot check permissions with this service.");
  }

  return true;
}