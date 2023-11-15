import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:university_trackware/localizations.dart';
import 'package:university_trackware/modules/bus%20stops/bus_stop.dart';
import 'package:university_trackware/modules/departing/depating.dart';
import 'package:university_trackware/modules/profile/profile.dart';
import 'package:university_trackware/modules/routes/routes.dart';

class CustomBottomBar extends StatefulWidget {
  String imageGenr,imageHome,imagePick,imageSett;
  Color colorGenr,colorHome,colorPick,colorSett;

  CustomBottomBar(
      this.imageGenr,
      this.imageHome,
      this.imagePick,
      this.imageSett,

      this.colorGenr,
      this.colorHome,
      this.colorPick,
      this.colorSett,
);
  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();


}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return BottomAppBar(
      shape: CircularNotchedRectangle(),


      notchMargin: 20,
      child: Container(
        height: 77.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RoutesScreen(),
                          ));
                    },
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.route,color: widget.colorSett),
                        Text('Route',style: TextStyle(fontSize: 10,color: widget.colorSett),)
                        // SvgPicture.asset(widget.imageSett,color:widget.colorSett,height: 22,)
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DepatingScreen(),
                          ));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.bus_alert,color: widget.colorGenr,),
                        Text('Departiong',style: TextStyle(fontSize: 10,color:widget.colorGenr),)
                        // SvgPicture.asset(widget.imageTrack,color: widget.colorTrack,height: 22,)


                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BusStopScreen(),
                          ));
                    },
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.directions_bus,color: widget.colorHome,),
                        Text(AppLocalizations.of(context).translate('bus_stop'),style: TextStyle(fontSize: 10,color:widget.colorHome),)
                        // SvgPicture.asset(widget.imageHome,color: widget.colorHome,height: 22,)
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.menu,color: widget.colorPick,),
                        Text(AppLocalizations.of(context).translate('menu'),style: TextStyle(fontSize: 10,color: widget.colorPick),)
                        // SvgPicture.asset(widget.imagePick,color:  widget.colorPick,height: 22,)

                      ],
                    ),
                  ),
                )
              ],
            ),

          ],

        ),


      ),


    );
  }
}