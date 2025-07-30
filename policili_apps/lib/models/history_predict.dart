class HistoryPredict {
  int id;
  String email;
  String pH;
  String kelembabanUdara;
  String kelembabanTanah;
  String suhu;
  String recommendation;
  String date;

  HistoryPredict({
    required this.id,
    required this.email,
    required this.pH,
    required this.kelembabanUdara,
    required this.kelembabanTanah,
    required this.suhu,
    required this.recommendation,
    required this.date,
  });

  factory HistoryPredict.fromJson(Map<String, dynamic> json) => HistoryPredict(
    id: json["id"],
    email: json["email"],
    pH: json["pH"],
    kelembabanUdara: json["kelembabanUdara"],
    kelembabanTanah: json["kelembabanTanah"],
    suhu: json["suhu"],
    recommendation: json["recommendation"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "pH": pH,
    "kelembabanUdara": kelembabanUdara,
    "kelembabanTanah": kelembabanTanah,
    "suhu": suhu,
    "recommendation": recommendation,
    "date": date,
  };
}
