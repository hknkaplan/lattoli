import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lattoli/Modeller/Kelimelerdao.dart';
import 'package:lattoli/Sayafalar/ayarlar.dart';
import 'package:lattoli/Sayafalar/sonucEkrani.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../Modeller/Kelimeler.dart';

class sinavEkrani extends StatefulWidget {
  @override
  _sinavEkraniState createState() => _sinavEkraniState();
}

class _sinavEkraniState extends State<sinavEkrani> {

  //LİSTELER
  var sorular = <Kelimeler>[];
  var yanlisSecenekler = <Kelimeler>[];
  var tumSecenekler = HashSet<Kelimeler>();

  //SAYFA DEĞİŞKENLERİ
  late Kelimeler dogruSoru;
  int soruSayac = 0;
  int dogruSayac = 0;
  int yanlisSayac = 0;
  String soruText = "";
  String buttonAyazi = "";
  String buttonByazi = "";
  String buttonCyazi = "";
  String buttonDyazi = "";
  bool secildi = false;
  String secilenButton ="";
  late Timer zamanlayici;
  int sure = 0;
  double indiDeger = 0.0;

//Silinecek değişken
  int gelenSoruS =5;

  //METOTLAR
  Future<void> sorulariAl() async{
    sorular = await Kelimelerdao().rasgeleSoruGetir();
    soruYukle();
  }
  Future<void> soruYukle() async{
    dogruSoru = sorular[soruSayac];
    soruText = dogruSoru.kelime_ing;
    yanlisSecenekler = await Kelimelerdao().rasgele3YanlisGetir(dogruSoru.kelime_id);
    tumSecenekler.clear();
    tumSecenekler.add(dogruSoru);
    tumSecenekler.add(yanlisSecenekler[0]);
    tumSecenekler.add(yanlisSecenekler[1]);
    tumSecenekler.add(yanlisSecenekler[2]);
    buttonAyazi = tumSecenekler.elementAt(0).kelime_tr;
    buttonByazi = tumSecenekler.elementAt(1).kelime_tr;
    buttonCyazi = tumSecenekler.elementAt(2).kelime_tr;
    buttonDyazi = tumSecenekler.elementAt(3).kelime_tr;
    indiDeger = indiDeger + (1/gelenSoruS);
    setState(() { });
  }
  
