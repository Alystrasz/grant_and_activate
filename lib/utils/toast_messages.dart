import 'package:fluttertoast/fluttertoast.dart';

void showLocationPermissionMissingToast () {
  Fluttertoast.showToast(
    msg: "locationPermissionMissing",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 3
  );
}

void showLocationServiceNeedsActivationToast () {
  Fluttertoast.showToast(
    msg: "locationActivation",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 3
  );
}

void showBluetoothServiceNeedsActivationToast () {
  Fluttertoast.showToast(
    msg: "bluetoothActivation",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 3
  );
}