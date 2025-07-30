class TanamanModel {
  int idTanaman;
  String name;
  String kelebihan;
  String url;

  TanamanModel({
    required this.idTanaman,
    required this.name,
    required this.kelebihan,
    required this.url,
  });

  factory TanamanModel.fromJson(Map<String, dynamic> json) => TanamanModel(
    idTanaman: json["id_tanaman"],
    name: json["name"],
    kelebihan: json["kelebihan"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id_tanaman": idTanaman,
    "name": name,
    "kelebihan": kelebihan,
    "url": url,
  };
}
