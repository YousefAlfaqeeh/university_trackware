import 'package:location/location.dart';
class LoctionService
{

  Future<LocationData?> currentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    Location location = new Location();
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    print(serviceEnabled);
    if (!serviceEnabled) {
      print("ffffffffffggg");
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception();
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception();
      }
    }
    locationData=await location.getLocation();
    print(locationData);
    return locationData;
  }


}