import 'package:flutter_test/flutter_test.dart';
import 'package:grant_and_activate/grant_and_activate.dart';

void main() {
  test('check does not run without input arguments', () {
    expect(() => checkPermissionsAndActivateServices([]), throwsArgumentError);
  });
}
