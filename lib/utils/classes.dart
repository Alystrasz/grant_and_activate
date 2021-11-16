import 'package:flutter/cupertino.dart';

enum Feature {
  Bluetooth,
  BluetoothConnect,
  BluetoothScan,
  LocationAlways,
  LocationWhenInUse,
}

class Result {
  final bool allOk;
  final Map<Feature, bool> _results;
  Result(this._results, {@required this.allOk});

  bool getStatus (Feature feature) {
    return this._results.containsKey(feature) && this._results[feature];
  }

  String toString() {
    return '{ allOk: $allOk, results: $_results }';
  }
}