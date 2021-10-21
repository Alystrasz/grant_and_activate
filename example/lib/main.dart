import 'package:flutter/material.dart';
import 'package:grant_and_activate/grant_and_activate.dart';
import 'package:grant_and_activate/utils/classes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool bluetoothFeature = false;
  bool bluetoothScanFeature = false;
  bool bluetoothConnectFeature = false;
  bool locationFeature = false;
  String resultText = 'Method call result will be displayed here.';

  void _switchBluetoothFeatureState(bool nValue) {
    setState(() {
      bluetoothFeature = nValue;
    });
  }

  void _switchBluetoothScanFeatureState(bool nValue) {
    setState(() {
      bluetoothScanFeature = nValue;
    });
  }

  void _switchBluetoothConnectFeatureState(bool nValue) {
    setState(() {
      bluetoothConnectFeature = nValue;
    });
  }

  void _switchLocationFeatureState(bool nValue) {
    setState(() {
      locationFeature = nValue;
    });
  }

  bool _isAtLeastOneFeatureSelected() {
    return bluetoothFeature || locationFeature || bluetoothScanFeature || bluetoothConnectFeature;
  }

  void _grantAndActivateFeatures() async {
    List<Feature> features = [];
    if (bluetoothFeature) {
      features.add(Feature.Bluetooth);
    }
    if (locationFeature) {
      features.add(Feature.LocationWhenInUse);
    }
    if (bluetoothScanFeature) {
      features.add(Feature.BluetoothScan);
    }
    if (bluetoothConnectFeature) {
      features.add(Feature.BluetoothConnect);
    }

    Result result = await checkPermissionsAndActivateServices(features);
    setState(() {
      resultText = result.toString();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grant and activate example app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const Text(
                'Select features you want to activate:',
              ),
            ),
            ListTile(
              title: const Text('Bluetooth'),
              onTap: () => _switchBluetoothFeatureState(!bluetoothFeature),
              trailing: Checkbox(value: bluetoothFeature, onChanged: _switchBluetoothFeatureState),
            ),
            ListTile(
              title: const Text('Bluetooth.Connect (Android 12)'),
              onTap: () => _switchBluetoothConnectFeatureState(!bluetoothConnectFeature),
              trailing: Checkbox(value: bluetoothConnectFeature, onChanged: _switchBluetoothConnectFeatureState),
            ),
            ListTile(
              title: const Text('Bluetooth.Scan (Android 12)'),
              onTap: () => _switchBluetoothScanFeatureState(!bluetoothScanFeature),
              trailing: Checkbox(value: bluetoothScanFeature, onChanged: _switchBluetoothScanFeatureState),
            ),
            ListTile(
              title: const Text('Location'),
              onTap: () => _switchLocationFeatureState(!locationFeature),
              trailing: Checkbox(value: locationFeature, onChanged: _switchLocationFeatureState),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                  child: const Text("Grant and activate selected features"),
                  onPressed: _isAtLeastOneFeatureSelected() ? _grantAndActivateFeatures : null
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 80),
              color: const Color.fromRGBO(10, 10, 10, 0.1),
              padding: const EdgeInsets.all(20),
              child: Text(resultText),
            )
          ],
        ),
      )
    );
  }
}
