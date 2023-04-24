import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intellensense/Pages/PhoneLogin.dart';
import 'package:intellensense/SpalashScreen/screens/login/login.dart';
import '../../constants.dart';
import 'widgets/custom_clippers/index.dart';
import 'widgets/header.dart';

class SignUp extends StatefulWidget {
  final double screenHeight;

  const SignUp({
    required this.screenHeight,
  });

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
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
            // backgroundColor: Color(0xffd2dfff),
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        child: Column(
                          children: <Widget>[
                            Header(animation: _headerTextAnimation),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Register",
                              style: GoogleFonts.nunitoSans(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Image.asset(
                              'assets/Image/signup.gif',
                              height: 250,
                              width: 250,
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.07,
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Color(0xFF306EFF),
                              ),
                              child: MaterialButton(
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Text(('SignUp with E-mail'),
                                        style: GoogleFonts.nunitoSans(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white)),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.07,
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Color(0xFF306EFF),
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PhoneAuthPage()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(('SignUp With Phone'),
                                        style: GoogleFonts.nunitoSans(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white)),
                                    Icon(
                                      Icons.mobile_friendly_sharp,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Already have an account?  '),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login(
                                                  screenHeight:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height)));
                                    },
                                    child: Text(
                                      'Sign In',
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.blue),
                                    ))
                              ],
                            ),
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
                            Text(
                              "Register",
                              style: GoogleFonts.nunitoSans(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Image.asset(
                              'assets/Image/signup.gif',
                              height: 200,
                              width: 200,
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.07,
                              margin:
                              const EdgeInsets.only(left: 20, right: 20),
                              decoration: const BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(50)),
                                color: Color(0xFF306EFF),
                              ),
                              child: MaterialButton(
                                onPressed: () {},
                                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(('SignUp with E-mail'),
                                        style: GoogleFonts.nunitoSans(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white)),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.07,
                              margin:
                              const EdgeInsets.only(left: 20, right: 20),
                              decoration: const BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(50)),
                                color: Color(0xFF306EFF),
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PhoneAuthPage()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(('SignUp With Phone'),
                                        style: GoogleFonts.nunitoSans(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white)),
                                    Icon(
                                      Icons.mobile_friendly_sharp,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Already have an account?  '),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login(
                                                  screenHeight:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height)));
                                    },
                                    child: Text(
                                      'Sign In',
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.blue),
                                    ))
                              ],
                            ),
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
                          Text(
                            "Register",
                            style: GoogleFonts.nunitoSans(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            'assets/Image/signup.gif',
                            height: 250,
                            width: 250,
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.07,
                            margin:
                            const EdgeInsets.only(left: 20, right: 20),
                            decoration: const BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50)),
                              color: Color(0xFF306EFF),
                            ),
                            child: MaterialButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Text(('SignUp with E-mail'),
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white)),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.07,
                            margin:
                            const EdgeInsets.only(left: 20, right: 20),
                            decoration: const BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50)),
                              color: Color(0xFF306EFF),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PhoneAuthPage()));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(('SignUp With Phone'),
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white)),
                                  Icon(
                                    Icons.mobile_friendly_sharp,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have an account?  '),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login(
                                                screenHeight:
                                                MediaQuery.of(context)
                                                    .size
                                                    .height)));
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.blue),
                                  ))
                            ],
                          ),
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
