import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lattoli/Modeller/Kelimelerdao.dart';

class kelimeEkle extends StatefulWidget {
  @override
  _kelimeEkleState createState() => _kelimeEkleState();
}

class _kelimeEkleState extends State<kelimeEkle> {

  Future<void> ekle(String kelime_ing,String kelime_tr,String kelime_aciklama)async{
    await Kelimelerdao().kelimeEkle(kelime_ing, kelime_tr, kelime_aciklama);
  }

  var kelimeIng = TextEditingController();
  var kelimeTr = TextEditingController();
  var kelimeAciklama = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Kelime Ekle"),
        actions: [
          IconButton(
              icon: const Icon(Icons.assignment_turned_in,size: 40,),
            onPressed: (){
                if(kelimeIng.text!=""&&kelimeTr.text!=""){
                  ekle(kelimeIng.text, kelimeTr.text, kelimeAciklama.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:const [
                            Text("Kelime Eklendi.",style: TextStyle(fontSize: 20,color: Colors.green),),
                            Icon(Icons.where_to_vote,size: 30,color: Colors.white,),
                          ],
                        ),
                        duration: Duration(seconds: 3),
                      ));
                  kelimeIng.text="";
                  kelimeTr.text="";
                  kelimeAciklama.text="";
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:const [
                            Text("Kelime girişi boş bırakılamaz.",style: TextStyle(fontSize: 20),),
                            Icon(Icons.error,size: 30,color: Colors.white,),
                          ],
                        ),
                        duration: Duration(seconds: 3),
                      ));
                }

            },
          ),
        ],
      ),
      body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
           Expanded(flex: 25, child: Container(child: Image.asset("Resimler/bayraklar.png"))),
           Expanded(flex: 75,child: Container(child:Padding(
             padding:  EdgeInsets.symmetric(horizontal: ekranGenisligi/9),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 TextField(
                   controller: kelimeIng,
                   style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                   textCapitalization: TextCapitalization.sentences,
                   textAlign: TextAlign.center,
                   decoration: const InputDecoration(
                     prefixIcon: Icon(Icons.translate),
                     hintText: "Yeni Kelime",
                     hintStyle: TextStyle(fontSize: 25),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
                     )
                   ),
                 ),
                 TextField(
                   controller: kelimeTr,
                   style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                   textCapitalization: TextCapitalization.sentences,
                   textAlign: TextAlign.center,
                   decoration: const InputDecoration(
                       prefixIcon: Icon(Icons.emoji_flags),
                       hintText: "Türkçe Anlamı",
                       hintStyle: TextStyle(fontSize: 25),
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
                       )
                   ),
                 ),
                 TextField(
                   controller: kelimeAciklama,
                   style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                   textCapitalization: TextCapitalization.sentences,
                   textAlign: TextAlign.center,
                   decoration: const InputDecoration(
                       prefixIcon: Icon(Icons.email_rounded),
                       hintText: "Açıklama",
                       hintStyle: TextStyle(fontSize: 25),
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
                       )
                   ),
                 ),
               ],
             ),
           ))),

         ],
       ),
      ),
    );
  }
}
