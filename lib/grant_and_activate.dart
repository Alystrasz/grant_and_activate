library grant_and_activate;

import 'package:grant_and_activate/utils/classes.dart';
import 'package:grant_and_activate/utils/activate_service.dart';
import 'package:grant_and_activate/utils/check_permissions.dart';


///
/// Checks permissions, and enables associated services.
/// This is the only endpoint available of this package.
///
Future<Result> checkPermissionsAndActivateServices(
  List<Feature> features
) async {
  if (features.length == 0) throw ArgumentError('No input features provided.');

  Map<Feature, bool> results = Map();
  if (features.contains(Feature.Bluetooth)) {
    bool bluetoothResult = await checkPermissions(Feature.Bluetooth) && await activateService(Feature.Bluetooth);
    results.putIfAbsent(Feature.Bluetooth, () => bluetoothResult);
  }
  if (features.contains(Feature.LocationWhenInUse)) {
    bool locationResult = await checkPermissions(Feature.LocationWhenInUse) && await activateService(Feature.LocationWhenInUse);
    results.putIfAbsent(Feature.LocationWhenInUse, () => locationResult);
  }

  return Result(results, allOk: !results.values.contains(false));
}