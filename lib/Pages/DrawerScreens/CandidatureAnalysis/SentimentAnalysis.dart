import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intellensense/Pages/DrawerScreens/CandidatureAnalysis/TwitterSentiment.dart';
import 'package:intellensense/Pages/DrawerScreens/CandidatureAnalysis/YoutubeSentiment.dart';
import 'package:tuanis_sidebar/tuanis_sidebar.dart';

class SentimentAnalysis extends StatefulWidget {
  var Value;
  SentimentAnalysis(this.Value, {super.key});

  @override
  State<SentimentAnalysis> createState() => _SentimentAnalysisState();
}

class _SentimentAnalysisState extends State<SentimentAnalysis> {
  List<String> selectedsentiment = [
    'Twitter',
    'Youtube',
    'News Paper',
    'Voice Emotion',
    'News Channel',
    'Timeline',
    'Face Emotion',
    'Voice to Text'
  ];
  PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int currentpage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Color(0xffd2dfff),
        elevation: 0,
        centerTitle: true,
        title: Text(
          selectedsentiment[currentpage],
          style: GoogleFonts.nunitoSans(
              fontSize: 22.0, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      key: _key,
      backgroundColor: Color(0xffd2dfff),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 5,
            child: Row(
              children: [
                SentimentCardTemplate(() {
                  setState(() {
                    _pageController.jumpToPage(0);
                    currentpage = _pageController.page!.toInt();
                  });
                }, 'assets/icons/Social-Media-Icons-IS-08.png'),
                SentimentCardTemplate(() {
                  setState(() {
                    _pageController.jumpToPage(1);
                    currentpage = _pageController.page!.toInt();
                  });
                }, 'assets/icons/Social-Media-Icons-IS-10.png'),
                SentimentCardTemplate(() {}, 'assets/icons/newspaperdxp.png'),
                SentimentCardTemplate(() {}, 'assets/icons/voicedxps.png'),
                SentimentCardTemplate(() {}, 'assets/icons/newsdxps.png'),
                SentimentCardTemplate(() {}, 'assets/icons/timelinedxp.png'),
                SentimentCardTemplate(() {}, 'assets/icons/faceEmotiondxp.png'),
                SentimentCardTemplate(() {}, 'assets/icons/voice_to_text.png')
              ],
            ),
          ),

          Expanded(
            child: PageView(
              children: [
                TwitterSentiment(widget.Value),
                YoutubeSentiment(),
              ],
              controller: _pageController,
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.all(50),
          //   color: Colors.white,
          //   child: SingleChildScrollView(
          //     child: Padding(
          //       padding: EdgeInsets.only(top: 26, left: 10, right: 10),
          //       child: Column(
          //         children: [
          //           SingleChildScrollView(
          //             scrollDirection: Axis.horizontal,
          //             child: Row(
          //               children: [
          //                 SentimentCardTemplate(() {
          //                   setState(() {
          //                     _pageController.jumpToPage(0);
          //                   });
          //                 }, 'assets/icons/Social-Media-Icons-IS-08.png'),
          //                 SentimentCardTemplate(() {
          //                   setState(() {
          //                     _pageController.jumpToPage(1);
          //                   });
          //                 }, 'assets/icons/Social-Media-Icons-IS-10.png'),
          //                 SentimentCardTemplate(
          //                     () {}, 'assets/icons/newspaperdxp.png'),
          //                 SentimentCardTemplate(
          //                     () {}, 'assets/icons/voicedxps.png'),
          //                 SentimentCardTemplate(
          //                     () {}, 'assets/icons/newsdxps.png'),
          //                 SentimentCardTemplate(
          //                     () {}, 'assets/icons/timelinedxp.png'),
          //                 SentimentCardTemplate(
          //                     () {}, 'assets/icons/faceEmotiondxp.png'),
          //                 SentimentCardTemplate(
          //                     () {}, 'assets/icons/voice_to_text.png')
          //               ],
          //             ),
          //           ),
          //           SizedBox(
          //             height: 10,
          //           ),
          //           Container(
          //             height: MediaQuery.of(context).size.height,
          //             width: MediaQuery.of(context).size.width,
          //             child:
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  SentimentCardTemplate(VoidCallback ontap, String path) {
    return GestureDetector(
      onTap: ontap,
      child: Card(
        color: Color(0xffd2dfff),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(
            '$path',
            height: 30,
            width: 30,
          ),
        ),
      ),
    );
  }
}
