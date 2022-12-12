import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lattoli/Modeller/Kelimeler.dart';
import 'package:lattoli/Modeller/Kelimelerdao.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class tumKelimeler extends StatefulWidget {
  @override
  _tumKelimelerState createState() => _tumKelimelerState();
}

class _tumKelimelerState extends State<tumKelimeler> {


  bool aramaYapiliyormu=false;
  String arananKelime ="";

  var tfkelimeIng = TextEditingController();
  var tfkelimeTr = TextEditingController();
  var tfkelimeAciklama = TextEditingController();


  Future<List<Kelimeler>> tumkelime() async{
    List<Kelimeler> kelimeListesi = await  Kelimelerdao().tumkelimeler();
    return kelimeListesi;
  }
  Future<List<Kelimeler>> aranankelime(String arananK) async{
    var kelimeListesi = await Kelimelerdao().arananKelime(arananK);
    return kelimeListesi;
  }

  //Başarı oranı hesaplama
  Widget hesapla(Kelimeler gelenK) {
    int oran = 0;
    if(gelenK.kelime_goruntulenme!=0){
      oran = ((100*gelenK.kelime_dogruC)~/gelenK.kelime_goruntulenme).toInt();
      //return  Text("%${oran.toString()}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.green),);
      return  Container(child:  CircularPercentIndicator(
        radius: 20.0,
        lineWidth: 5.0,
        animation: true,
        percent: oran/100,
        center:  Text("$oran",style: TextStyle(fontSize: 15),),
        progressColor: Colors.green,
      ));
    }else{
      return Icon(Icons.visibility,size: 30,color: Colors.indigoAccent,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: aramaYapiliyormu ?
            TextField(
              decoration: const InputDecoration(hintText: "Kelime Girin",hintStyle: TextStyle(color: Colors.white60,fontSize: 20),
              ),
              style: const TextStyle(color: Colors.white,fontSize: 20),
              onChanged: (aramasonucu){
                setState(() {
                  arananKelime = aramasonucu;
                });
              },
            )
            : Text("Kelimeler"),
        actions: [
          aramaYapiliyormu ?
            IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: (){
              setState(() {
                aramaYapiliyormu = false;
              });
            },
          )
              :
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: (){
              setState(() {
                aramaYapiliyormu = true;
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Kelimeler>>(
        future: aramaYapiliyormu ? aranankelime(arananKelime) : tumkelime(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var kelimeList = snapshot.data;
            return ListView.builder(
              itemCount: kelimeList!.length,
              itemBuilder: (context,indeks){
                var kelime = kelimeList[indeks];
                return SizedBox( height: 60,
                  child: Card(
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded( flex: 5, child: Container()),
                        Expanded( flex: 20, child: Container(
                          child: SingleChildScrollView(scrollDirection:Axis.horizontal,
                              child: Text(kelime.kelime_ing,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                        )),
                        Expanded( flex: 20, child: Container(
                          child:SingleChildScrollView(scrollDirection:Axis.horizontal,
                              child: Text(kelime.kelime_tr,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.grey),)),
                        )),
                        //Expanded( flex: 10, child: Container()),
                        Expanded( flex: 10, child: Container(
                          child: hesapla(kelime),
                        )),
                            IconButton(onPressed: (){
                              tfkelimeIng.text=kelime.kelime_ing;
                              tfkelimeTr.text=kelime.kelime_tr;
                              tfkelimeAciklama.text=kelime.kelime_aciklama;

                                        showDialog(
                                         context: context,
                                          builder: (BuildContext context){
                                           return Padding(
                                             padding: const EdgeInsets.symmetric(vertical: 10),
                                             child: SingleChildScrollView(
                                               child: AlertDialog(
                                                 title: Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                   Text("Kelime Detay",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple,fontSize: 25),),
                                                    IconButton(
                                                      icon: Icon(Icons.cancel,color: Colors.blue,size: 30,),
                                                      onPressed: (){
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                 ],),
                                                 content: Column(
                                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                   children: [
                                                     TextField(
                                                       controller: tfkelimeIng,
                                                       style: const  TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                                                       textCapitalization: TextCapitalization.sentences,
                                                       textAlign: TextAlign.center,
                                                       decoration: const InputDecoration(
                                                           prefixIcon: Icon(Icons.translate),
                                                           hintStyle: TextStyle(fontSize: 25),
                                                           border: OutlineInputBorder(
                                                             borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                           )
                                                       ),
                                                     ),
                                                     TextField(
                                                       controller: tfkelimeTr,
                                                       style: const  TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                                                       textCapitalization: TextCapitalization.sentences,
                                                       textAlign: TextAlign.center,
                                                       decoration: const InputDecoration(
                                                           prefixIcon: Icon(Icons.emoji_flags),
                                                           hintStyle: TextStyle(fontSize: 25),
                                                           border: OutlineInputBorder(
                                                             borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                           )
                                                       ),
                                                     ),
                                                     TextField(
                                                       controller: tfkelimeAciklama,
                                                       style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                                                       textCapitalization: TextCapitalization.sentences,
                                                       textAlign: TextAlign.center,
                                                       decoration: const InputDecoration(
                                                           prefixIcon: Icon(Icons.email_rounded),
                                                           hintStyle: TextStyle(fontSize: 25),
                                                           border: OutlineInputBorder(
                                                             borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                           )
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                                 actions: [
                                                   Padding(
                                                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                     child: ElevatedButton(
                                                       style: ElevatedButton.styleFrom(
                                                         primary: Colors.amber,
                                                       ),
                                                       child: Row( children: const [Spacer(),Text("Güncelle"),Spacer(),Icon(Icons.update),Spacer(),],),
                                                       onPressed: (){
                                                          setState(() {
                                                            Kelimelerdao().kelimeGuncelle(kelime.kelime_id, tfkelimeIng.text, tfkelimeTr.text, tfkelimeAciklama.text);
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(
                                                                  content: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    children: [
                                                                      Text("${tfkelimeIng.text} Güncellendi.",style: TextStyle(fontSize: 20),),
                                                                      const Icon(Icons.update,size: 30,color: Colors.white,),
                                                                    ],
                                                                  ),
                                                                  duration: Duration(seconds: 3),
                                                                ));
                                                            Navigator.pop(context);
                                                          });
                                                       },
                                                     ),
                                                   ),
                                                   Padding(
                                                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                     child: ElevatedButton(
                                                       style: ElevatedButton.styleFrom(
                                                         primary: Colors.black12,
                                                       ),
                                                       child: Center(child: Row(children: const [Spacer(),Text("Kelimeyi Sil"),Spacer(),Icon(Icons.delete_forever),Spacer(),],)),

                                                       onPressed: (){
                                                            setState(() {
                                                              Kelimelerdao().kelimeSil(kelime.kelime_id);
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                  SnackBar(
                                                                    content: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                      children: [
                                                                        Text("${tfkelimeIng.text} Silindi..",style: TextStyle(fontSize: 20),),
                                                                        const Icon(Icons.delete,size: 30,color: Colors.white,),
                                                                      ],
                                                                    ),
                                                                    duration: Duration(seconds: 3),
                                                                  ));
                                                              Navigator.pop(context);
                                                            });
                                                       },
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             ),
                                           );
                                          }
                                        );
                                      },
                              icon: const Icon(Icons.translate,size: 30,color: Colors.deepOrange,),),
                        Expanded( flex: 2, child: Container()),
                      ],
                    ),
                  ),
                );
              },
            );
          }else{
            return const Center(
              child: Text("Veri Yok"),
            );
          }
        },
      ),
    );
  }
}
