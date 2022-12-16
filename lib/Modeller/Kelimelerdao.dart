import 'package:lattoli/Modeller/Kelimeler.dart';
import 'package:lattoli/Modeller/VeritabaniYardimcisi.dart';

class Kelimelerdao{

  //Tüm kelimeleri getirme fonksiyonu
  Future<List<Kelimeler>> tumkelimeler() async {

    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler");

    return List.generate(maps.length, (i){
      var satir = maps[i];
      return Kelimeler(
          satir["kelime_id"],
          satir["kelime_ing"],
          satir["kelime_tr"],
          satir["kelime_aciklama"],
          satir["kelime_goruntulenme"],
          satir["kelime_dogruC"],
          satir["kelime_yanlisC"]);
    });
  }
  // Aranan Kelimeleri getiren fonksiyon
  Future<List<Kelimeler>> arananKelime(String arananK) async {

    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler WHERE kelime_ing like '%$arananK%' OR kelime_tr like '%$arananK%'");
     print(maps.length);
    return List.generate(maps.length, (i){
      var satir = maps[i];
      return Kelimeler(
          satir["kelime_id"],
          satir["kelime_ing"],
          satir["kelime_tr"],
          satir["kelime_aciklama"],
          satir["kelime_goruntulenme"],
          satir["kelime_dogruC"],
          satir["kelime_yanlisC"] );
    });
  }
  //Kelime ekleme fonksiyonu
  Future<void> kelimeEkle(String kelime_ing,String kelime_tr,String kelime_aciklama) async {

    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var veri = Map<String,dynamic>();
    veri["kelime_ing"]=kelime_ing;
    veri["kelime_tr"]=kelime_tr;
    veri["kelime_aciklama"]=kelime_aciklama;

    await db.insert("kelimeler", veri);
  }
//Kelime Silme fonksiyonu
  Future<void> kelimeSil(int kelime_id) async {

    var db = await VeritabaniYardimcisi.veritabaniErisim();

    await db.delete("kelimeler",where: "kelime_id = ?",whereArgs: [kelime_id]);
  }

  //Kelime Güncelleme fonksiyonu
  Future<void> kelimeGuncelle(int kelime_id,String kelime_ing,String kelime_tr,String kelime_aciklama) async {

    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var veri = Map<String,dynamic>();
    veri["kelime_ing"]=kelime_ing;
    veri["kelime_tr"]=kelime_tr;
    veri["kelime_aciklama"]=kelime_aciklama;

    await db.update("kelimeler", veri,where: "kelime_id = ?",whereArgs: [kelime_id]);

  }
  //Rasgele soru kelimesi getiren fonksiyon
  Future<List<Kelimeler>> rasgeleSoruGetir() async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler ORDER BY RANDOM() LIMIT 5");
    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Kelimeler(
          satir["kelime_id"],
          satir["kelime_ing"],
          satir["kelime_tr"],
          satir["kelime_aciklama"],
          satir["kelime_goruntulenme"],
          satir["kelime_dogruC"],
          satir["kelime_yanlisC"]);
    });
  }
  //Rasgele cevap kelimesi getiren fonksiyon
  Future<List<Kelimeler>> rasgele3YanlisGetir(int kelime_id) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler WHERE kelime_id != $kelime_id ORDER BY RANDOM() LIMIT 3");
    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Kelimeler(
          satir["kelime_id"],
          satir["kelime_ing"],
          satir["kelime_tr"],
          satir["kelime_aciklama"],
          satir["kelime_goruntulenme"],
          satir["kelime_dogruC"],
          satir["kelime_yanlisC"]);
    });
  }

  //Sınav anında kelimelerin dogru cevap ve yanlış cevap sutunlarını güncelleme
  Future<void> kelimeDurumGuncelle(int kelime_id,int kelime_dogruC,int kelime_yanlisC) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    await db.rawQuery("UPDATE kelimeler SET kelime_goruntulenme = kelime_goruntulenme + 1 , kelime_dogruC = kelime_dogruC + $kelime_dogruC , kelime_yanlisC = kelime_yanlisC + $kelime_yanlisC WHERE kelime_id = $kelime_id");

  }

}