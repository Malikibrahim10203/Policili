class UserapiModel {
  String name;
  String deviceId;
  String sensorId;
  String usernameThinger;

  UserapiModel({
    required this.name,
    required this.deviceId,
    required this.sensorId,
    required this.usernameThinger,
  });

  factory UserapiModel.fromJson(Map<String, dynamic> json) => UserapiModel(
    name: json["name"],
    deviceId: json["device_id"],
    sensorId: json["sensor_id"],
    usernameThinger: json["username_thinger"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "device_id": deviceId,
    "sensor_id": sensorId,
    "username_thinger": usernameThinger,
  };
}
