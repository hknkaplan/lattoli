import 'package:lattoli/Modeller/Kelimeler.dart';
import 'package:lattoli/Modeller/VeritabaniYardimcisi.dart';

class Kelimelerdao{

  //Tüm kelimeleri getirme fonksiyonu
  Future<List<Kelimeler>> tumkelimeler() async {

    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler");

    return List.generate(maps.length, (i){
      var satir = maps[i];
      return Kelimeler(satir["kelime_id"], satir["kelime_ing"], satir["kelime_tr"], satir["kelime_aciklama"], satir["kelime_goruntulenme"], satir["kelime_dogruC"], satir["kelime_yanlisC"]);
    });
  }

  // Aranan Kelimeleri getiren fonksiyon
  Future<List<Kelimeler>> arananKelime(String arananK) async {

    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler WHERE kelime_ing OR kelime_tr like '%$arananK%'");

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


}