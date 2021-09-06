library grant_and_activate;

import 'package:grant_and_activate/utils/classes.dart';
import 'package:grant_and_activate/utils/activate_service.dart';
import 'package:grant_and_activate/utils/check_permissions.dart';


///
/// Checks permissions, and enables associated services.
/// This is the only endpoint available of this package.
///
Future<Result> checkPermissionsAndActivateServices(
  List<Feature> services
) async {
  if (services.length == 0) throw ArgumentError('No input services provided.');

  Map<Feature, bool> results = Map();
  if (services.contains(Feature.Bluetooth)) {
    bool bluetoothResult = await checkPermissions(Feature.Bluetooth) && await activateService(Feature.Bluetooth);
    results.putIfAbsent(Feature.Bluetooth, () => bluetoothResult);
  }
  if (services.contains(Feature.Location)) {
    bool locationResult = await checkPermissions(Feature.Location) && await activateService(Feature.Location);
    results.putIfAbsent(Feature.Location, () => locationResult);
  }

  return Result(results, allOk: !results.values.contains(false));
}