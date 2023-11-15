class Routs {
  List<FromStations>? fromStations;

  Routs({this.fromStations});

  Routs.fromJson(Map<String, dynamic> json) {
    if (json['from_stations'] != null) {
      fromStations = <FromStations>[];
      json['from_stations'].forEach((v) {
        fromStations!.add(new FromStations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fromStations != null) {
      data['from_stations'] =
          this.fromStations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FromStations {
  String? name;
  int? id;
  List<StationRout>? stationRout;

  FromStations({this.name, this.id, this.stationRout});

  FromStations.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    if (json['station_rout'] != null) {
      stationRout = <StationRout>[];
      json['station_rout'].forEach((v) {
        stationRout!.add(new StationRout.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    if (this.stationRout != null) {
      data['station_rout'] = this.stationRout!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StationRout {
  String? name;
  int? id;
  String? time;
  double? lat;
  double? long;
  List<Round>? round;

  StationRout({this.name, this.id, this.time, this.lat, this.long, this.round});

  StationRout.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    time = json['time'];
    lat = json['lat'];
    long = json['long'];
    if (json['round'] != null) {
      round = <Round>[];
      json['round'].forEach((v) {
        round!.add(new Round.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['time'] = this.time;
    data['lat'] = this.lat;
    data['long'] = this.long;
    if (this.round != null) {
      data['round'] = this.round!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Round {
  String? name;
  String? time;

  Round({this.name, this.time});

  Round.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['time'] = this.time;
    return data;
  }
}