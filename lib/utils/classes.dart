import 'package:flutter/cupertino.dart';

enum Service {
  Bluetooth,
  Location
}

class Result {
  final bool allOk;
  final Map<Service, bool> _results;
  Result(this._results, {@required this.allOk});

  bool getStatus (Service service) {
    return this._results.containsKey(service) && this._results[service];
  }
}