  void soruSayacKontrol(){
    soruSayac++;
    if(soruSayac!=5){
      soruYukle();
    }else{
      zamanlayici.cancel();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => sonucEkrani(dogruSayac,yanlisSayac,sure.toInt(),gelenSoruS)));
    }
  }

   bool dogruKontrol(String buttonYazi){
    if(dogruSoru.kelime_tr == buttonYazi){
      dogruSayac++;
      Kelimelerdao().kelimeDurumGuncelle(dogruSoru.kelime_id, 1, 0);
      print(dogruSayac);
      return true;
    }else{
      yanlisSayac++;
      Kelimelerdao().kelimeDurumGuncelle(dogruSoru.kelime_id, 0, 1);
      print(yanlisSayac);
      return false;
    }
  }

  void sayac() {
    zamanlayici = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        sure++;
      });
    });
  }

  @override
  void initState() {
    sorulariAl();
    sayac();
  }


  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Lattoli",style: GoogleFonts.oleoScript(textStyle: TextStyle(fontSize: ekranGenisligi/10, fontWeight: FontWeight.bold,) )),
              Text("$sure sn",style: GoogleFonts.kdamThmor(textStyle: TextStyle(fontSize: ekranGenisligi/12, fontWeight: FontWeight.bold, color: Colors.grey) )),
            ]),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,size: 30,),
          onPressed: (){
            Navigator.pop(context);
            zamanlayici.cancel();
          },
        ),

      ),
      body: Center(
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(flex: 10, child: Container(child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  animation: true,
                  animateFromLastPercent: true,
                  lineHeight: 40.0,
                  animationDuration: 1000,
                  percent: indiDeger,
                  center: soruSayac != 5 ? Text("Kelime ${soruSayac+1}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white60),) :
                  Text("Kelime 5",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white60),),
                  barRadius: const Radius.circular(22),
                  progressColor: Colors.green,
                ),
              ],
            ))),
            Expanded(flex: 20, child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white60, width: 10),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.indigo,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                    Text("$soruText",style: GoogleFonts.hammersmithOne(textStyle: TextStyle(fontSize: ekranGenisligi/10, fontWeight: FontWeight.bold, color: Colors.white) )),
                ],
              )),
            )),
            Expanded(flex: 60, child:Padding(padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 60,width: ekranGenisligi*0.75,
                      child: ElevatedButton(
                        child:  Text(buttonAyazi),
                        style: ElevatedButton.styleFrom(
                          primary: secildi ? dogruSoru.kelime_tr==buttonAyazi ?  Colors.green: secilenButton=="buttonA" ? Colors.deepOrange : Colors.blueGrey : Colors.blueGrey,
                          textStyle: GoogleFonts.courierPrime(textStyle: TextStyle(fontSize: ekranGenisligi/14, fontWeight: FontWeight.bold, color: Colors.deepPurple) ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onPressed:(){
                          if(secildi == false){
                            dogruKontrol(buttonAyazi);
                            setState(() {
                              secildi = true;
                              secilenButton ="buttonA";
                            });
                            print("dogruSayac = $dogruSayac");
                            print("yanlisSayac = $yanlisSayac");
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 60,width: ekranGenisligi*0.75,
                      child: ElevatedButton(
                        child: Text(buttonByazi),
                        style: ElevatedButton.styleFrom(
                          primary: secildi ? dogruSoru.kelime_tr==buttonByazi ? Colors.green: secilenButton=="buttonB" ? Colors.deepOrange : Colors.blueGrey : Colors.blueGrey,
                          textStyle: GoogleFonts.courierPrime(textStyle: TextStyle(fontSize: ekranGenisligi/14, fontWeight: FontWeight.bold, color: Colors.deepPurple) ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onPressed: (){
                          if(secildi==false){
                            dogruKontrol(buttonByazi);
                            setState(() {
                              secildi = true;
                              secilenButton ="buttonB";
                            });
                            print("dogruSayac = $dogruSayac");
                            print("yanlisSayac = $yanlisSayac");
                          }
                        },
                      ),
                    ),

                    SizedBox(height: 60,width: ekranGenisligi*0.75,
                      child: ElevatedButton(
                        child: Text(buttonCyazi),
                        style: ElevatedButton.styleFrom(
                          primary: secildi ? dogruSoru.kelime_tr==buttonCyazi ? Colors.green: secilenButton=="buttonC" ? Colors.deepOrange : Colors.blueGrey : Colors.blueGrey,
                          textStyle: GoogleFonts.courierPrime(textStyle: TextStyle(fontSize: ekranGenisligi/14, fontWeight: FontWeight.bold, color: Colors.deepPurple) ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onPressed: (){
                         if(secildi==false){
                           dogruKontrol(buttonCyazi);
                           setState(() {
                             secildi = true;
                             secilenButton ="buttonC";
                           });
                           print("dogruSayac = $dogruSayac");
                           print("yanlisSayac = $yanlisSayac");
                         }
                        },
                      ),
                    ),
                    SizedBox(height: 60,width: ekranGenisligi*0.75,
                      child: ElevatedButton(
                        child: Text(buttonDyazi),
                        style: ElevatedButton.styleFrom(
                          primary: secildi ? dogruSoru.kelime_tr==buttonDyazi ? Colors.green: secilenButton=="buttonD" ? Colors.deepOrange : Colors.blueGrey : Colors.blueGrey,
                          textStyle: GoogleFonts.courierPrime(textStyle: TextStyle(fontSize: ekranGenisligi/14, fontWeight: FontWeight.bold, color: Colors.deepPurple) ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onPressed: (){
                          if(secildi==false){
                            dogruKontrol(buttonDyazi);
                            setState(() {
                              secildi = true;
                              secilenButton ="buttonD";
                            });
                            print("dogruSayac = $dogruSayac");
                            print("yanlisSayac = $yanlisSayac");
                          }
                        },
                      ),
                    ),
                  ],
                ),),),
            Expanded(flex: 15, child: Container(child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("Resimler/dusunurGif.gif"),
                Image.asset("Resimler/dusunurGif2.gif"),
              ],
            ))),
          ],
        ),
      ),
      floatingActionButton: SizedBox( height: 90, width:90 ,
        child: FloatingActionButton(
          onPressed: () {
            secildi =false;
            secilenButton="";
            soruSayacKontrol();
          },
          backgroundColor: Colors.green,
          child:  Container(child: Image.asset("Resimler/onayIcon.png")),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
