import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:university_trackware/cubit/cubit.dart';
import 'package:university_trackware/cubit/states.dart';
import 'package:university_trackware/localizations.dart';
import 'package:university_trackware/shared/components/customAppBar.dart';

class RoutesScreen extends StatefulWidget {
  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  Color back_from_s = Colors.white;
  Color back_from_un = Colors.white;
  Color font_from_s = Color(0xffb2bbc9);
  Color font_from_un = Color(0xffb2bbc9);
  String name_route='';

  List time = [
    {
      "name": "07:00",
      "backColor": Colors.white,
      "fontColor": Color(0xffb2bbc9)
    },
    {
      "name": "09:00",
      "backColor": Colors.white,
      "fontColor": Color(0xffb2bbc9)
    },
    {
      "name": "11:00",
      "backColor": Colors.white,
      "fontColor": Color(0xffb2bbc9)
    },
    {"name": "12:00", "backColor": Colors.white, "fontColor": Color(0xffb2bbc9)}
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return BlocProvider(
        create: (context) => AppCubit()..getschool(),
        child: BlocConsumer<AppCubit, AppStates>(
          builder: (context, state) {
            return Scaffold(
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
                        AppLocalizations.of(context).translate('routes'),
                        Icon(Icons.arrow_back_ios, color: Colors.white)),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 85.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xfff7f7fa),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          )),
                      child: Container(
                        height: 85.h,
                        // padding: EdgeInsets.only(left: 15,right: 15),

                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            back_from_s = Color(0xffad302c);
                                            font_from_s = Colors.white;
                                            back_from_un = Colors.white;
                                            font_from_un = Color(0xffb2bbc9);
                                          });
                                        },
                                        child: Card(
                                          color: back_from_s,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              side: BorderSide(
                                                  color: Color(0xffb2bbc9))),
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 40,
                                            width: 150,
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .translate('from_st'),
                                              style: TextStyle(
                                                  color: font_from_s,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            back_from_un = Color(0xffad302c);
                                            font_from_un = Colors.white;
                                            back_from_s = Colors.white;
                                            font_from_s = Color(0xffb2bbc9);
                                          });
                                        },
                                        child: Card(
                                          elevation: 0,
                                          color: back_from_un,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              side: BorderSide(
                                                  color: Color(0xffb2bbc9))),
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 40,
                                            width: 150,
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .translate('from_unv'),
                                              style: TextStyle(
                                                  color: font_from_un,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                              child: Container(
                                color: Color(0xfff7f7fa),
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return routes();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
          },
          listener: (context, state) {},
        ));
  }

  Widget routes() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                          width: 70.w,
                          child: Text(
                            'djdjjddjjdjd',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                      InkWell(
                        onTap: () {
                          name_route="kdkdkdkdkd";
                          routeStart();
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Color(0xffd7dfeb),
                              borderRadius: BorderRadius.circular(50)),
                          child: Icon(Icons.arrow_forward_ios,
                              color: Color(0xff8da3c3), size: 20),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadiusDirectional.circular(50)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text('data',
                            style: TextStyle(
                                color: Color(0xffc5c6cd),
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        height: 4,
                        width: 4,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadiusDirectional.circular(50)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        height: 4,
                        width: 4,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadiusDirectional.circular(50)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        height: 4,
                        width: 4,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadiusDirectional.circular(50)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadiusDirectional.circular(50)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text('data',
                            style: TextStyle(
                                color: Color(0xffc5c6cd),
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void routeStart() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setStatex) => DraggableScrollableSheet(
        initialChildSize: .80,
        minChildSize: .4,
        maxChildSize: .97,
        expand: false,
        builder: (context, scrollController) => Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
              controller: scrollController,
              child: Container(
                // color: Colors.red,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                        margin: EdgeInsets.symmetric(horizontal: 40.w),
                        color: Color(0xffeaeaea),
                        elevation: 0,
                        child: Container(
                          height: 6,
                          width: double.infinity,
                        )),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        AppLocalizations.of(context).translate('route_st'),
                        style:
                        TextStyle(fontSize: 14, color: Color(0xffb6b8c0)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(


                      margin: EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.white,
                      height: 10.w,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: time.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setStatex(() {
                                time[index]['backColor'] = Color(0xffad302c);
                                time[index]['fontColor'] = Colors.white;
                                for (int i = 0; i < time.length; i++) {
                                  if (i != index) {
                                    time[i]['backColor'] = Colors.white;
                                    time[i]['fontColor'] = Color(0xffb2bbc9);
                                  }
                                }
                              });
                            },
                            child: Card(
                              color: time[index]['backColor'],
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Color(0xffb2bbc9))),
                              child: Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: 60,
                                child: Text(
                                  time[index]['name'],
                                  style: TextStyle(
                                      color: time[index]['fontColor'],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        name_route,
                        style:
                        TextStyle(fontWeight: FontWeight.bold,fontSize: 14, color: Color(0xffb6b8c0)),
                      ),
                    ),
                    Container(
height: 70.h,
                      color: Colors.white,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount:4,
                        itemBuilder: (context, index) {
                          return routeloction(index);
                        },
                      ),
                    )

                  ],
                ),
              )),
        ),
      ),) ,
    );
  }

  Widget routeloction(int index)
  {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
          Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
           index!=3? Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0,top: 45),
                  child: Icon(Icons.trip_origin, color: Colors.blue,size: 15,),
                ),
                Icon(Icons.fiber_manual_record, color: Colors.grey, size: 5),
                SizedBox(height: 10,),
                Icon(Icons.fiber_manual_record, color: Colors.grey, size: 5),
                SizedBox(height: 10,),
                Icon(Icons.fiber_manual_record, color: Colors.grey, size: 5),
                SizedBox(height: 10,),
                Icon(Icons.fiber_manual_record, color: Colors.grey, size: 5),
                SizedBox(height: 10,),
                Icon(Icons.fiber_manual_record, color: Colors.grey, size: 5),
                SizedBox(height: 10,),
                Icon(Icons.fiber_manual_record, color: Colors.grey, size: 5),
                SizedBox(height: 10,),

              ],
            ):Column(
             mainAxisAlignment: MainAxisAlignment.start,

             children: <Widget>[
               Padding(
                 padding: const EdgeInsets.only(bottom: 4.0),
                 child: Icon(Icons.trip_origin, color: Colors.blue,size: 15,),

               ),
               // Icon(Icons.fiber_manual_record, color: Colors.grey, size: 5),
               SizedBox(height: 10,),

             ],
           ),
            SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text('07:30',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20)),
                ),

                SizedBox(height: 10,),
                Row(
                  children: [
                    Container(width: 30,
                        height: 30,
                        color: Color(0xff0543a4),
                        child: Icon(Icons.directions_bus, color: Colors.white)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('dsfkmdfmdfmdsm',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18)),
                    ),
                  ],
                ),


              ],
            ),
          ]),
      ]),

    );
  }
}
