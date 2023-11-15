import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:university_trackware/cubit/cubit.dart';
import 'package:university_trackware/cubit/states.dart';
import 'package:university_trackware/localizations.dart';
import 'package:university_trackware/shared/components/customAppBar.dart';

class DepatingScreen extends StatefulWidget {
  @override
  State<DepatingScreen> createState() => _DepatingScreenState();
}

class _DepatingScreenState extends State<DepatingScreen> {
  bool flg = false;
  List<String> continent = [
    "a",
    "d",
    "ddd",
    "jjdjdj",
    "hdhdhfh",
    "jfjfjfjfjfjfjfjfj",
    "ds",
    "a",
    "d",
    "ddd",
    "jjdjdj",
    "hdhdhfh",
    "jfjfjfjfjfjfjfjfj",
    "ds"
  ];
  List time = ['07:00', '09:00', '11:00', '12:00'];
  List<GestureDetector> list_bus = [];
  int select = -1;

  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      for (int i = 0; i < 4; i++) {
        list_bus.add(GestureDetector(
          onTap: () {
            print('dddd' + i.toString());
          },
          child: Container(
            alignment: Alignment.center,
            width: 50,
            child: Card(
              color: Color(0xffeeeeee),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'K' + i.toString(),
                        style:
                            TextStyle(fontSize: 10, color: Color(0xff59aab1)),
                      ),
                    ))
                  ]),
            ),
          ),
        ));
      }
    });

    setState(() {});
    super.initState();
  }

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
                        AppLocalizations.of(context).translate('departing'),
                        Icon(Icons.close, color: Colors.white)),
                    Container(
                      height: 90.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Container(
                        height: 90.h,
                        // padding: EdgeInsets.only(left: 15,right: 15),

                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              height: 8.h,

                              // decoration: BoxDecoration(border: Border.all(color: Colors.black,width: .3),color: Colors.white),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('send_leave'),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Nunito',
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //dropdown Autocomplete
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                // color: Colors.white,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white
                                ),
                                child: DropdownSearch(
                                  items: continent,
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      flg=true;
                                    });
                                  },

                                  dropdownSearchDecoration: InputDecoration(

hintText: AppLocalizations.of(context)
    .translate('choose_route'),
                                    prefixIcon: Icon(
                                      Icons.route,
                                    ),
                                    // fillColor: Colors.white,
                                  ),
                                ),
                              )

                              // Autocomplete(
                              //   fieldViewBuilder: (context,
                              //       textEditingController,
                              //       focusNode,
                              //       onFieldSubmitted) {
                              //     return TextField(
                              //       controller: textEditingController,
                              //       focusNode: focusNode,
                              //       onEditingComplete: onFieldSubmitted,
                              //       decoration: InputDecoration(
                              //           prefixIcon: Icon(Icons.route),
                              //           hintText: AppLocalizations.of(context)
                              //               .translate('choose_route'),
                              //           border: OutlineInputBorder(
                              //               borderSide: BorderSide(
                              //                   color: Color(0xfff8f8f8)),
                              //               borderRadius:
                              //                   BorderRadius.circular(10))),
                              //     );
                              //   },
                              //   optionsBuilder: (textEditingValue) {
                              //     return continent.where((element) => element
                              //         .toLowerCase()
                              //         .startsWith(
                              //             textEditingValue.text.toLowerCase()));
                              //   },
                              //   onSelected: (option) {
                              //     setState(() {
                              //       flg = true;
                              //     });
                              //   },
                              // ),
                            ),
                            Visibility(
                              visible: flg,
                              child: Expanded(
                                child: Container(
                                  color: Colors.white,
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: time.length,
                                    itemBuilder: (context, index) {
                                      return route(index);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            //button send
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 50, horizontal: 20),

                              decoration: BoxDecoration(
                                  color: flg
                                      ? Color(0xff0543a4)
                                      : Color(0xff0543a4).withOpacity(.4),
                                  borderRadius: BorderRadius.circular(10)),
                              width: double.infinity,
                              // color: Colors.orange,
                              child: MaterialButton(
                                child: Text(
                                    style: TextStyle(color: Colors.white),
                                    AppLocalizations.of(context)
                                        .translate('send')),
                                onPressed: () async {},
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

  Widget route(int index) {
    Color background = Colors.white;
    Color bord = Color(0xffb2bbc9);
    if (index == select) {
      background = Color(0xffeef1f4);
      bord = Color(0xff0543a4);
    }
    print("kdkdkdk");
    if (index == 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: InkWell(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Color(0xffb2bbc9))),
            elevation: 0,
            child: Container(
              height: 10.h,
              child: Center(
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.access_time_filled,
                      color: Color(0xffb2bbc9),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            time[index],
                            style: TextStyle(
                                color: Color(0xffb2bbc9),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            time[index],
                            style: TextStyle(
                                color: Color(0xffb2bbc9),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Wrap(
                          // alignment: WrapAlignment.spaceEvenly,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: list_bus),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: InkWell(
        onTap: () {
          setState(() {
            print('djjddjdjdjdf');
            select = index;
          });
        },
        child: Card(
          color: background,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: bord)),
          elevation: 0,
          child: Container(
            height: 10.h,
            child: Center(
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.access_time_filled,
                    color: Color(0xffb2bbc9),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          time[index],
                          style: TextStyle(
                              color: Color(0xff0543a4),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(time[index]),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Wrap(
                        // alignment: WrapAlignment.spaceEvenly,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: list_bus),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
