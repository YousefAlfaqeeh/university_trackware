import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:intl/intl.dart';
import 'package:university_trackware/cubit/states.dart';
import 'package:university_trackware/dataBase/sqldb.dart';
import 'package:university_trackware/models/login.dart';
import 'package:university_trackware/models/routs.dart';
import 'package:university_trackware/shared/end_points.dart';
import 'package:university_trackware/shared/local/cache_helper.dart';

import '../shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  // SqlDb sqlDb = SqlDb();
  static Locale? locale;
  String status = '';
  static String? name;
  static String? image ;
  static String? mobile = '';
  static String? token = '';
  static int? user_id = 0;
  static int? notify = 0;
  static String? authorization = '';
  static String? lang = 'en';
  Routs? modelRouts;
  static List<StationRout> stationRout_n = [];
  List<Round>? rounds = [];
  static List<FromStations> stationRout = [];
  static List<String> continent = [];
  static List<dynamic> all_stationRout = [];
  // Set<Marker> marker_all = new Set();
  // Set<Marker> marker_st = new Set();
  // Set<Marker> marker_bus = new Set();
  // Set<Marker> marker_route = new Set();
  // List marker_rout = [];
  LoginM? login_info;
  String db_name = '';
  static String? distance = '0';

  getschool() async {
    // var responseKids = await DioHelper1.getData(url: '').then(
    //   (value) {
    //     school_list1 = value.data.map((e) => School.fromJson(e)).toList();
    //   },
    // ).catchError((onError) {
    //   print(onError);
    // });
  }

  getProfile() async {
    await DioHelper.getData(url: PostProfile,token: CacheHelper.getBoolean(key: 'authorization')).then(
      (value) {
        login_info = LoginM.fromJson(value.data);

        if (login_info?.status == 'ok') {
          status = 'Connection';
          name = login_info?.name!;
          image = login_info?.image;
          lang = login_info?.langApp;
          user_id = login_info?.uid;
          notify = login_info?.notif;
          token = login_info?.token;
          mobile = login_info?.mobile;
          authorization = login_info?.authorization;
          distance = login_info?.distance!;
        }
        print("ffffffffff");
        emit(AppProfileState());
        },
    ).catchError((onError) {
      print(onError);
    });
    // List<dynamic> resp = await sqlDb.readData("SELECT * FROM 'profile'");
    // name = resp[0]['name'];
    // image = resp[0]['image'];
    // mobile = resp[0]['mobile'];
    // token = resp[0]['token'];
    // user_id = resp[0]['user_id'];
    // notify = resp[0]['notify'];
    // authorization = resp[0]['authorization'];
    // distance = resp[0]['distance'] ? resp[0]['distance'] : '0';
    // print("ffffffffff");
    // emit(AppProfileState());
    //AppProfileState
  }

  postProfile(bool notf, String pass, String lan) async {
    await DioHelper.postData(
            url: PostProfile,
            data: {
              "pass": pass,
              "notify": notf,
              "lang": lan,
            },
            token: CacheHelper.getBoolean(key: 'authorization'))
        .then(
      (value) async {
        status = 'OK';
      },
    ).catchError((onError) async {
      status = 'error';
    });
    int notif = notf ? 1 : 0;

    // String sql =
    //     "UPDATE  'profile' SET 'lang'='$lan','notify'=$notif WHERE id=1";
    // await sqlDb.updateData(sql);
    notify = notif;
    lang = lan;

    emit(AppProfileState());
  }

  getRouts() async {
    await DioHelper.postData(url: GetRouts, data: {}, token: CacheHelper.getBoolean(key: 'authorization'))
        .then(
      (value) async {
      //   String sql = "DELETE FROM 'rout'";
      //   await sqlDb.deleteData(sql);
      //   sql = "DELETE FROM 'station'";
      //   await sqlDb.deleteData(sql);
      //   sql = "DELETE FROM 'round'";
      //   await sqlDb.deleteData(sql);
      //   modelRouts = Routs.fromJson(value.data);
      //   stationRout = modelRouts!.fromStations!;
      //   for (int i = 0; i < stationRout.length; i++) {
      //     String? name = stationRout[i].name;
      //     int? rout_id = stationRout[i].id;
      //     stationRout_n = stationRout[i]!.stationRout!;
      //     String sql_rout = '''
      //     INSERT INTO rout(name, rout_id) VALUES
      //     ('$name','$rout_id')
      //     ''';
      //     await sqlDb.insertData(sql_rout);
      //     continent.add(name!);
      //
      //     for (int x = 0; x < stationRout_n.length; x++) {
      //       String? name_st = stationRout_n[x].name;
      //       String? time = stationRout_n[x].time;
      //       double? lat = stationRout_n[x].lat;
      //       double? long = stationRout_n[x].long;
      //       int? st_id = stationRout_n[x].id;
      //       String sql_station = '''
      //     INSERT INTO station(time, name, station_id, long, lat, rout_id) VALUES
      //     ('$time','$name_st',$st_id,$long,$lat,$rout_id)
      //     ''';
      //       await sqlDb.insertData(sql_station);
      //
      //       all_stationRout.add({
      //         "name": name_st,
      //         "id": st_id,
      //         "lat": lat,
      //         "long": long,
      //         "rout_id": rout_id
      //       });
      //
      //       rounds = stationRout_n[i].round;
      //
      //       for (int y = 0; y < rounds!.length; y++) {
      //         String? name_round = rounds![y].name;
      //         String? time_rou = rounds![y].time;
      //         String? driver_name = 'ssssss';
      //         String? bus_num = '1';
      //         String sql_round = '''
      //     INSERT INTO round(time, name, driver_name, bus_num, station_id) VALUES
      //     ('$time_rou','$name_round','$driver_name','$bus_num',$st_id)
      //     ''';
      //
      //         await sqlDb.insertData(sql_round);
      //       }
      //     }
      //
      //   }
      },
    ).catchError((onError) async {
      status = 'error';
      print('ddddd');
      print(onError);
    });

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
    //
    // all_stationRout = [];
    //
    // for (int i = 0; i < resp.length; i++) {
    //   String? name_st = resp[i]['name'];
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

  logout() async {
    // String sql = "DELETE FROM 'profile' WHERE id=1";
    // await sqlDb.deleteData(sql);
    //
    // sql = "DELETE FROM 'rout'";
    // await sqlDb.deleteData(sql);
    // sql = "DELETE FROM 'station'";
    // await sqlDb.deleteData(sql);
    // sql = "DELETE FROM 'round'";
    // await sqlDb.deleteData(sql);
    CacheHelper.saveData(
        key: 'authorization', value:'');

    emit(AppProfileState());
  }

  Future<bool> internetConnectionChecker() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      return true;
    } else {
      return false;
    }
  }

