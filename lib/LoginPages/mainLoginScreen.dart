import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intellensense/HomeScreen_Pages/HomeScreen.dart';
import 'package:intellensense/LoginPages/widgets/custom_clippers/blue_top_clipper.dart';
import 'package:intellensense/LoginPages/widgets/custom_clippers/grey_top_clipper.dart';
import 'package:intellensense/LoginPages/widgets/custom_clippers/white_top_clipper.dart';
import 'package:intellensense/LoginPages/widgets/header.dart';
import 'package:intellensense/SignUpPages/SignUp.dart';
import 'package:intellensense/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/constants.dart';
import 'login.dart';

class mainLoginScreen extends StatefulWidget {
  final double screenHeight;

  const mainLoginScreen({
    required this.screenHeight,
  });

  @override
  _mainLoginScreenState createState() => _mainLoginScreenState();
}

class _mainLoginScreenState extends State<mainLoginScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _headerTextAnimation;
  late final Animation<double> _formElementAnimation;
  late final Animation<double> _whiteTopClipperAnimation;
  late final Animation<double> _blueTopClipperAnimation;
  late final Animation<double> _greyTopClipperAnimation;


  @override
  void initState() {
   
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: kLoginAnimationDuration,
    );

    final fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);
    _headerTextAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.0,
        0.6,
        curve: Curves.easeInOut,
      ),
    ));
    _formElementAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.7,
        1.0,
        curve: Curves.easeInOut,
      ),
    ));

    final clipperOffsetTween = Tween<double>(
      begin: widget.screenHeight,
      end: 0.0,
    );
    _blueTopClipperAnimation = clipperOffsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.2,
          0.7,
          curve: Curves.easeInOut,
        ),
      ),
    );
    _greyTopClipperAnimation = clipperOffsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.35,
          0.7,
          curve: Curves.easeInOut,
        ),
      ),
    );
    _whiteTopClipperAnimation = clipperOffsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.5,
          0.7,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: LayoutBuilder(
                builder: (BuildContext ctx, BoxConstraints constraints) {
              // if the screen width >= 480 i.e Wide Screen
              if (constraints.maxHeight > 640.0) {
                return Stack(
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: _whiteTopClipperAnimation,
                      builder: (_, Widget? child) {
                        return ClipPath(
                          clipper: WhiteTopClipper(
                            yOffset: _whiteTopClipperAnimation.value,
                          ),
                          child: child,
                        );
                      },
                      child: Container(color: kGrey),
                    ),
                    AnimatedBuilder(
                      animation: _greyTopClipperAnimation,
                      builder: (_, Widget? child) {
                        return ClipPath(
                          clipper: GreyTopClipper(
                            yOffset: _greyTopClipperAnimation.value,
                          ),
                          child: child,
                        );
                      },
                      child: Container(color: kBlue),
                    ),
                    AnimatedBuilder(
                      animation: _blueTopClipperAnimation,
                      builder: (_, Widget? child) {
                        return ClipPath(
                          clipper: BlueTopClipper(
                            yOffset: _blueTopClipperAnimation.value,
                          ),
                          child: child,
                        );
                      },
                      child: Container(color: kWhite),
                    ),
                    SafeArea(
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: kPaddingL),
                        child: Column(
                          children: <Widget>[
                            Header(animation: _headerTextAnimation),
                            SizedBox(
                              height: 90,
                            ),
                            Flexible(
                              child: Image.asset(
                                'assets/icons/output-onlinegiftools_OUT.gif',
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Login(
                                                screenHeight: screenHeight),
                                          ));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff6d96fa),
                                        fixedSize: const Size(150, 50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                    child: Text('Login')),
                                SizedBox(
                                  width: 5,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SignUp(
                                                screenHeight: screenHeight),
                                          ));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff6d96fa),
                                        fixedSize: const Size(150, 50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                    child: Text('SignUp')),
                              ],
                            ),

                            //LoginForm(animation: _formElementAnimation),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return SafeArea(
                  child: Column(
                    children: <Widget>[
                      AnimatedBuilder(
                        animation: _whiteTopClipperAnimation,
                        builder: (_, Widget? child) {
                          return ClipPath(
                            clipper: WhiteTopClipper(
                              yOffset: _whiteTopClipperAnimation.value,
                            ),
                            child: child,
                          );
                        },
                        child: Container(color: kGrey),
                      ),
                      AnimatedBuilder(
                        animation: _greyTopClipperAnimation,
                        builder: (_, Widget? child) {
                          return ClipPath(
                            clipper: GreyTopClipper(
                              yOffset: _greyTopClipperAnimation.value,
                            ),
                            child: child,
                          );
                        },
                        child: Container(color: kBlue),
                      ),
                      AnimatedBuilder(
                        animation: _blueTopClipperAnimation,
                        builder: (_, Widget? child) {
                          return ClipPath(
                            clipper: BlueTopClipper(
                              yOffset: _blueTopClipperAnimation.value,
                            ),
                            child: child,
                          );
                        },
                        child: Container(color: kWhite),
                      ),
                      Flexible(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 68.0),
                              child: Header(animation: _headerTextAnimation),
                            ),

                            SizedBox(
                              height: 60,
                            ),
                            Image.asset(
                                'assets/icons/output-onlinegiftools_OUT.gif',
                                height: 250),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Login(screenHeight: screenHeight),
                                      ));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff6d96fa),
                                    fixedSize: const Size(150, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50))),
                                child: Text('Login')),
                            SizedBox(
                              height: 5,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SignUp(screenHeight: screenHeight),
                                      ));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff6d96fa),
                                    fixedSize: const Size(150, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50))),
                                child: Text('SignUp')),
                            //LoginForm(animation: _formElementAnimation),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
          );
        } else {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: kWhite,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  AnimatedBuilder(
                    animation: _whiteTopClipperAnimation,
                    builder: (_, Widget? child) {
                      return ClipPath(
                        clipper: WhiteTopClipper(
                          yOffset: _whiteTopClipperAnimation.value,
                        ),
                        child: child,
                      );
                    },
                    child: Container(color: kGrey),
                  ),
                  AnimatedBuilder(
                    animation: _greyTopClipperAnimation,
                    builder: (_, Widget? child) {
                      return ClipPath(
                        clipper: GreyTopClipper(
                          yOffset: _greyTopClipperAnimation.value,
                        ),
                        child: child,
                      );
                    },
                    child: Container(color: kBlue),
                  ),
                  AnimatedBuilder(
                    animation: _blueTopClipperAnimation,
                    builder: (_, Widget? child) {
                      return ClipPath(
                        clipper: BlueTopClipper(
                          yOffset: _blueTopClipperAnimation.value,
                        ),
                        child: child,
                      );
                    },
                    child: Container(color: kWhite),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: kPaddingL),
                      child: Column(
                        children: <Widget>[
                          Header(animation: _headerTextAnimation),
                          SizedBox(
                            height: 90,
                          ),
                          Image.asset(
                              'assets/icons/output-onlinegiftools_OUT.gif',
                              height: 400),
                          //LoginForm(animation: _formElementAnimation),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Login(screenHeight: screenHeight),
                                    ));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff6d96fa),
                                  fixedSize: const Size(150, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              child: Text('Login')),
                          SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff6d96fa),
                                  fixedSize: const Size(150, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              child: Text('SignUp')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
