# grant_and_activate

This package is a plugin for Flutter, to programmatically request permission for a given feature, 
plus activation of the related service.

This plugin does not display any message, it is up to developers to display permissions/services
status to the user.

This plugin is intended to be supported on Android and iOS, but has been tested on Android only.

## Usage

```dart
Result result = checkPermissionsAndActivateServices([Service.Bluetooth, Service.Location]);
if (result.allOk) {
  // Permissions have been granted and services are currently active
} else {
  // Permissions have not been granted and/or services are not active
  if (!result.getStatus(Service.Bluetooth))
    print("This application requires you to activate Bluetooth.");
}
```

## Supported features

* Bluetooth
* geolocation