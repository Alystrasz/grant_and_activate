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
Future<bool> activateService(
  Service service
) async {

  switch (service) {

    case Service.Bluetooth:
      return await BluetoothEnable.enableBluetooth == "true";

    case Service.Location:
      Location location = new Location();
      var locationResult = true;
      var locationServiceResult = await location.serviceEnabled();
      if (!locationServiceResult)
        locationResult = await location.requestService();
      return locationResult;

    default:
      throw new UnimplementedError("Cannot activate this service.");
  }
}