import 'package:flutter/cupertino.dart';

enum Feature {
  Bluetooth,
  Location
}

class Result {
  final bool allOk;
  final Map<Feature, bool> _results;
  Result(this._results, {@required this.allOk});

  bool getStatus (Feature service) {
    return this._results.containsKey(service) && this._results[service];
  }
}