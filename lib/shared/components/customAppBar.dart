import 'package:flutter/material.dart';

class CustomAppbar extends StatefulWidget {
  String name;
  Icon icon;
  CustomAppbar(this.name,this.icon);


  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return  Container(

      // color: Colors.red,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20,right: 20,top: 80),
      // height: 8.h,

      // decoration: BoxDecoration(border: Border.all(color: Colors.black,width: .3),color: Colors.white),
      child: Row(
        children: [
          IconButton(icon:widget.icon,onPressed: () {

          }, ),
          Expanded(
            child: Container(
              // color: Colors.red,
              alignment: Alignment.center,
              child: Text(
                widget.name,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                    color: Colors.white),
              ),
            ),
          ),
          IconButton(onPressed: () {

          }, icon:  Icon(Icons.notifications, color: Colors.white))


        ],
      ),

    );
  }
}