//
  Future Login(String name1, String pass, String schoolName) async {
    db_name = schoolName;

    if (await internetConnectionChecker()) {
      await DioHelper.postData(data: {
        'user_name': name1,
        'password': pass,
        'platform': Platform.isAndroid ? 'android' : 'ios',
        'mobile_token': 'token',
        'school_name': schoolName
      }, url: Login1)
          .then((value) async {
        login_info = LoginM.fromJson(value.data);

        if (login_info?.status == 'ok') {
          status = 'Connection';
          CacheHelper.saveData(
              key: 'authorization', value: login_info?.authorization);
        name = login_info?.name!;
           image = login_info?.image;
           lang = login_info?.langApp;
           user_id = login_info?.uid;
          notify = login_info?.notif;
          token = login_info?.token;
          mobile = login_info?.mobile;
          authorization = login_info?.authorization;
          distance = login_info?.distance!;

          // String sql = '''
          // INSERT INTO profile(image, name, mobile, lang, user_id, notify, token,authorization,distance) VALUES
          // ('$image','$name','$mobile','$lang',$user_id,$notify,'$token','$authorization','$distance')
          // ''';
          // await sqlDb.insertData(sql);

          getProfile();
        }
        emit(AppLoginState());
      }).catchError((onError) {
        status = 'error';
      });

    } else {
      status = 'Connection';
    }
  }
}
