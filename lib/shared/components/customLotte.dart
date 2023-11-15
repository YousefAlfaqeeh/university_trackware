
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class CustomLotte extends StatelessWidget {
  String url;
  CustomLotte(this.url);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(child: Lottie.asset(url),);
  }


}

