import 'package:bluetooth_enable/bluetooth_enable.dart';
import 'package:grant_and_activate/utils/toast_messages.dart';
import 'package:location/location.dart';


///
/// Activates Bluetooth and geolocation services, for the location gathering
/// process to work properly.
///
/// For each service, a modal popup will appear and ask the user to activate
/// such service if it's not running; a warning toast message will appear,
/// shall the user not activate it.
///
/// Returns true if both services have been activated, false otherwise.
///
Future<bool> activateServices() async {
  var bluetoothResult = await BluetoothEnable.enableBluetooth == "true";

  if (!bluetoothResult) {
    showBluetoothServiceNeedsActivationToast();
  }

  Location location = new Location();
  var locationResult = true;
  var locationServiceResult = await location.serviceEnabled();
  if (!locationServiceResult) {
    locationResult = await location.requestService();
    if (!locationResult) {
      showLocationServiceNeedsActivationToast();
    }
  }

  return bluetoothResult && locationResult;
}