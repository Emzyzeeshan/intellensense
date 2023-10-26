import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class NewsChannelWebView extends StatefulWidget {
  final String urlID;
  var data;
  NewsChannelWebView({Key? key, required this.urlID, required this.data})
      : super(key: key);

  @override
  State<NewsChannelWebView> createState() => _NewsChannelWebViewState();
}

class _NewsChannelWebViewState extends State<NewsChannelWebView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.urlID,
      autoPlay: true,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
    return Scaffold(
      body: SafeArea(
        child: YoutubePlayerScaffold(
          controller: _controller,
          aspectRatio: 16 / 9,
          builder: (context, player) {
            return Column(
              children: [
                FadeInUp(
                  from: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: player,
                  ),
                ),
                  FadeInUp(
                    from: 150,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 3),
                          child: Text(widget.data["mediaChannelName"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                        ),
                      ],
                    ),
                  ),
                FadeInUp(
                  from: 200,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 12),
                    child: Text(
                      widget.data["videoTitle"],
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              
                FadeInUp(
                  from: 250,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:12.0, vertical: 3),
                    child: Row(
                      children: [
                        Row(children: [
                          Icon(Icons.remove_red_eye,color: Colors.grey.shade700,),
                        SizedBox(width: 5,),
                        Text(widget.data["videoViews"]),
                        ],),
                        Spacer(),
                        Row(
                      children: [
                        Icon(Icons.thumb_up_alt,color: Colors.grey.shade700,),
                        SizedBox(width: 5,),
                        Text(widget.data["videoLikes"])
                      ],
                    ),
                    Spacer(),
                     Row(
                      children: [
                        Icon(Icons.thumb_down_alt,color: Colors.grey.shade700,),
                        SizedBox(width: 5,),
                        Text(widget.data["videoDislikes"])
                      ],
                    ),
                      Spacer(),
                     Row(
                      children: [
                        Icon(Icons.comment_rounded,color: Colors.grey.shade700,),
                        SizedBox(width: 5,),
                        Text(widget.data["videoCommentsCount"])
                      ],
                    ),
                      ],
                      
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
