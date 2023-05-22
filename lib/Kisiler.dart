// ignore_for_file: non_constant_identifier_names, file_names

class Kisiler {
  late String kisi_ad;
  late int kisi_yas;

  Kisiler(this.kisi_ad, this.kisi_yas);
// Burada veritabanındaki veriler parse edilip maindeki fonksiyona gönderiliyor.
  factory Kisiler.fromJson(Map<dynamic, dynamic> json) {
    return Kisiler(json["kisi_ad"] as String, json["kisi_yas"] as int);
  }
}
