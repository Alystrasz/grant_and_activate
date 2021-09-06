import 'package:flutter/cupertino.dart';

enum Service {
  Bluetooth,
  Location
}

class Result {
  final bool allOk;
  final Map<Service, bool> results;
  Result({@required this.allOk, @required this.results});
}