import 'package:flutter/material.dart';

import '../../constants.dart';
import 'widgets/custom_clippers/index.dart';
import 'widgets/header.dart';
import 'widgets/login_form.dart';

class Login extends StatefulWidget {
  final double screenHeight;

  const Login({
    required this.screenHeight,
  });

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
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
                            SizedBox(height: 150,),
                            Text ("Login", style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),),
                            SizedBox(height: 20,),
                            Text("Welcome back ! Login with your credentials",style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),),
                            SizedBox(
                              height: 90,
                            ),
                            LoginForm(animation: _formElementAnimation),
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
                             SizedBox(height: 60,),
                            Text ("Login", style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),),
                            SizedBox(height: 20,),
                            Text("Welcome back ! Login with your credentials",style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),),
                            SizedBox(height: 40,),
                            LoginForm(animation: _formElementAnimation),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Dont have an account?"),
                                Text("Sign Up",style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18
                                ),),
                              ],
                            )
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
                          LoginForm(animation: _formElementAnimation),
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
