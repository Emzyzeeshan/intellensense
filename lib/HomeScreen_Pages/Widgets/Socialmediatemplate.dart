import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialMediaTemplate1 extends StatefulWidget {
  String? header;
  String? newsdescription;
String ? CandidateName;
  SocialMediaTemplate1(this.header, this.newsdescription, this.CandidateName);

  @override
  State<SocialMediaTemplate1> createState() => _SocialMediaTemplate1State();
}

class _SocialMediaTemplate1State extends State<SocialMediaTemplate1> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: 90,
          width: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Color(0xFFE57373),
                Color(0xffe4e0f8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
                    padding: const EdgeInsets.only(top:8.0,left: 8,right: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/youtubedxps.png',
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
                    padding: const EdgeInsets.only(right:8.0),
                    child: Text(
                        '${widget.newsdescription}',
                        maxLines: 3,
                  
                     style: GoogleFonts.raleway(fontSize: 9)),
                  ),
         Spacer(),
                  Row(  mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                padding: const EdgeInsets.only(right:8.0,bottom: 8),
                        child: Text(
                            '${widget.CandidateName}',
                            maxLines: 4,
                      
                            style: GoogleFonts.raleway(fontSize: 8,fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),              ]),
          ),
        ));
  }
}

class SocialMediaTemplate2 extends StatefulWidget {
  String? header;
  String? newsdescription;String ? CandidateName;
  SocialMediaTemplate2(this.header, this.newsdescription,this.CandidateName);

  @override
  State<SocialMediaTemplate2> createState() => _SocialMediaTemplate2State();
}

class _SocialMediaTemplate2State extends State<SocialMediaTemplate2> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: 90,
          width: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: const [
                Colors.blueAccent,
                Color(0xffe4e0f8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
                 padding: const EdgeInsets.only(top:8.0,left: 8,right: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/Social-Media-Icons-IS-08.png',
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
               padding: const EdgeInsets.only(right:8.0),
                    child: Text(
                      '${widget.newsdescription}',
                      maxLines: 3,
                     style: GoogleFonts.raleway(fontSize: 9)),
                  ),
                   Spacer(),
                  Row(  mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                padding: const EdgeInsets.only(right:8.0,bottom: 8),
                        child: Text(
                            '${widget.CandidateName}',
                            maxLines: 4,
                      
                            style: GoogleFonts.raleway(fontSize: 8,fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ]),
          ),
        ));
  }
}

//todo templete 3

class SocialMediaTemplate3 extends StatefulWidget {
  String? header;
  String? newsdescription;String ? CandidateName;
  SocialMediaTemplate3(this.header, this.newsdescription, this.CandidateName);

  @override
  State<SocialMediaTemplate3> createState() => _SocialMediaTemplate3State();
}

class _SocialMediaTemplate3State extends State<SocialMediaTemplate3> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: 90,
          width: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade500,
                Color(0xffe4e0f8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
                    padding: const EdgeInsets.only(top:8.0,left: 8,right: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/Social-Media-Icons-IS-06.png',
                        height: 20,
                        width: 20,
                      ),
                      Text(
                        widget.header!.length > 16
                            ? '${widget.header!.substring(0, 10)}...'
                            : widget.header!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                     padding: const EdgeInsets.only(right:8.0),
                    child: Text(
                        '${widget.newsdescription}',
                        maxLines: 3,
                  
                          style: GoogleFonts.raleway(fontSize: 9)),
                  ),
                   Spacer(),
                  Row(  mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                padding: const EdgeInsets.only(right:8.0,bottom: 8),
                        child: Text(
                            '${widget.CandidateName}',
                            maxLines: 4,
                      
                            style: GoogleFonts.raleway(fontSize: 8,fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ]),
          ),
        ));
  }
}

//todo : template 4

class SocialMediaTemplate4 extends StatefulWidget {
  String? header;
  String? newsdescription;String ? CandidateName;
  SocialMediaTemplate4(this.header, this.newsdescription,this.CandidateName );

  @override
  State<SocialMediaTemplate4> createState() => _SocialMediaTemplate4State();
}

class _SocialMediaTemplate4State extends State<SocialMediaTemplate4> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: 90,
          width: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: const [
                Colors.pinkAccent,
                Color(0xffe4e0f8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
                   padding: const EdgeInsets.only(top:8.0,left: 8,right: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/Social-Media-Icons-IS-07.png',
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
                            fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:8.0),
                    child: Text(
                        '${widget.newsdescription}',
                        maxLines: 3,
                  
                       style: GoogleFonts.raleway(fontSize: 9)),
                  ),
                   Spacer(),
                  Row(  mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                padding: const EdgeInsets.only(right:8.0,bottom: 8),
                        child: Text(
                            '${widget.CandidateName}',
                            maxLines: 4,
                      
                            style: GoogleFonts.raleway(fontSize: 8,fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ]),
          ),
        ));
  }
}
