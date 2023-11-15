import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:university_trackware/cubit/cubit.dart';
import 'package:university_trackware/localizations.dart';
import 'package:university_trackware/modules/splash_screen/splash_screen.dart';
import 'package:university_trackware/shared/network/remote/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.location.request();
  await DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) => MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: AppCubit.locale.toString().isEmpty
          ? Localizations.localeOf(context)
          : AppCubit.locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate
        // GlobalMaterialLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate, // 추가
        // GlobalWidgetsLocalizations.delegate,
      ],

      // locale: _locale,
      supportedLocales: [
        Locale("en", ""),
        Locale("ar", ""),
      ],
      localeResolutionCallback: (currentlang, supportlang) {
        if (currentlang != null) {
          for (Locale locale in supportlang) {
            if (locale.languageCode == currentlang.languageCode) {
              // AppCubit.get(context).setLang();
              // //  getToken();
              // if (CacheHelper.getBoolean(key: 'authorization') ==
              //     null) {
              //   CacheHelper.saveData(
              //       key: 'lang',
              //       value: currentlang.languageCode.toString());
              // } else {
              //   if (i == 0) {
              //     i += 1;
              //
              //     AppCubit.get(context).getSetting();
              //   }
              // }
              // AppCubit.locale = Locale(
              //     CacheHelper.getBoolean(key: 'lang').toString());
              return currentlang;
            }
          }
        }

        return supportlang.first;
      },
      home:  SplashScreen(),
    ),


    );
  }
}
