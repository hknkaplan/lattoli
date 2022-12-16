import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ayarlar extends StatefulWidget {
  @override
  _ayarlarState createState() => _ayarlarState();
}


class _ayarlarState extends State<ayarlar> {

   double sliderDeger=10.0;

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;
    return  Scaffold(
      appBar: AppBar( backgroundColor: Colors.deepPurple,
        title: Center(child: Text("Ayarlar")),
      ),
      body: Padding(padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(flex: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(flex: 20, child: Padding(padding: const EdgeInsets.only(right: 10), child: SizedBox(width:ekranGenisligi,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blueGrey[100]
                        ) ,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Soru Türü",style: TextStyle(fontSize: ekranGenisligi/18),),


                          ],
                        )
                    ),
                  ),),),
                  Expanded(flex: 20, child: Padding(padding: const EdgeInsets.only(left:10), child: SizedBox(width:ekranGenisligi,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blueGrey[100]
                        ) ,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Yanlış Cevapları Tekrarla",style: TextStyle(fontSize: ekranGenisligi/18),),
                          ],
                        )
                    ),
                  ),),),
                ],
              ),
            ),
            Expanded(flex: 20, child: Padding(padding: const EdgeInsets.symmetric(vertical: 15), child: SizedBox(width:ekranGenisligi,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueGrey[100]
                    ) ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Soru Sayısı",style: TextStyle(fontSize: ekranGenisligi/15),),
                        Text("${sliderDeger.toInt()}",style: TextStyle(fontSize: ekranGenisligi/15,fontWeight: FontWeight.bold,color: Colors.blue),),
                        Slider(
                          value: sliderDeger,
                          onChanged: (value){
                            setState(() => sliderDeger = value );
                          },
                          min:10.0,
                          max: 50.0,
                          divisions: 4,
                          //label: "${sliderDeger.toInt()}",

                        ),
                      ],
                    )
                  ),
                ),),),
            Expanded(flex: 20, child: Padding(padding: const EdgeInsets.only(bottom: 40), child: SizedBox(width:ekranGenisligi,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueGrey[100]
                  ) ,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomSlidingSegmentedControl<int>(
                        initialValue: 2,
                        children: const {
                          1: Text('News daily portal'),
                          2: Text('Map'),
                          3: Text('Paper'),
                        },
                        decoration: BoxDecoration(
                          color: CupertinoColors.lightBackgroundGray,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        thumbDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              blurRadius: 4.0,
                              spreadRadius: 1.0,
                              offset: const Offset(0.0, 2.0,),
                            ),
                          ],
                        ),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInToLinear,
                        onValueChanged: (v) {
                          print(v);
                        },
                      ),
                    ],
                  )
              ),
            ),),),
          ],
        ),
      ),
    );
  }
}
