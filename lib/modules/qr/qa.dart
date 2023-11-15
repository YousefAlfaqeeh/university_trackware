import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
class Qr extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Scaffold(body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 100),
      child: QrImage(
        data: 'Trackware',
        version: QrVersions.auto,
        size: 320,
        gapless: false,
        // embeddedImage: NetworkImage('https://s3.eu-central-1.amazonaws.com/trackware.schools/public_images/default_student.png'),
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: Size(80, 80),
        ),
      ),
    ),);
  }
}