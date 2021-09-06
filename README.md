# grant_and_activate

This package is a plugin for Flutter, to programmatically request permission for a given feature, 
plus activation of the related service.

This plugin is intended to be supported on Android and iOS, but has been tested on Android only.

## Usage

```dart
bool result = checkPermissionsAndActivateServices(Service.Bluetooth);
if (result) {
  // Bluetooth permission has been granted and service is currently active
} else {
  // Permission has not been granted or service is not active
}
```

## Supported features

* Bluetooth
* geolocation