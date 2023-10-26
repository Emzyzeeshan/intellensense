import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intellensense/Constants/constants.dart';
import 'package:intellensense/main.dart';
import 'package:provider/provider.dart';

class NewsTemplate1 extends StatefulWidget {
  String? header;
  String? newsdescription;
  String? logolink;
  String? CandidateName;
  NewsTemplate1(
      this.header, this.newsdescription, this.logolink, this.CandidateName);

  @override
  State<NewsTemplate1> createState() => _NewsTemplate1State();
}

class _NewsTemplate1State extends State<NewsTemplate1> {
  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<DarkMode>(context);
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: !themeMode.darkMode
                    ? AssetImage('assets/DarkmodeImages/dot.png')
                    : AssetImage(
                        DarkModeImages[0],
                      ),
                fit: BoxFit.fill,
                opacity: 0.6),
            borderRadius: BorderRadius.circular(20),
            gradient: !themeMode.darkMode
                ? LinearGradient(
                    colors: const [
                      Color.fromARGB(255, 79, 136, 239),
                      Color.fromARGB(255, 81, 122, 198),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8, right: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        '${widget.logolink}',
                        height: 20,
                        width: 20,
                      ),
                      Text(
                          widget.header!.length > 16
                              ? '${widget.header!.substring(0, 10)}...'
                              : widget.header!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10)),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text('${widget.newsdescription}',
                        maxLines: 4, style: GoogleFonts.raleway(fontSize: 9)),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                        child: Text('${widget.CandidateName}',
                            maxLines: 4,
                            style: GoogleFonts.raleway(
                                fontSize: 8, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ]),
          ),
        ));
  }
}

class NewsTemplate2 extends StatefulWidget {
  String? header;
  String? newsdescription;
  String? logolink;
  String? CandidateName;
  NewsTemplate2(
      this.header, this.newsdescription, this.logolink, this.CandidateName);

  @override
  State<NewsTemplate2> createState() => _NewsTemplate2State();
}

class _NewsTemplate2State extends State<NewsTemplate2> {
  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<DarkMode>(context);
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: !themeMode.darkMode
                    ? AssetImage('assets/DarkmodeImages/dot.png')
                    : AssetImage(DarkModeImages[1]),
                fit: BoxFit.fill,
                opacity: 0.6),
            borderRadius: BorderRadius.circular(20),
            gradient: !themeMode.darkMode
                ? LinearGradient(
                    colors: const [
                      Color.fromARGB(255, 79, 136, 239),
                      Color.fromARGB(255, 81, 122, 198),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8, right: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Image.asset(
                          '${widget.logolink}',
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                            widget.header!.length > 16
                                ? '${widget.header!.substring(0, 10)}...'
                                : widget.header!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text('${widget.newsdescription}',
                        maxLines: 4, style: GoogleFonts.raleway(fontSize: 9)),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                        child: Text('${widget.CandidateName}',
                            maxLines: 4,
                            style: GoogleFonts.raleway(
                                fontSize: 8, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
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
  String? CandidateName;
  NewsTemplate3(
      this.header, this.newsdescription, this.logolink, this.CandidateName);

  @override
  State<NewsTemplate3> createState() => _NewsTemplate3State();
}

class _NewsTemplate3State extends State<NewsTemplate3> {
  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<DarkMode>(context);
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: !themeMode.darkMode
                    ? AssetImage('assets/DarkmodeImages/dot.png')
                    : AssetImage(DarkModeImages[2]),
                fit: BoxFit.fill,
                opacity: 0.6),
            borderRadius: BorderRadius.circular(20),
            gradient: !themeMode.darkMode
                ? LinearGradient(
                    colors: const [
                      Color.fromARGB(255, 79, 136, 239),
                      Color.fromARGB(255, 81, 122, 198),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8, right: 15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        '${widget.logolink}',
                        height: 20,
                        width: 20,
                      ),
                      Text(
                          widget.header!.length > 16
                              ? '${widget.header!.substring(0, 10)}...'
                              : widget.header!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10)),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text('${widget.newsdescription}',
                        maxLines: 4, style: GoogleFonts.raleway(fontSize: 9)),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                        child: Text('${widget.CandidateName}',
                            maxLines: 4,
                            style: GoogleFonts.raleway(
                                fontSize: 8, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
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
  String? CandidateName;
  NewsTemplate4(
      this.header, this.newsdescription, this.logolink, this.CandidateName);

  @override
  State<NewsTemplate4> createState() => _NewsTemplate4State();
}

class _NewsTemplate4State extends State<NewsTemplate4> {
  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<DarkMode>(context);
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: !themeMode.darkMode
                    ? AssetImage('assets/DarkmodeImages/dot.png')
                    : AssetImage(DarkModeImages[3]),
                fit: BoxFit.fill,
                opacity: 0.6),
            borderRadius: BorderRadius.circular(20),
            gradient: !themeMode.darkMode
                ? LinearGradient(
                    colors: const [
                      Color.fromARGB(255, 79, 136, 239),
                      Color.fromARGB(255, 125, 151, 194),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8, right: 15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        '${widget.logolink}',
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                          widget.header!.length > 16
                              ? '${widget.header!.substring(0, 10)}...'
                              : widget.header!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10)),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text('${widget.newsdescription}',
                        maxLines: 4, style: GoogleFonts.raleway(fontSize: 9)),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                        child: Text('${widget.CandidateName}',
                            maxLines: 4,
                            style: GoogleFonts.raleway(
                                fontSize: 8, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ]),
          ),
        ));
  }
}
