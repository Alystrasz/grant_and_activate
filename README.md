# grant_and_activate

This package is a plugin for Flutter, to programmatically request permission for a given feature, 
plus activation of the related service.

This plugin does not display any message, it is up to developers to display permissions/services
status to the user.

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