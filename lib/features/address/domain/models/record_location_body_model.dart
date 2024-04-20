class RecordLocationBodyModel {
  String? token;
  double? longitude;
  double? latitude;
  String? location;

  RecordLocationBodyModel({this.token, this.longitude, this.latitude, this.location});

  RecordLocationBodyModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    longitude = json['longitude']?.toDouble();
    latitude = json['latitude']?.toDouble();
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['location'] = location;
    return data;
  }
}