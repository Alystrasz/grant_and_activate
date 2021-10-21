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
  for (var feature in features) {
    bool result = await checkPermissions(feature) && await activateService(feature);
    results.putIfAbsent(feature, () => result);
  }

  return Result(results, allOk: !results.values.contains(false));
}