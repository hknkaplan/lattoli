import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lattoli/buttonGiris.dart';
import 'anaSayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: anaSayfa(), //const MyHomePage(title: 'Lattoli'),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {


        var ekranBilgisi = MediaQuery.of(context);
        final double ekranYuksekligi = ekranBilgisi.size.height;
        final double ekranGenisligi = ekranBilgisi.size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      /*appBar: AppBar(
        title: Text(widget.title),
      ),*/
      body: Padding(
        padding: EdgeInsets.only(bottom:ekranYuksekligi/15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding:  EdgeInsets.only(top:ekranYuksekligi/20,left:ekranGenisligi/20 ,right:ekranGenisligi/20 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Text("Lattoli",style: TextStyle(fontSize: ekranGenisligi/15, fontWeight: FontWeight.bold, color: Colors.deepPurple), ),
                  Text("Lattoli",style: GoogleFonts.oleoScript(textStyle: TextStyle(fontSize: ekranGenisligi/10, fontWeight: FontWeight.bold, color: Colors.deepPurple) )),

                  //Icon(Icons.settings,size: ekranGenisligi/10,),
                ],
              ),
            ),
            //Icon(Icons.supervised_user_circle,size: ekranGenisligi/2,),
            SizedBox(height: ekranYuksekligi/2, child: Image.asset("Resimler/latif.png")),
            const Padding(
              padding:  EdgeInsets.only(bottom: 25.0),
              child: GlowingButton(
                color1: Colors.orange,
                color2: Colors.red,
              ),
            ),

          ],
        ),
      ),

    );
  }
}
