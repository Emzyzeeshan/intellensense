import 'dart:async';
import 'dart:math';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intellensense/HomeScreen_Pages/HomeScreen.dart';
import 'package:intellensense/LoginPages/mainLoginScreen.dart';
import 'package:intellensense/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashAnimation extends StatefulWidget {
  @override
  State<SplashAnimation> createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _radiusanimationController;
  late Animation<double> _rotationanimationController;
     var newuser;
  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Timer(
        Duration(seconds: 6),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                curve: Curves.fastEaseInToSlowEaseOut,
                alignment: Alignment(
                    -_animationController.value, _animationController.value),
                duration: Duration(seconds: 6),
                type: PageTransitionType.scale,
                child: HomeScreen()
                // mainLoginScreen(
                //   screenHeight: MediaQuery.of(context).size.height,
                // )
                )));
      // Navigator.pushReplacement(
      //     context, new MaterialPageRoute(builder: (context) => HomeScreen()));
    }else if(newuser==true){
        Timer(
        Duration(seconds: 6),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                curve: Curves.fastEaseInToSlowEaseOut,
                alignment: Alignment(
                    -_animationController.value, _animationController.value),
                duration: Duration(seconds: 6),
                type: PageTransitionType.scale,
                child: 
                mainLoginScreen(
                  screenHeight: MediaQuery.of(context).size.height,
                )
                )));
    }
  }
  @override
  void initState() {
        check_if_already_login();
    //animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1300),
    )..forward();

    //rotation animation
    _rotationanimationController = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    //radius animation
    _radiusanimationController = Tween(begin: 450.0, end: 10.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _animationController.addListener(() {
      setState(() {});
    });

    //animation back and forward
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
    
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: AnimatedContainer(
        duration: Duration(milliseconds: 700),
        child: Center(
            child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: _rotationanimationController.value,
              child: Container(
                height: 275,
                width: 275,
                decoration: BoxDecoration(
                    color: Color(0xFF063fc7),
                    borderRadius:
                        BorderRadius.circular(_radiusanimationController.value),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF063fc7).withOpacity(0.8),
                          offset: Offset(-0.6, 6.0)),
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0.6, 6.0)),
                    ]),
              ),
            ),
            Transform.rotate(
              angle: _rotationanimationController.value + 0.2,
              child: Container(
                height: 225,
                width: 225,
                decoration: BoxDecoration(
                    color: Color(0xff366bf8),
                    borderRadius:
                        BorderRadius.circular(_radiusanimationController.value),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff366bf8).withOpacity(0.8),
                          offset: Offset(-0.6, 6.0)),
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0.6, 6.0)),
                    ]),
              ),
            ),
            Transform.rotate(
              angle: _rotationanimationController.value + 0.4,
              child: Container(
                height: 175,
                width: 175,
                decoration: BoxDecoration(
                    color: Color(0xFF6d96fa),
                    borderRadius:
                        BorderRadius.circular(_radiusanimationController.value),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF6d96fa).withOpacity(0.8),
                          offset: Offset(-0.6, 6.0)),
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0.6, 6.0)),
                    ]),
              ),
            ),
            Transform.rotate(
              angle: pi * 12,
              child: Container(
                height: 125,
                width: 125,
                decoration: BoxDecoration(
                    color: Color(0xFFD1C4E9),
                    borderRadius:
                        BorderRadius.circular(_radiusanimationController.value),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFFD1C4E9).withOpacity(0.8),
                          offset: Offset(-0.6, 6.0)),
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0.6, 6.0)),
                    ]),
                child: Center(
                    child: Transform.translate(
                        offset: Offset(-0.6, 0.6),
                        // scale: _animationController.value,
                        child: Image.asset(
                            'assets/icons/IntelliSense-Logo-Finall.gif'))),
              ),
            ),
            //  Transform.rotate(
            //   angle: _rotationanimationController.value + 0.8,
            //   child: Container(
            //     height: 25,
            //     width: 25,
            //     decoration: BoxDecoration(
            //         color: Color(0xFFEDE7F6),
            //         borderRadius:
            //             BorderRadius.circular(_radiusanimationController.value),
            //                boxShadow: [
            //           BoxShadow(
            //               color: Color(0xFFEDE7F6).withOpacity(0.8),
            //               offset: Offset(-0.6, 6.0)),
            //           BoxShadow(
            //               color: Colors.black.withOpacity(0.1),
            //               offset: Offset(0.6, 6.0)),
            //         ]),
            //   ),
            // ),
          ],
        )),
      ),
    );
  }
}
