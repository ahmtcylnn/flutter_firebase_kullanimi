// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'dart:collection';
import 'Kisiler.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var refKisiler = FirebaseDatabase.instance.ref().child("kisiler_tablo");

  Future<void> kisiEkle() async {
    var bilgi = HashMap<String, dynamic>();
    bilgi["kisi_ad"] = "İlda";
    bilgi["kisi_yas"] = 6;
    refKisiler.push().set(bilgi);
  }

  Future<void> kisiSil() async {
    refKisiler.child("-NVWvh5RVkF0siljztEf").remove();
  }

  Future<void> kisiGuncelle() async {
    var guncelBilgi = HashMap<String, dynamic>();
    guncelBilgi["kisi_ad"] = "Utku";
    guncelBilgi["kisi_yas"] = 33;
    refKisiler.child("s").update(guncelBilgi);
  }

  Future<void> tumKisiler() async {
    refKisiler.onValue.listen((event) {
      var gelenDegerler = event.snapshot.value as Map;

      if (gelenDegerler != null) {
        gelenDegerler.forEach((key, nesne) {
          var gelenKisi = Kisiler.fromJson(nesne);

          print("*************");
          print("Kişi key: $key");
          print("Kişi ad: ${gelenKisi.kisi_ad}");
          print("Kişi yaş: ${gelenKisi.kisi_yas}");
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //kisiEkle();
    //kisiSil();
    //kisiGuncelle();
    tumKisiler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[],
        ),
      ),
    );
  }
}
