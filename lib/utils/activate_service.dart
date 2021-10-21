import 'dart:io';

import 'package:bluetooth_enable/bluetooth_enable.dart';
import 'package:grant_and_activate/utils/classes.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';


///
/// Activates services.
///
/// For each service, a modal popup will appear and ask the user to activate
/// such service if it's not running; a warning toast message will appear,
/// shall the user not activate it.
///
/// Returns true if service has been activated, false otherwise.
///
Future<bool> activateService(
  Feature feature
) async {

  switch (feature) {

    case Feature.BluetoothConnect:
    case Feature.BluetoothScan:
    case Feature.Bluetooth:
      return await BluetoothEnable.enableBluetooth == "true";

    case Feature.LocationWhenInUse:
      ServiceStatus serviceStatus = await Permission.locationWhenInUse.serviceStatus;
      if (serviceStatus.isDisabled && Platform.isIOS) {
        openAppSettings();
      }
      Location location = new Location();
      var locationResult = true;
      var locationServiceResult = await location.serviceEnabled();
      if (!locationServiceResult)
        locationResult = await location.requestService();
      return locationResult;

    default:
      throw new UnimplementedError("Cannot activate the service associated to this feature.");
  }
}