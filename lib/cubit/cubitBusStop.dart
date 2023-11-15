import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';
import 'package:location/location.dart';
import 'package:university_trackware/cubit/cubit.dart';
import 'package:university_trackware/cubit/states.dart';
import 'package:university_trackware/dataBase/sqldb.dart';
import 'package:university_trackware/localizations.dart';
import 'package:university_trackware/models/login.dart';
import 'package:university_trackware/models/routs.dart';
import 'package:university_trackware/services/location_services.dart';
import 'package:university_trackware/shared/end_points.dart';
import 'package:sizer/sizer.dart';
import 'package:university_trackware/shared/local/cache_helper.dart';
import '../shared/network/remote/dio_helper.dart';

class AppCubitBusStop extends Cubit<AppStates> {
  AppCubitBusStop() : super(AppInitialState());

  static AppCubitBusStop get(context) => BlocProvider.of(context);
  // SqlDb sqlDb = SqlDb();

  String status = '';
  Routs? modelRouts;
  static List<StationRout> stationRout_n = [];
  List<Round>? rounds = [];
  static List<FromStations> stationRout = [];

  static List<dynamic> all_stationRout = [];
  Set<Marker> marker_ro = new Set();
  Map marker_rout = {};
  Map marker_bus = {};
  LoginM? login_info;
  String db_name = '';
  Location location = Location();
  LocationData? currentLocation1;
  static String distance = '0';
  bool flg = false;
  dynamic lat, long;
  double zoom = 14.4746;
  static List<String> continent = [];

  final Set<Marker> marker_all = new Set();

  final Set<Marker> test = new Set();

  static Set<Marker> marker = new Set();

  static Map<String, dynamic> m = {};
  Future<void> _getLocation() async {
    try {
      var _location = await location.getLocation();
      // setState(() {
      //   currentLocation = _location as LatLng;
      // });
    } catch (e) {
      print("Error: $e");
    }
  }

  static Completer<GoogleMapController> controller = Completer();
  var latlong1 = LatLng(37.42796133580664, -122.085749655962);
  List time = ['07:00', '09:00', '11:00', '12:00'];
  List<GestureDetector> list_bus = [];
  int select = -1;
  static String? selectedItem;

