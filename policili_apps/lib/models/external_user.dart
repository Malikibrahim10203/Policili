class ExternalUser {
  int id;
  String name;
  String email;
  String deviceId;
  String sensorId;
  String usernameThinger;

  ExternalUser({
    required this.id,
    required this.name,
    required this.email,
    required this.deviceId,
    required this.sensorId,
    required this.usernameThinger,
  });

  factory ExternalUser.fromJson(Map<String, dynamic> json) => ExternalUser(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    deviceId: json["device_id"],
    sensorId: json["sensor_id"],
    usernameThinger: json["username_thinger"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "device_id": deviceId,
    "sensor_id": sensorId,
    "username_thinger": usernameThinger,
  };
}
