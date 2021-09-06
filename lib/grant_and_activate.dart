library grant_and_activate;

import 'dart:developer';

import 'package:grant_and_activate/utils/classes.dart';
import 'package:grant_and_activate/utils/activate_service.dart';
import 'package:grant_and_activate/utils/check_permissions.dart';


///
/// Checks Bluetooth and geolocation permissions, and enables associated
/// services; returns false if a permission has not been granted or a service
/// did not start, true otherwise.
///
/// This is the only endpoint available of this package.
///
Future<Result> checkPermissionsAndActivateServices(
  List<Service> services
) async {
  if (services.length == 0) throw ArgumentError('No input services provided.');

  Map<Service, bool> results = Map();
  if (services.contains(Service.Bluetooth)) {
    bool bluetoothResult = await checkPermissions(Service.Bluetooth) && await activateService(Service.Bluetooth);
    results.putIfAbsent(Service.Bluetooth, () => bluetoothResult);
  }
  if (services.contains(Service.Location)) {
    bool locationResult = await checkPermissions(Service.Location) && await activateService(Service.Location);
    results.putIfAbsent(Service.Location, () => locationResult);
  }

  return Result(results, allOk: !results.values.contains(false));
}