import 'package:flutter/material.dart';
import 'dart:math';

import '../widgets/cat.dart';

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  Animation<double> boxAnimation;
  AnimationController catController;
  AnimationController boxController;

  initState() {
    super.initState();

    catController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this
    );

    boxController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this
    );

    catAnimation = Tween(begin: -35.0, end: -80.0)
      .animate(
        CurvedAnimation(
          parent: catController,
          curve: Curves.easeIn
        )
      );

    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65)
      .animate(
        CurvedAnimation(
          parent: boxController,
          curve: Curves.easeInOut
        )
      );

    boxAnimation.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        boxController.reverse();
      } else if(status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });
  }

  onTap() {
    if(catController.status == AnimationStatus.completed) {
      catController.reverse();
      boxController.forward();
    } else if(catController.status == AnimationStatus.dismissed) {
      catController.forward();
      boxController.stop();

    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation')
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: [
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
            ]
          )
        ),
        onTap: onTap
      )
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0.0, 
          left: 0.0
        );
      },
      child: Cat()
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0, 
      width: 200.0,
      color: Colors.brown
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          width: 125.0,
          height: 10.0,
          color: Colors.brown
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            angle: boxAnimation.value,
            alignment: Alignment.topLeft
          );
        }),
      left: 3.0,
      top: 3.0
    );
  }
  
  Widget buildRightFlap() {
    return Positioned(
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          width: 125.0,
          height: 10.0,
          color: Colors.brown
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            angle: -boxAnimation.value,
            alignment: Alignment.topRight
          );
        }),
      right: 3.0,
      top: 3.0
    );
  }
}