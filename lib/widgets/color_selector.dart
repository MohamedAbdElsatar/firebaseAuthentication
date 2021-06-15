import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ColorSelector extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0Xffffff),
      body: Container(
        margin: EdgeInsets.all(50),
        child: Neumorphic(
            drawSurfaceAboveChild: true,
            style: NeumorphicStyle(
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                depth: -25,
                // shadowLightColorEmboss: Colors.grey.shade800,
                // shadowDarkColorEmboss: Colors.grey.shade800,
               border: NeumorphicBorder(
               ),
                intensity: .2,
                lightSource: LightSource.bottom,
                color: Colors.grey.shade800),
            child: Container(child: TextFormField())),
      ),
    );
  }
}
