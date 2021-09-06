import 'package:bluetooth_enable/bluetooth_enable.dart';
import 'package:grant_and_activate/utils/classes.dart';
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
Future<bool> activateServices(
  List<Service> services
) async {

  var bluetoothResult = services.contains(Service.Bluetooth)
      ? await BluetoothEnable.enableBluetooth == "true"
      : true;

  Location location = new Location();
  var locationResult = true;
  var locationServiceResult = services.contains(Service.Location)
      ? await location.serviceEnabled()
      : true;

  if (!locationServiceResult) {
    locationResult = await location.requestService();
  }

  return bluetoothResult && locationResult;
}