  static final CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(31.9977273, 35.8387416),
    zoom: 14.4746,
  );
  static LatLng currentLocation = kGooglePlex.target;

  Future<void> location11() async {
    try {
      LocationData? _myLocation = await LoctionService().currentLocation();
      _animateCamera(_myLocation!);
    }
  catch(e)
    {
      print(e);
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;

    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    print(12742 * asin(sqrt(a)) * 1000);

    return 12742 * asin(sqrt(a)) * 1000;
  }

  Future<void> _animateCamera(LocationData locationData) async {

    final GoogleMapController controller1 = await controller.future;
    final customMarkerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'images/pers.png',
    );
    //news.png
    marker.add(Marker(
        icon: customMarkerIcon,
        markerId: MarkerId("user"),
        position: LatLng(locationData.latitude!, locationData.longitude!)));
    lat = locationData.latitude;
    long = locationData.longitude;
    double l = double.parse(locationData.latitude!.toString());
    double ln = double.parse(locationData.longitude!.toString());
    latlong1 = LatLng(l, ln);

    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(locationData.latitude!, locationData.longitude!),
      zoom: zoom,
    );
    lat = locationData.longitude;
    long = locationData.longitude;
    controller1.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
    emit(AppRoutsState());
  }

  getRouts(BuildContext context) async {
    await DioHelper.postData(
            url: GetRouts, data: {}, token: CacheHelper.getBoolean(key: 'authorization'))
        .then(
      (value)
      async {
        // String sql = "DELETE FROM 'rout'";
        // await sqlDb.deleteData(sql);
        // sql = "DELETE FROM 'station'";
        // await sqlDb.deleteData(sql);
        // sql = "DELETE FROM 'round'";
        // await sqlDb.deleteData(sql);
        modelRouts = Routs.fromJson(value.data);
        stationRout = modelRouts!.fromStations!;
        for (int i = 0; i < stationRout.length; i++) {
          String? name = stationRout[i].name;
          int? rout_id = stationRout[i].id;
          stationRout_n = stationRout[i].stationRout!;
          // String sql_rout = '''
          // INSERT INTO rout(name, rout_id) VALUES
          // ('$name','$rout_id')
          // ''';
          // await sqlDb.insertData(sql_rout);
          continent.add(name!);
          List marker_route = [];
          await Future.wait(stationRout_n.map((station_rout) async {
            // Your existing code for each station Rout

            String? name_st = station_rout.name;
            String? time = station_rout.time;
            double? lat_St = station_rout.lat;
            double? long_st = station_rout.long;
            int? st_id = station_rout.id;
            rounds = station_rout.round;

            final customMarkerIcon = await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(devicePixelRatio: 4, size: Size(10, 10)),
              'images/busStop1.png',
            );
            marker_route.add(Marker(
                // onTap: () async {
                //   // List<dynamic> round = await sqlDb.readData(
                //   //     "SELECT * FROM 'round' WHERE station_id=$st_id ");
                //   //
                //   // for (int i = 0; i < round.length; i++) {
                //   //   markBuss(round[i]['bus_num'], 31.9791291, 35.9115409,
                //   //       round[i]['driver_name'], context);
                //   // }
                //   changeBus(name_st!);
                //
                //
                //   showModalBottomSheet(
                //     isScrollControlled: true,
                //     backgroundColor: Colors.white,
                //     shape: const RoundedRectangleBorder(
                //         borderRadius:
                //             BorderRadius.vertical(top: Radius.circular(20))),
                //     context: context,
                //     builder: (context) => DraggableScrollableSheet(
                //       initialChildSize: .5,
                //       minChildSize: .5,
                //       maxChildSize: .90,
                //       expand: false,
                //       builder: (context, scrollController) => Scaffold(
                //         bottomNavigationBar: BottomAppBar(
                //           shape: CircularNotchedRectangle(),
                //           notchMargin: 20,
                //           child: Container(
                //             height: 120,
                //             child: Column(
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.symmetric(
                //                       horizontal: 8.0, vertical: 20),
                //                   child: calculateDistance(
                //                               double.parse(
                //                                   lat.toString() ?? "0"),
                //                               double.parse(
                //                                   long.toString() ?? "0"),
                //                               lat_St,
                //                               long_st) <
                //                           double.parse(
                //                               AppCubit.distance.toString())
                //                       ? InkWell(
                //                           child: Container(
                //                             margin: const EdgeInsets.symmetric(
                //                                 horizontal: 30),
                //                             padding: EdgeInsets.all(4.w),
                //                             decoration: BoxDecoration(
                //                               borderRadius:
                //                                   BorderRadius.circular(5),
                //                               color: Color(0xff0243a4),
                //                             ),
                //                             alignment: Alignment.center,
                //                             child: Text(
                //                               AppLocalizations.of(context)
                //                                   .translate('waiting'),
                //                               style: TextStyle(
                //                                   color: Colors.white,
                //                                   fontSize: 18,
                //                                   fontWeight: FontWeight.bold),
                //                             ),
                //                           ),
                //                         )
                //                       : InkWell(
                //                           child: Container(
                //                             margin: const EdgeInsets.symmetric(
                //                                 horizontal: 30),
                //                             padding: EdgeInsets.all(4.w),
                //                             decoration: BoxDecoration(
                //                               borderRadius:
                //                                   BorderRadius.circular(5),
                //                               color: Color(0xff0243a4)
                //                                   .withOpacity(.2),
                //                             ),
                //                             alignment: Alignment.center,
                //                             child: Text(
                //                               AppLocalizations.of(context)
                //                                   .translate('waiting'),
                //                               style: const TextStyle(
                //                                   color: Colors.white,
                //                                   fontSize: 18,
                //                                   fontWeight: FontWeight.bold),
                //                             ),
                //                           ),
                //                         ),
                //                 ),
                //                 Padding(
                //                   padding: const EdgeInsets.symmetric(
                //                       horizontal: 20),
                //                   child: Text(
                //                     AppLocalizations.of(context)
                //                         .translate('stop'),
                //                     style: const TextStyle(
                //                         color: Color(0xff0243a4),
                //                         fontSize: 12,
                //                         fontWeight: FontWeight.bold),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //         backgroundColor: Colors.transparent,
                //         body: SingleChildScrollView(
                //             controller: scrollController,
                //             child: Column(
                //               children: [
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 Container(
                //                   alignment: Alignment.center,
                //                   child: Card(
                //                       color: Color(0xffeaeaea),
                //                       elevation: 0,
                //                       child: Container(
                //                         height: 6,
                //                         width: 50,
                //                       )),
                //                 ),
                //                 const SizedBox(
                //                   height: 10,
                //                 ),
                //                 Padding(
                //                   padding: const EdgeInsets.symmetric(
                //                       horizontal: 40),
                //                   child: Row(
                //                     children: [
                //                       Container(
                //                           width: 30,
                //                           height: 30,
                //                           color: const Color(0xff0543a4),
                //                           child: const Icon(
                //                               Icons.directions_bus,
                //                               color: Colors.white)),
                //                       const SizedBox(
                //                         width: 10,
                //                       ),
                //                       Expanded(
                //                         child: Column(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.start,
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.start,
                //                           children: [
                //                             Padding(
                //                               padding:
                //                                   const EdgeInsets.symmetric(
                //                                       horizontal: 10),
                //                               child: Text(name,
                //                                   style: const TextStyle(
                //                                       fontWeight:
                //                                           FontWeight.bold,
                //                                       color: Colors.black,
                //                                       fontSize: 17)),
                //                             ),
                //                             const SizedBox(
                //                               height: 10,
                //                             ),
                //                             Padding(
                //                               padding:
                //                                   const EdgeInsets.symmetric(
                //                                       horizontal: 10),
                //                               child: Text(selectedItem!,
                //                                   style: const TextStyle(
                //                                       fontWeight:
                //                                           FontWeight.bold,
                //                                       color: Color(0xff707070),
                //                                       fontSize: 14)),
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                       Column(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.start,
                //                         crossAxisAlignment:
                //                             CrossAxisAlignment.start,
                //                         children: [
                //                           for (int x = 0;
                //                               x <= round.length - 1;
                //                               x++)
                //                             (Text(round[x]['name'],
                //                                 style: const TextStyle(
                //                                     fontWeight: FontWeight.bold,
                //                                     color: Color(0xff707070),
                //                                     fontSize: 14)))
                //                         ],
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               ],
                //             )),
                //       ),
                //     ),
                //   );
                // },
                icon: customMarkerIcon,
                markerId: MarkerId("station " + st_id.toString()),
                position: LatLng(lat_St!, long_st!)));
          //
          //   String sql_station = '''
          // INSERT INTO station(time, name, station_id, long, lat, rout_id) VALUES
          // ('$time','$name_st',$st_id,$long_st,$lat_St,$rout_id)
          // ''';

            // await sqlDb.insertData(sql_station);

            await markSt(st_id!, lat_St, long_st, name_st!, context);

            all_stationRout.add({
              "name": name_st,
              "id": st_id,
              "lat": lat_St,
              "long": lat_St,
              "rout_id": rout_id
            });
            List markerBus = [];
               // Set<Marker> markerBus = new Set();
            await Future.wait(rounds!.map((round) async {
              // Your existing code for each Round
              String? name_round = round.name;
              String? time_rou = round.time;
              String? driver_name = 'ssssss';
              String? bus_num = '1';
          //     String sql_round = '''
          // INSERT INTO round(time, name, driver_name, bus_num, station_id) VALUES
          // ('$time_rou','$name_round','$driver_name','$bus_num',$st_id)
          // ''';

              // await sqlDb.insertData(sql_round);
              final customMarkerIcon1 = await BitmapDescriptor.fromAssetImage(
                ImageConfiguration(devicePixelRatio: 2.5),
                'images/icons8bus48.png',
              );
              markerBus.add(Marker(
                  // onTap: () async {
                  //   showModalBottomSheet(
                  //     isScrollControlled: true,
                  //     backgroundColor: Colors.white,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                  //     context: context,
                  //     builder: (context) => DraggableScrollableSheet(
                  //       initialChildSize: .5,
                  //       minChildSize: .5,
                  //       maxChildSize: .90,
                  //       expand: false,
                  //       builder: (context, scrollController) => Scaffold(
                  //         backgroundColor: Colors.transparent,
                  //         body: SingleChildScrollView(
                  //             controller: scrollController,
                  //             child: Column(
                  //               // crossAxisAlignment: CrossAxisAlignment.center,
                  //               // mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 SizedBox(
                  //                   height: 10,
                  //                 ),
                  //                 Container(
                  //                   alignment: Alignment.center,
                  //                   child: Card(
                  //                       color: Color(0xffeaeaea),
                  //                       elevation: 0,
                  //                       child: Container(
                  //                         height: 6,
                  //                         width: 50,
                  //                       )),
                  //                 ),
                  //                 SizedBox(
                  //                   height: 10,
                  //                 ),
                  //                 Padding(
                  //                   padding: const EdgeInsets.symmetric(horizontal: 40),
                  //                   child: Row(
                  //                     children: [
                  //                       Container(
                  //                           width: 30,
                  //                           height: 30,
                  //                           color: Color(0xff0543a4),
                  //                           child: Icon(Icons.person_pin_rounded,
                  //                               color: Colors.white)),
                  //                       SizedBox(
                  //                         width: 10,
                  //                       ),
                  //                       Expanded(
                  //                         child: Column(
                  //                           mainAxisAlignment: MainAxisAlignment.start,
                  //                           crossAxisAlignment: CrossAxisAlignment.start,
                  //                           children: [
                  //                             Padding(
                  //                               padding: const EdgeInsets.symmetric(
                  //                                   horizontal: 10),
                  //                               child: Container(
                  //                                 decoration: BoxDecoration(
                  //                                     color: Colors.grey,
                  //                                     borderRadius:
                  //                                     BorderRadius.circular(40)),
                  //                                 child: Text('12',
                  //                                     style: TextStyle(
                  //                                         fontWeight: FontWeight.bold,
                  //                                         color: Colors.black,
                  //                                         fontSize: 17)),
                  //                               ),
                  //                             ),
                  //                             Padding(
                  //                               padding: const EdgeInsets.symmetric(
                  //                                   horizontal: 10),
                  //                               child: Text('Driver Name',
                  //                                   style: TextStyle(
                  //                                       fontWeight: FontWeight.bold,
                  //                                       color: Colors.black,
                  //                                       fontSize: 17)),
                  //                             ),
                  //                             SizedBox(
                  //                               height: 10,
                  //                             ),
                  //                             Padding(
                  //                               padding: const EdgeInsets.symmetric(
                  //                                   horizontal: 10),
                  //                               child: Text(name,
                  //                                   style: TextStyle(
                  //                                       fontWeight: FontWeight.bold,
                  //                                       color: Color(0xff707070),
                  //                                       fontSize: 14)),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ],
                  //             )),
                  //       ),
                  //     ),
                  //   );
                  // },
                  icon: customMarkerIcon1,
                  markerId: MarkerId('Bus ' + bus_num.toString()),
                  position: LatLng(31.9791291, 35.9115409)));

            }));
            marker_bus[name_st.toString()] = markerBus;
          }));
          marker_rout[name.toString()] = marker_route;
        }
        await Future.wait(marker.map((marke) async {
          // Your existing code for each marker

          test.add(marke);
        }));

        await location11();
      },

    ).catchError((onError) async {
      status = 'error';
      print('ddddd');
      print(onError);
    });

    emit(AppRoutsState());
  }

  changeRoute(String name) async {
    zoom = 14.4746;
    marker.clear();
    selectedItem = name;
    print(selectedItem);
    for (int y = 0; y < test.length; y++) {
      marker.add(test.elementAt(y));
    }
    if (name.isNotEmpty) {
      List rout = marker_rout[name];
      for (int i = 0; i < rout.length; i++) {
        marker.add(rout[i]);
      }

      zoom = 12;
    }
    await location11();
    emit(AppRoutsState());
  }



  changeBus(String name) async {

    if (name.isNotEmpty) {
      List rout = marker_bus[name];

      for (int i = 0; i < rout.length; i++) {
        marker.add(rout[i]);
      }
      zoom = 10;
    }
    await location11();
    emit(AppRoutsState());
  }


  getRoutName() async {
    // List<dynamic> resp = await sqlDb.readData("SELECT * FROM 'rout'");
    //
    // continent = [];
    // for (int i = 0; i < resp.length; i++) {
    //   continent.add(resp[i]['name']);
    // }
    emit(AppRoutsState());
  }

  getStationName() async {
    // List<dynamic> resp = await sqlDb.readData("SELECT * FROM 'station'");

    all_stationRout = [];

    // for (int i = 0; i < resp.length; i++) {
    //   String? name_st = resp[i]['name'];
    //
    //   double? lat = resp[i]['lat'] != null ? resp[i]['lat'] : 0.0;
    //   double? long = resp[i]['long'] != null ? resp[i]['long'] : 0.0;
    //   int? st_id = resp[i]['st_id'] != null ? resp[i]['st_id'] : 0;
    //   int? rout_id = resp[i]['rout_id'] != null ? resp[i]['rout_id'] : 0;
    //
    //   all_stationRout.add({
    //     "name": name_st,
    //     "id": st_id,
    //     "lat": lat,
    //     "long": long,
    //     "rout_id": rout_id
    //   });
    // }
    emit(AppRoutsState());
  }

  markSt(int id, double lat1, double long1, String name,
      BuildContext context) async {
    final customMarkerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 4, size: Size(10, 10)),
      'images/b2.png',
    );
    //news.png
    marker.add(Marker(
        // onTap: () async {
        //   List<dynamic> round = await sqlDb
        //       .readData("SELECT * FROM 'round' WHERE station_id=$id ");
        //
        //   for (int i = 0; i < round.length; i++) {
        //     markBuss(round[i]['bus_num'], 31.9791291, 35.9115409,
        //         round[i]['driver_name'], context);
        //   }
        //
        //   showModalBottomSheet(
        //     isScrollControlled: true,
        //     backgroundColor: Colors.white,
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        //     context: context,
        //     builder: (context) => DraggableScrollableSheet(
        //       initialChildSize: .5,
        //       minChildSize: .5,
        //       maxChildSize: .90,
        //       expand: false,
        //       builder: (context, scrollController) => Scaffold(
        //         bottomNavigationBar: BottomAppBar(
        //           shape: CircularNotchedRectangle(),
        //           notchMargin: 20,
        //           child: Container(
        //             height: 120,
        //             child: Column(
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.symmetric(
        //                       horizontal: 8.0, vertical: 20),
        //                   child: calculateDistance(
        //                               double.parse(lat.toString() ?? "0"),
        //                               double.parse(long.toString() ?? "0"),
        //                               lat1,
        //                               long1) <
        //                           double.parse(AppCubit.distance.toString())
        //                       ? InkWell(
        //                           child: Container(
        //                             margin: const EdgeInsets.symmetric(
        //                                 horizontal: 30),
        //                             padding: EdgeInsets.all(4.w),
        //                             decoration: BoxDecoration(
        //                               borderRadius: BorderRadius.circular(5),
        //                               color: Color(0xff0243a4),
        //                             ),
        //                             alignment: Alignment.center,
        //                             child: Text(
        //                               AppLocalizations.of(context)
        //                                   .translate('waiting'),
        //                               style: TextStyle(
        //                                   color: Colors.white,
        //                                   fontSize: 18,
        //                                   fontWeight: FontWeight.bold),
        //                             ),
        //                           ),
        //                         )
        //                       : InkWell(
        //                           child: Container(
        //                             margin: const EdgeInsets.symmetric(
        //                                 horizontal: 30),
        //                             padding: EdgeInsets.all(4.w),
        //                             decoration: BoxDecoration(
        //                               borderRadius: BorderRadius.circular(5),
        //                               color: Color(0xff0243a4).withOpacity(.2),
        //                             ),
        //                             alignment: Alignment.center,
        //                             child: Text(
        //                               AppLocalizations.of(context)
        //                                   .translate('waiting'),
        //                               style: TextStyle(
        //                                   color: Colors.white,
        //                                   fontSize: 18,
        //                                   fontWeight: FontWeight.bold),
        //                             ),
        //                           ),
        //                         ),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal: 20),
        //                   child: Text(
        //                     AppLocalizations.of(context).translate('stop'),
        //                     style: TextStyle(
        //                         color: Color(0xff0243a4),
        //                         fontSize: 12,
        //                         fontWeight: FontWeight.bold),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //         backgroundColor: Colors.transparent,
        //         body: SingleChildScrollView(
        //             controller: scrollController,
        //             child: Column(
        //               children: [
        //                 SizedBox(
        //                   height: 10,
        //                 ),
        //                 Container(
        //                   alignment: Alignment.center,
        //                   child: Card(
        //                       color: Color(0xffeaeaea),
        //                       elevation: 0,
        //                       child: Container(
        //                         height: 6,
        //                         width: 50,
        //                       )),
        //                 ),
        //                 SizedBox(
        //                   height: 10,
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal: 40),
        //                   child: Row(
        //                     children: [
        //                       Container(
        //                           width: 30,
        //                           height: 30,
        //                           color: Color(0xff0543a4),
        //                           child: Icon(Icons.directions_bus,
        //                               color: Colors.white)),
        //                       SizedBox(
        //                         width: 10,
        //                       ),
        //                       Expanded(
        //                         child: Column(
        //                           mainAxisAlignment: MainAxisAlignment.start,
        //                           crossAxisAlignment: CrossAxisAlignment.start,
        //                           children: [
        //                             Padding(
        //                               padding: const EdgeInsets.symmetric(
        //                                   horizontal: 10),
        //                               child: Text(name,
        //                                   style: TextStyle(
        //                                       fontWeight: FontWeight.bold,
        //                                       color: Colors.black,
        //                                       fontSize: 17)),
        //                             ),
        //                             SizedBox(
        //                               height: 10,
        //                             ),
        //                             Padding(
        //                               padding: const EdgeInsets.symmetric(
        //                                   horizontal: 10),
        //                               child: Text(selectedItem!,
        //                                   style: TextStyle(
        //                                       fontWeight: FontWeight.bold,
        //                                       color: Color(0xff707070),
        //                                       fontSize: 14)),
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                       Column(
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           for (int x = 0; x <= round.length - 1; x++)
        //                             (Text(round[x]['name'],
        //                                 style: TextStyle(
        //                                     fontWeight: FontWeight.bold,
        //                                     color: Color(0xff707070),
        //                                     fontSize: 14)))
        //                         ],
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             )),
        //       ),
        //     ),
        //   );
        // },
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Container(
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.height / 10,
                  alignment: Alignment.topCenter,
                  child: Text('title')),
              content: Container(
                child: Text('massage'),
              ),
              actions: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(40)),
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        AppLocalizations.of(context).translate('ok').toString(),
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );

        },
        icon: customMarkerIcon,
        markerId: MarkerId("station " + id.toString()),
        position: LatLng(lat1, long1)));
    marker_all.add(Marker(
        // onTap: () async {
        //   List<dynamic> round = await sqlDb
        //       .readData("SELECT * FROM 'round' WHERE station_id=$id ");
        //
        //   for (int i = 0; i < round.length; i++) {
        //     markBuss(round[i]['bus_num'], 31.9791291, 35.9115409,
        //         round[i]['driver_name'], context);
        //   }
        //
        //   showModalBottomSheet(
        //     isScrollControlled: true,
        //     backgroundColor: Colors.white,
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        //     context: context,
        //     builder: (context) => DraggableScrollableSheet(
        //       initialChildSize: .5,
        //       minChildSize: .5,
        //       maxChildSize: .90,
        //       expand: false,
        //       builder: (context, scrollController) => Scaffold(
        //         bottomNavigationBar: BottomAppBar(
        //           shape: CircularNotchedRectangle(),
        //           notchMargin: 20,
        //           child: Container(
        //             height: 120,
        //             child: Column(
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.symmetric(
        //                       horizontal: 8.0, vertical: 20),
        //                   child: calculateDistance(
        //                               double.parse(lat.toString() ?? "0"),
        //                               double.parse(long.toString() ?? "0"),
        //                               lat1,
        //                               long1) <
        //                           double.parse(AppCubit.distance.toString())
        //                       ? InkWell(
        //                           child: Container(
        //                             margin: const EdgeInsets.symmetric(
        //                                 horizontal: 30),
        //                             padding: EdgeInsets.all(4.w),
        //                             decoration: BoxDecoration(
        //                               borderRadius: BorderRadius.circular(5),
        //                               color: Color(0xff0243a4),
        //                             ),
        //                             alignment: Alignment.center,
        //                             child: Text(
        //                               AppLocalizations.of(context)
        //                                   .translate('waiting'),
        //                               style: TextStyle(
        //                                   color: Colors.white,
        //                                   fontSize: 18,
        //                                   fontWeight: FontWeight.bold),
        //                             ),
        //                           ),
        //                         )
        //                       : InkWell(
        //                           child: Container(
        //                             margin: const EdgeInsets.symmetric(
        //                                 horizontal: 30),
        //                             padding: EdgeInsets.all(4.w),
        //                             decoration: BoxDecoration(
        //                               borderRadius: BorderRadius.circular(5),
        //                               color: Color(0xff0243a4).withOpacity(.2),
        //                             ),
        //                             alignment: Alignment.center,
        //                             child: Text(
        //                               AppLocalizations.of(context)
        //                                   .translate('waiting'),
        //                               style: TextStyle(
        //                                   color: Colors.white,
        //                                   fontSize: 18,
        //                                   fontWeight: FontWeight.bold),
        //                             ),
        //                           ),
        //                         ),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal: 20),
        //                   child: Text(
        //                     AppLocalizations.of(context).translate('stop'),
        //                     style: TextStyle(
        //                         color: Color(0xff0243a4),
        //                         fontSize: 12,
        //                         fontWeight: FontWeight.bold),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //         backgroundColor: Colors.transparent,
        //         body: SingleChildScrollView(
        //             controller: scrollController,
        //             child: Column(
        //               children: [
        //                 SizedBox(
        //                   height: 10,
        //                 ),
        //                 Container(
        //                   alignment: Alignment.center,
        //                   child: Card(
        //                       color: Color(0xffeaeaea),
        //                       elevation: 0,
        //                       child: Container(
        //                         height: 6,
        //                         width: 50,
        //                       )),
        //                 ),
        //                 SizedBox(
        //                   height: 10,
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal: 40),
        //                   child: Row(
        //                     children: [
        //                       Container(
        //                           width: 30,
        //                           height: 30,
        //                           color: Color(0xff0543a4),
        //                           child: Icon(Icons.directions_bus,
        //                               color: Colors.white)),
        //                       SizedBox(
        //                         width: 10,
        //                       ),
        //                       Expanded(
        //                         child: Column(
        //                           mainAxisAlignment: MainAxisAlignment.start,
        //                           crossAxisAlignment: CrossAxisAlignment.start,
        //                           children: [
        //                             Padding(
        //                               padding: const EdgeInsets.symmetric(
        //                                   horizontal: 10),
        //                               child: Text(name,
        //                                   style: TextStyle(
        //                                       fontWeight: FontWeight.bold,
        //                                       color: Colors.black,
        //                                       fontSize: 17)),
        //                             ),
        //                             SizedBox(
        //                               height: 10,
        //                             ),
        //                             Padding(
        //                               padding: const EdgeInsets.symmetric(
        //                                   horizontal: 10),
        //                               child: Text(selectedItem!,
        //                                   style: TextStyle(
        //                                       fontWeight: FontWeight.bold,
        //                                       color: Color(0xff707070),
        //                                       fontSize: 14)),
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                       Column(
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           for (int x = 0; x <= round.length - 1; x++)
        //                             (Text(round[x]['name'],
        //                                 style: TextStyle(
        //                                     fontWeight: FontWeight.bold,
        //                                     color: Color(0xff707070),
        //                                     fontSize: 14)))
        //                         ],
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             )),
        //       ),
        //     ),
        //   );
        // },
        icon: customMarkerIcon,
        markerId: MarkerId("station " + id.toString()),
        position: LatLng(lat1, long1)));
  }

  Future<void> markBuss(
      String id, double lat1, double long1, String name, context) async {
    final customMarkerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'images/icons8bus48.png',
    );
    marker.add(Marker(
        onTap: () async {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            context: context,
            builder: (context) => DraggableScrollableSheet(
              initialChildSize: .5,
              minChildSize: .5,
              maxChildSize: .90,
              expand: false,
              builder: (context, scrollController) => Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Card(
                              color: Color(0xffeaeaea),
                              elevation: 0,
                              child: Container(
                                height: 6,
                                width: 50,
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            children: [
                              Container(
                                  width: 30,
                                  height: 30,
                                  color: Color(0xff0543a4),
                                  child: Icon(Icons.person_pin_rounded,
                                      color: Colors.white)),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        child: Text('12',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 17)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text('Driver Name',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 17)),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff707070),
                                              fontSize: 14)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          );
        },
        icon: customMarkerIcon,
        markerId: MarkerId('round ' + id.toString()),
        position: LatLng(lat1, long1)));
  }




}
