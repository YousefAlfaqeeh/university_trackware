class LoginM {
  String? status;
  int? companyId;
  int? uid;
  String? token;
  String? dbName;
  String? langApp;
  String? name;
  String? mobile;
  int? notif;
  String? image;
  String? authorization;
  String? distance;

  LoginM(
      {this.status,
        this.companyId,
        this.uid,
        this.token,
        this.dbName,
        this.langApp,
        this.name,
        this.mobile,
        this.notif,
        this.image,
        this.distance,
        this.authorization});

  LoginM.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    companyId = json['company_id'];
    uid = json['uid'];
    token = json['token'];
    dbName = json['db_name'];
    langApp = json['lang_app'];
    name = json['name'];
    mobile = json['mobile'];
    notif = json['notif'];
    image = json['image'];
    authorization = json['Authorization'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['company_id'] = this.companyId;
    data['uid'] = this.uid;
    data['token'] = this.token;
    data['db_name'] = this.dbName;
    data['lang_app'] = this.langApp;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['notif'] = this.notif;
    data['image'] = this.image;
    data['Authorization'] = this.authorization;
    data['distance'] = this.distance;
    return data;
  }
}
