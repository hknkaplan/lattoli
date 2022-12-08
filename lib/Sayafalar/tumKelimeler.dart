import 'package:flutter/material.dart';
import 'package:lattoli/Modeller/Kelimeler.dart';
import 'package:lattoli/Modeller/Kelimelerdao.dart';

class tumKelimeler extends StatefulWidget {
  @override
  _tumKelimelerState createState() => _tumKelimelerState();
}

class _tumKelimelerState extends State<tumKelimeler> {


  bool aramaYapiliyormu=false;
  String arananKelime ="";

  Future<List<Kelimeler>> tumkelime() async{
    print("geldş2");
    var kelimeListesi = await Kelimelerdao().tumkelimeler();
    print("geldş23");
    return kelimeListesi;
  }
  Future<List<Kelimeler>> aranankelime(String arananK) async{
    var kelimeListesi = await Kelimelerdao().arananKelime(arananK);
    return kelimeListesi;
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
                return SizedBox( height: 50,
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(kelime.kelime_ing,style: const TextStyle(fontWeight: FontWeight.bold),),
                        Text(kelime.kelime_tr),
                        IconButton(
                          onPressed: (){

                          },
                          icon: const Icon(Icons.add),
                        )
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
