import 'package:flutter/material.dart';

class GlowingButton extends StatefulWidget {
  final Color color1;
  final Color color2;

  const GlowingButton(
      {Key? key, this.color1 = Colors.cyan, this.color2 = Colors.greenAccent})
      : super(key: key);
  @override
  _GlowingButtonState createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<GlowingButton> {
  var glowing = true;
  var scale = 1.0;
  @override
  Widget build(BuildContext context) {

    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;

    //On mobile devices, gesture detector is perfect
    //However for desktop and web we can show this effect on hover too
    return GestureDetector(
      onTapUp: (val) {
        setState(() {
          print("geç");

          //glowing = false;
          //scale = 1.0;
        });
      },
      onTapDown: (val) {
        setState(() {
          print("geç");
          //glowing = true;
          //scale = 1.1;
        });
      },
      child: AnimatedContainer(
        transform: Matrix4.identity()..scale(scale),
        duration: Duration(milliseconds: 200),
        height: ekranYuksekligi/15,
        width: ekranGenisligi*(0.6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: LinearGradient(
              colors: [
                widget.color1,
                widget.color2,
              ],
            ),
            boxShadow: glowing
                ? [
              BoxShadow(
                color: widget.color1.withOpacity(0.6),
                spreadRadius: 1,
                blurRadius: 16,
                offset: Offset(-8, 0),
              ),
              BoxShadow(
                color: widget.color2.withOpacity(0.6),
                spreadRadius: 1,
                blurRadius: 16,
                offset: Offset(8, 0),
              ),
              BoxShadow(
                color: widget.color1.withOpacity(0.2),
                spreadRadius: 16,
                blurRadius: 32,
                offset: Offset(-8, 0),
              ),
              BoxShadow(
                color: widget.color2.withOpacity(0.2),
                spreadRadius: 16,
                blurRadius: 32,
                offset: Offset(8, 0),
              )
            ]
                : []),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           /* Icon(
              glowing ? Icons.lightbulb : Icons.lightbulb_outline,
              color: Colors.white,
            ),*/
            Text(
              glowing ? "BAŞLA" : "BAŞLA",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}