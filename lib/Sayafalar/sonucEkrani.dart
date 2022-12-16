import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lattoli/Sayafalar/sinavEkrani.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class sonucEkrani extends StatefulWidget {
  int gelenDogru;
  int gelenYanlis;
  int gelenSure;
  int gelenSoruS;
  sonucEkrani(
      this.gelenDogru, this.gelenYanlis, this.gelenSure, this.gelenSoruS);

  @override
  _sonucEkraniState createState() => _sonucEkraniState();
}


class _sonucEkraniState extends State<sonucEkrani> {



  Widget indiSonuc(String text ,int deger,bool sure, MaterialColor renk ) {
      return  Container(child:  CircularPercentIndicator(
        radius: 60.0,
        lineWidth: 10.0,
        animation: true,
        percent: sure ? 1 :deger/widget.gelenSoruS,
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(sure ? "${Duration(seconds: widget.gelenSure).inMinutes.remainder(60)} : ${Duration(seconds: widget.gelenSure).inSeconds.remainder(60)}"  :
            "$deger",style: GoogleFonts.hammersmithOne(textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: renk) )),
             Text("$text",style: GoogleFonts.hammersmithOne(textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: renk) )),
        ]),
        progressColor: renk,
      ));
  }

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;

    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded( flex: 10,
              child: Container(
                child: Text("Daha çok çalıs.",style: GoogleFonts.kdamThmor(textStyle: TextStyle(fontSize: ekranGenisligi/15, fontWeight: FontWeight.bold, color: Colors.grey) )),
              ),
            ),
            Expanded(flex: 40,
              child: Container(
                child: Image.asset("Resimler/latif.png"),
              ),
            ),
            Expanded(flex: 30,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    indiSonuc("Dogru",widget.gelenDogru,false, Colors.green),
                    indiSonuc("Yanlış",widget.gelenYanlis,false, Colors.deepOrange),
                    indiSonuc("Dakika",widget.gelenSure,true, Colors.blueGrey),
                  ],
                ),
              ),
            ),
            Expanded(flex: 10,
              child: Container(
                child: ElevatedButton(
                  child: const Text("TEKRAR DENE"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    textStyle: GoogleFonts.rubikPuddles(textStyle: TextStyle(fontSize: ekranGenisligi/12, fontWeight: FontWeight.bold, color: Colors.deepPurple) ),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => sinavEkrani()));
                  },

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
