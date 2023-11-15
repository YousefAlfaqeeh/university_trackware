// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:trackware_university/localizations.dart';
// import 'package:trackware_university/modules/bus%20stops/bus_stop.dart';
// import 'package:trackware_university/modules/departing/depating.dart';
// import 'package:trackware_university/modules/profile/profile.dart';
// import 'package:trackware_university/modules/routes/routes.dart';
//
// class CustomBottomBar extends StatefulWidget {
//   String imageGenr,imageHome,imagePick,imageSett;
//   Color colorGenr,colorHome,colorPick,colorSett;
//
//   CustomBottomBar(
//       this.imageGenr,
//       this.imageHome,
//       this.imagePick,
//       this.imageSett,
//
//       this.colorGenr,
//       this.colorHome,
//       this.colorPick,
//       this.colorSett,
//       );
//   @override
//   State<CustomBottomBar> createState() => _CustomBottomBarState();
//
//
// }
//
// class _CustomBottomBarState extends State<CustomBottomBar> {
//   @override
//   Widget build(BuildContext context) {
//     // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
//     return BottomAppBar(
//       shape: CircularNotchedRectangle(),
//
//
//       notchMargin: 20,
//       child: Container(
//         height: 77.9,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//
//                 Padding(
//                   padding: const EdgeInsets.only(top: 15.0),
//                   child: MaterialButton(
//                     minWidth: 40,
//                     onPressed: () {
//                       SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => RoutesScreen(),
//                           ));
//                     },
//                     child: Column(crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Icon(Icons.route,color: Color(0xff98aac9)),
//                         Text('Route',style: TextStyle(fontSize: 10,color: Color(0xff98aac9)),)
//                         // SvgPicture.asset(widget.imageSett,color:widget.colorSett,height: 22,)
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//
//                 Padding(
//                   padding: const EdgeInsets.only(top: 15.0),
//                   child: MaterialButton(
//                     minWidth: 40,
//                     onPressed: () {
//                       SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => DepatingScreen(),
//                           ));
//                     },
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Icon(Icons.bus_alert,color:Color(0xff98aac9),),
//                         Text('Departiong',style: TextStyle(fontSize: 10,color:Color(0xff98aac9)),)
//                         // SvgPicture.asset(widget.imageTrack,color: widget.colorTrack,height: 22,)
//
//
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//
//                 Padding(
//                   padding: const EdgeInsets.only(top: 15.0),
//                   child: MaterialButton(
//                     minWidth: 40,
//                     onPressed: () {
//                       SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => BusStopScreen(),
//                           ));
//                     },
//                     child: Column(crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Icon(Icons.directions_bus,color:  Color(0xffad302c),),
//                         Text(AppLocalizations.of(context).translate('bus_stop'),style: TextStyle(fontSize: 10,color: Color(0xffad302c)),)
//                         // SvgPicture.asset(widget.imageHome,color: widget.colorHome,height: 22,)
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//
//                 Padding(
//                   padding: const EdgeInsets.only(top: 15.0),
//                   child: MaterialButton(
//                     minWidth: 40,
//                     onPressed: () {
//                       SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ProfileScreen(),
//                           ));
//                     },
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Icon(Icons.menu,color:Color(0xff98aac9),),
//                         Text(AppLocalizations.of(context).translate('menu'),style: TextStyle(fontSize: 10,color:Color(0xff98aac9)),)
//                         // SvgPicture.asset(widget.imagePick,color:  widget.colorPick,height: 22,)
//
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//
//           ],
//
//         ),
//
//
//       ),
//
//
//     );
//   }
// }