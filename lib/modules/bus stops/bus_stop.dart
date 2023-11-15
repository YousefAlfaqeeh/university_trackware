
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:university_trackware/cubit/cubit.dart';
import 'package:university_trackware/cubit/cubitBusStop.dart';
import 'package:university_trackware/cubit/states.dart';
import 'package:university_trackware/localizations.dart';
import 'package:university_trackware/modules/qr/qa.dart';
import 'package:university_trackware/shared/components/customAppBar.dart';
import 'package:university_trackware/shared/components/customNavbar.dart';

class BusStopScreen extends StatelessWidget {
  const BusStopScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return BlocProvider(
        create: (context) => AppCubitBusStop()..getRouts(context),
        child: BlocConsumer<AppCubitBusStop, AppStates>(
          builder: (context, state) {
            return Scaffold(
                bottomNavigationBar: CustomBottomBar(
                    "images/icons8_four_squares.svg",
                    "images/icons8_home6.svg",
                    "images/picup_empty.svg",
                    "images/icon_feather_search.svg",
                    Color(0xff98aac9),
                    Color(0xffad302c),
                    Color(0xff98aac9),
                    Color(0xff98aac9)),
                body: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xff0543a4),
                          Color(0xff0543a4),
                        ],
                      )),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomAppbar(
                            AppLocalizations.of(context).translate('bus_stop'),
                            Icon(Icons.close, color: Color(0xff0543a4))),
                        SizedBox(
                          height: 10,
                        ),
                        //dropdown Autocomplete
                        Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              height: 5.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: DropdownSearch(
                                items: AppCubitBusStop.continent,
                                selectedItem:AppCubitBusStop.selectedItem,
                                onChanged: (value) async {
                                  AppCubitBusStop.get(context).changeRoute(value.toString());
                                },

                                dropdownSearchDecoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)
                                      .translate('search_route'),
                                  prefixIcon: Icon(
                                    Icons.search,
                                  ),
                                  fillColor: Colors.white,
                                ),
                              ),
                            )

                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Container(
                          height: 64.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xfff7f7fa),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              )),
                          child: Container(
                            height: 60.h,
                            // padding: EdgeInsets.only(left: 15,right: 15),

                            child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        topRight: Radius.circular(50),
                                      ),
                                      child: GoogleMap(
                                        indoorViewEnabled: true,
                                        zoomControlsEnabled: false,
                                        mapType: MapType.normal,
                                        initialCameraPosition: AppCubitBusStop.kGooglePlex,
                                        markers: AppCubitBusStop.marker,
                                        onLongPress: (argument) {},
                                        onMapCreated:
                                            (GoogleMapController controller) {
                                              AppCubitBusStop.controller.complete(controller);
                                        },
                                        onCameraMove: (position) {
                                          // setState(() {
                                          //   currentLocation = position.target;
                                          // });
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20,
                                        bottom: 140,
                                        right: 20,
                                        left: 20),
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Qr(),
                                              ));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                              BorderRadius.circular(10)),
                                          width: 50,
                                          height: 50,
                                          child: Icon(Icons.qr_code_2,
                                              color: Colors.white, size: 45),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20,
                                        bottom: 80,
                                        right: 20,
                                        left: 20),
                                    child: InkWell(
                                        // onTap: () async {
                                        //   // marker=Set();
                                        //   marker.clear();
                                        //   _selectedItem = '';
                                        //   await AppCubit.get(context)
                                        //       .getStationName();
                                        //   Uint8List b1 = (await NetworkAssetBundle(
                                        //       Uri.parse(
                                        //           'https://trackware-schools.s3.eu-central-1.amazonaws.com/loction1.png'))
                                        //       .load(
                                        //       'https://trackware-schools.s3.eu-central-1.amazonaws.com/loction1.png'))
                                        //       .buffer
                                        //       .asUint8List();
                                        //   // print(AppCubit.all_stationRout.length);
                                        //   for (int i = 0;
                                        //   i <
                                        //       AppCubit
                                        //           .all_stationRout.length;
                                        //   i++) {
                                        //     // print(i<AppCubit.all_stationRout.length);
                                        //     // for(int x=0;x<AppCubit.all_stationRout[i].length;x++) {
                                        //     markSt(
                                        //         AppCubit.all_stationRout[i]
                                        //         ['id'],
                                        //         AppCubit.all_stationRout[i]
                                        //         ['lat'],
                                        //         AppCubit.all_stationRout[i]
                                        //         ['long'],
                                        //         b1,AppCubit.all_stationRout[i]['name']);
                                        //   }
                                        //   location11();
                                        //   // print(marker.length);
                                        //   // }
                                        // },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(10)),
                                          width: 50,
                                          height: 50,
                                          padding: EdgeInsets.all(10),
                                          child: SvgPicture.asset(
                                              'images/location_round.svg',
                                              color: Colors.black,
                                            height: 20,
                                             ),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20,
                                        bottom: 20,
                                        right: 20,
                                        left: 20),
                                    child: InkWell(
                                      onTap: () {
                                        AppCubitBusStop.selectedItem=null;
                                        AppCubitBusStop.get(context).changeRoute('');
                                      },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(10)),
                                          width: 50,
                                          height: 50,
                                          child: Icon(
                                            Icons.my_location,
                                            size: 20,
                                          ),
                                        )),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          },
          listener: (context, state) async {
           
          },
        ));
  }
}
