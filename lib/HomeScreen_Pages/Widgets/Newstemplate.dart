import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsTemplate1 extends StatefulWidget {
  String? header;
  String? newsdescription;
  String? logolink;
  NewsTemplate1(this.header, this.newsdescription, this.logolink, );

  @override
  State<NewsTemplate1> createState() => _NewsTemplate1State();
}

class _NewsTemplate1State extends State<NewsTemplate1> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: const [
                Color.fromARGB(255, 98, 113, 145),
                Color(0xffe4e0f8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        '${widget.logolink}',
                        height: 20,
                        width: 20,
                      ),
                      Text(
                          widget.header!.length > 16 ? '${widget.header!.substring(0, 10)}...' : widget.header!,
                          style: GoogleFonts.bebasNeue(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                      '${widget.newsdescription}',
                      maxLines: 3,

                      style: GoogleFonts.cabin(fontSize: 10))
                ]),
          ),
        ));
  }
}

class NewsTemplate2 extends StatefulWidget {
  String? header;
  String? newsdescription;
  String? logolink;
  NewsTemplate2(this.header, this.newsdescription, this.logolink, );

  @override
  State<NewsTemplate2> createState() => _NewsTemplate2State();
}

class _NewsTemplate2State extends State<NewsTemplate2> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: const [
                Color.fromARGB(255, 176, 193, 232),
                Color(0xffe4e0f8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
               //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Image.asset(
                          '${widget.logolink}',
                          height: 25,
                          width: 25,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                            widget.header!.length > 16 ? '${widget.header!.substring(0, 10)}...' : widget.header!,
                            style: GoogleFonts.bebasNeue(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                      '${widget.newsdescription}',
                      maxLines: 3,

                      style: GoogleFonts.cabin(fontSize: 10))
                ]),
          ),
        ));
  }
}

//todo templete 3

class NewsTemplate3 extends StatefulWidget {
  String? header;
  String? newsdescription;
  String? logolink;
  NewsTemplate3(this.header, this.newsdescription, this.logolink, );

  @override
  State<NewsTemplate3> createState() => _NewsTemplate3State();
}

class _NewsTemplate3State extends State<NewsTemplate3> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: const [
                Color.fromARGB(255, 77, 107, 173),
                Color(0xffe4e0f8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        '${widget.logolink}',
                        height: 20,
                        width: 20,
                      ),
                      Text(
                          widget.header!.length > 16 ? '${widget.header!.substring(0, 10)}...' : widget.header!,
                          style: GoogleFonts.bebasNeue(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                      '${widget.newsdescription}',
                      maxLines: 3,

                      style: GoogleFonts.cabin(fontSize: 10))
                ]),
          ),
        ));
  }
}

//todo : template 4

class NewsTemplate4 extends StatefulWidget {
  String? header;
  String? newsdescription;
  String? logolink;
  NewsTemplate4(this.header, this.newsdescription, this.logolink, );

  @override
  State<NewsTemplate4> createState() => _NewsTemplate4State();
}

class _NewsTemplate4State extends State<NewsTemplate4> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: const [
                Color.fromARGB(255, 81, 99, 140),
                Color(0xffe4e0f8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/newspaperdxp.png',
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                          widget.header!.length > 16 ? '${widget.header!.substring(0, 10)}...' : widget.header!,
                          style: GoogleFonts.bebasNeue(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                      '${widget.newsdescription}',
                      maxLines: 3,

                      style: GoogleFonts.cabin(fontSize: 10))
                ]),
          ),
        ));
  }
}

