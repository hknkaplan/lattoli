
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../Modeller/Kelimeler.dart';

class sinavEkrani extends StatefulWidget {
  @override
  _sinavEkraniState createState() => _sinavEkraniState();
}

class _sinavEkraniState extends State<sinavEkrani> {
  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;

    //SAYFA DEĞİŞKENLERİ
    var inciSoru = 1;
    var secenekSayisi = 4;
    bool secilenButon1 = false;





    Future<List<Kelimeler>> cevapGetir() async{
     var cevaplarList = <Kelimeler>[];
     cevaplarList.add(Kelimeler(1, "kelime_ing", "kelime_tr", "kelime_aciklama", 1, 1, 1));
     cevaplarList.add(Kelimeler(1, "kelime_ing", "kelime_tr", "kelime_aciklama", 1, 1, 1));
     cevaplarList.add(Kelimeler(1, "kelime_ing", "kelime_tr", "kelime_aciklama", 1, 1, 1));
     cevaplarList.add(Kelimeler(1, "kelime_ing", "kelime_tr", "kelime_aciklama", 1, 1, 1));
     return cevaplarList;
    }


    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Text("Lattoli",style: GoogleFonts.oleoScript(textStyle: TextStyle(fontSize: ekranGenisligi/10, fontWeight: FontWeight.bold,) )),
              Text("5:20",style: GoogleFonts.kdamThmor(textStyle: TextStyle(fontSize: ekranGenisligi/12, fontWeight: FontWeight.bold, color: Colors.grey) )),
            ]),

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
                  lineHeight: 40.0,
                  animationDuration: 2500,
                  percent: 0.7,
                  center: const Text("Kelime 10",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white60),),
                  barRadius: const Radius.circular(22),
                  progressColor: Colors.green,
                ),
/*
                 Text("Kelime $inciSoru",style: GoogleFonts.signikaNegative(textStyle: TextStyle(fontSize: ekranGenisligi/12, fontWeight: FontWeight.bold, color: Colors.blue) )),
                Text("5:20",style: GoogleFonts.kdamThmor(textStyle: TextStyle(fontSize: ekranGenisligi/12, fontWeight: FontWeight.bold, color: Colors.grey) )),*/
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
                    Text("Enginer",style: GoogleFonts.hammersmithOne(textStyle: TextStyle(fontSize: ekranGenisligi/10, fontWeight: FontWeight.bold, color: Colors.white) )),
                ],
              )),
            )),
            Expanded(flex: 60, child:Padding(padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 60,width: ekranGenisligi*0.75,
                      child: ElevatedButton(
                        child: const Text("Bilgisayar"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey,
                          textStyle: GoogleFonts.courierPrime(textStyle: TextStyle(fontSize: ekranGenisligi/14, fontWeight: FontWeight.bold, color: Colors.deepPurple) ),
                          //shadowColor: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onPressed: (){

                        },

                      ),
                    ),
                    SizedBox(height: 60,width: ekranGenisligi*0.75,
                      child: ElevatedButton(
                        child: const Text("Otobüs"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey,
                          textStyle: GoogleFonts.courierPrime(textStyle: TextStyle(fontSize: ekranGenisligi/14, fontWeight: FontWeight.bold, color: Colors.deepPurple) ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onPressed: (){

                        },

                      ),
                    ),

                    SizedBox(height: 60,width: ekranGenisligi*0.75,
                      child: ElevatedButton(
                        child: const Text("Araba"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey,
                          textStyle: GoogleFonts.courierPrime(textStyle: TextStyle(fontSize: ekranGenisligi/14, fontWeight: FontWeight.bold, color: Colors.deepPurple) ),
                          shadowColor: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onPressed: (){

                        },

                      ),
                    ),
                    SizedBox(height: 60,width: ekranGenisligi*0.75,
                      child: ElevatedButton(
                        child: const Text("Car"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey,
                          textStyle: GoogleFonts.courierPrime(textStyle: TextStyle(fontSize: ekranGenisligi/14, fontWeight: FontWeight.bold, color: Colors.deepPurple) ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onPressed: (){

                        },

                      ),
                    ),
                  ],
                ),
              ),),
            Expanded(flex: 15, child: Container(child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("Resimler/dusunurGif.gif"),
                Image.asset("Resimler/dusunurGif2.gif"),
                /*
                Text("Kelime $inciSoru",style: GoogleFonts.signikaNegative(textStyle: TextStyle(fontSize: ekranGenisligi/12, fontWeight: FontWeight.bold, color: Colors.blue) )),
                Text("5:20",style: GoogleFonts.kdamThmor(textStyle: TextStyle(fontSize: ekranGenisligi/12, fontWeight: FontWeight.bold, color: Colors.grey) )),
                 */
              ],
            ))),
          ],
        ),
      ),
      floatingActionButton: SizedBox( height: 90, width:90 ,
        child: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          backgroundColor: Colors.green,
          child:  Container(child: Image.asset("Resimler/onayIcon.png")),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
