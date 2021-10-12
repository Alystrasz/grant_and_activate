import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool bluetoothFeature = false;
  bool locationFeature = false;

  void _switchBluetoothFeatureState(bool? nValue) {
    setState(() {
      bluetoothFeature = nValue!;
    });
  }

  void _switchLocationFeatureState(bool? nValue) {
    setState(() {
      locationFeature = nValue!;
    });
  }

  bool _isAtLeastOneFeatureSelected() {
    return bluetoothFeature || locationFeature;
  }

  void _grantAndActivateFeatures() {
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
            )
          ],
        ),
      )
    );
  }
}
