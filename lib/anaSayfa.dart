import 'package:flutter/material.dart';
import 'package:lattoli/Sayafalar/ayarlar.dart';
import 'package:lattoli/Sayafalar/kelimeEkle.dart';
import 'package:lattoli/Sayafalar/profil.dart';
import 'package:lattoli/Sayafalar/tumKelimeler.dart';
import 'package:lattoli/main.dart';

class anaSayfa extends StatefulWidget {
  @override
  _anaSayfaState createState() => _anaSayfaState();
}

class _anaSayfaState extends State<anaSayfa> {

  int curretTab = 4;
  final List<Widget> screens = [
    ayarlar(),
    kelimeEkle(),
    profil(),
    tumKelimeler()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = MyHomePage();
  @override
  Widget build(BuildContext context) {
    bool klavyeDurum = MediaQuery.of(context).viewInsets.bottom !=0;
    return Scaffold(

      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton:  Visibility(
        visible: !klavyeDurum,
        child: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.account_balance),
          onPressed: (){
            setState(() {
              currentScreen = MyHomePage();
              curretTab = 4;
            });

          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget> [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
               // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = kelimeEkle();
                        curretTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                         Icons.add,size:30,
                         color: curretTab ==0 ? Colors.deepPurple : Colors.grey,
                        ),
                        Text("Ekle",style: TextStyle(color: curretTab==0?Colors.deepPurple:Colors.grey),),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = tumKelimeler();
                        curretTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.list_alt_outlined,size: 30,
                          color: curretTab ==1 ? Colors.deepPurple : Colors.grey,
                        ),
                        Text("Kelimeler",style: TextStyle(color: curretTab == 1 ?Colors.deepPurple:Colors.grey),),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = profil();
                        curretTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_circle,size: 30,
                          color: curretTab ==2 ? Colors.deepPurple : Colors.grey,
                        ),
                        Text("Profil",style: TextStyle(color: curretTab==2?Colors.deepPurple:Colors.grey),),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = ayarlar();
                        curretTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,size: 30,
                          color: curretTab ==3 ? Colors.deepPurple : Colors.grey,
                        ),
                        Text("Ayarlar",style: TextStyle(color: curretTab==3?Colors.deepPurple:Colors.grey),),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
