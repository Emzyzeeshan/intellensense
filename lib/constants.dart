 import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:intellensense/HomeScreen_Pages/Controllers/HomeScreenController.dart';
import 'package:intellensense/HomeScreen_Pages/Widgets/Newstemplate.dart';
import 'package:intellensense/HomeScreen_Pages/Widgets/Socialmediatemplate.dart';

import 'HomeScreen_Pages/NewsPage.dart';
HomePageController homePageController=Get.put(HomePageController());

 List<Party> partyList = [
   Party(
     name: "TDP",
   ),
   Party(
     name: "TRS ",
   ),
   Party(
     name: "YSRCP",
   ),
   Party(
     name: "AIMIM",
   ),
   Party(
     name: "BJP",
   ),
   Party(
     name: "INC",
   ),
 ];
//NewsPaper
List Newpaperlist = [
      NewsTemplate2(
          "${homePageController.newsdata[0]['mediaName']}".length > 16
              ? ' ${homePageController.newsdata[0]['mediaName'].substring(0, 10)}...'
              : ' ${homePageController.newsdata[0]['mediaName']}',
          '${homePageController.newsdata[0]['headLine']}',
          'assets/icons/newspaperdxp.png',
          '${homePageController.newsdata[0]['candidateName']}'.length > 16
              ? '- ${homePageController.newsdata[0]['candidateName'].substring(0, 10)}...'
              : '- ${homePageController.newsdata[0]['candidateName']}'),
      NewsTemplate3(
          "${homePageController.newsdata[1]['mediaName']}".length > 16
              ? ' ${homePageController.newsdata[1]['mediaName'].substring(0, 10)}...'
              : ' ${homePageController.newsdata[1]['mediaName']}',
          '${homePageController.newsdata[1]['headLine']}'
              '${homePageController.newsdata[1]['headLine']}',
          'assets/icons/newspaperdxp.png',
          '${homePageController.newsdata[1]['candidateName']}'.length > 16
              ? '- ${homePageController.newsdata[1]['candidateName'].substring(0, 10)}...'
              : '- ${homePageController.newsdata[1]['candidateName']}'),
      NewsTemplate1(
          "${homePageController.newsdata[2]['mediaName']}".length > 16
              ? ' ${homePageController.newsdata[2]['mediaName'].substring(0, 10)}...'
              : ' ${homePageController.newsdata[2]['mediaName']}',
          '${homePageController.newsdata[2]['headLine']}'
              '${homePageController.newsdata[2]['headLine']}',
          'assets/icons/newspaperdxp.png',
          '${homePageController.newsdata[2]['candidateName']}'.length > 16
              ? '- ${homePageController.newsdata[2]['candidateName'].substring(0, 10)}...'
              : '- ${homePageController.newsdata[2]['candidateName']}'),
      NewsTemplate4(
          "${homePageController.newsdata[3]['mediaName']}".length > 16
              ? ' ${homePageController.newsdata[3]['mediaName'].substring(0, 10)}...'
              : ' ${homePageController.newsdata[3]['mediaName']}',
          '${homePageController.newsdata[3]['headLine']}'
              '${homePageController.newsdata[3]['headLine']}',
          'assets/icons/newspaperdxp.png',
          '${homePageController.newsdata[3]['candidateName']}'.length > 16
              ? '- ${homePageController.newsdata[3]['candidateName'].substring(0, 10)}...'
              : '- ${homePageController.newsdata[3]['candidateName']}'),
    ];



    //Newschannel
     List NewschannelList = [
      NewsTemplate2(
          "${homePageController.newchannelldata[0]['mediaChannelName']}"
                      .length >
                  16
              ? ' ${homePageController.newchannelldata[0]['mediaChannelName'].substring(0, 10)}...'
              : ' ${homePageController.newchannelldata[0]['mediaChannelName']}',
          '${homePageController.newchannelldata[0]['headLine']}'
              '${homePageController.newchannelldata[0]['videoTitle']}',
          'assets/icons/newsdxps.png',
          '- ${homePageController.newchannelldata[0]['candidateName']}'),
      NewsTemplate3(
          "${homePageController.newchannelldata[1]['mediaChannelName']}"
                      .length >
                  16
              ? ' ${homePageController.newchannelldata[1]['mediaChannelName'].substring(0, 10)}...'
              : ' ${homePageController.newchannelldata[1]['mediaChannelName']}',
          '${homePageController.newchannelldata[1]['videoTitle']}',
          'assets/icons/newsdxps.png',
          '${homePageController.newchannelldata[1]['candidateName']}'.length >
                  16
              ? '- ${homePageController.newchannelldata[1]['candidateName'].substring(0, 10)}...'
              : '- ${homePageController.newchannelldata[1]['candidateName']}'),
      NewsTemplate1(
          "${homePageController.newchannelldata[2]['mediaChannelName']}"
                      .length >
                  16
              ? ' ${homePageController.newchannelldata[2]['mediaChannelName'].substring(0, 10)}...'
              : ' ${homePageController.newchannelldata[2]['mediaChannelName']}',
          '${homePageController.newchannelldata[2]['videoTitle']}',
          'assets/icons/newsdxps.png',
          '- ${homePageController.newchannelldata[2]['candidateName']}'),
      NewsTemplate4(
          "${homePageController.newchannelldata[3]['mediaChannelName']}"
                      .length >
                  16
              ? ' ${homePageController.newchannelldata[3]['mediaChannelName'].substring(0, 10)}...'
              : ' ${homePageController.newchannelldata[3]['mediaChannelName']}',
          '${homePageController.newchannelldata[3]['videoTitle']}',
          'assets/icons/newsdxps.png',
          '- ${homePageController.newchannelldata[3]['candidateName']}'),
    ];

    //Live News 
List LiveNewsList = [
      NewsTemplate2(
          "${homePageController.Livenewsdata[0]['mediaName']}".length > 14
              ? ' ${homePageController.Livenewsdata[0]['mediaName'].substring(0, 10)}...'
              : ' ${homePageController.Livenewsdata[0]['mediaName']}',
          '${homePageController.Livenewsdata[0]['headLine']}',
          'assets/icons/live.gif',
          '${homePageController.Livenewsdata[0]['publishedDate']}'),
      NewsTemplate3(
          "${homePageController.Livenewsdata[1]['mediaName']}".length > 16
              ? ' ${homePageController.Livenewsdata[1]['mediaName'].substring(0, 10)}...'
              : ' ${homePageController.Livenewsdata[1]['mediaName']}',
          '${homePageController.Livenewsdata[1]['headLine']}',
          'assets/icons/live.gif',
          '${homePageController.Livenewsdata[1]['publishedDate']}'),
      NewsTemplate1(
          "${homePageController.Livenewsdata[2]['mediaName']}".length > 16
              ? ' ${homePageController.Livenewsdata[2]['mediaName'].substring(0, 10)}...'
              : ' ${homePageController.Livenewsdata[2]['mediaName']}',
          '${homePageController.Livenewsdata[2]['headLine']}',
          'assets/icons/live.gif',
          '${homePageController.Livenewsdata[2]['publishedDate']}'),
      NewsTemplate4(
          "${homePageController.Livenewsdata[3]['mediaName']}".length > 14
              ? ' ${homePageController.Livenewsdata[3]['mediaName'].substring(0, 10)}...'
              : ' ${homePageController.Livenewsdata[3]['mediaName']}',
          '${homePageController.Livenewsdata[3]['headLine']}',
          'assets/icons/live.gif',
          '${homePageController.Livenewsdata[3]['publishedDate']}'),
    ];
    //Google trends
    List GoogleTrendsList = [
      NewsTemplate2(
          "${homePageController.GoogleTrendsdata[0]['partyName']}".length > 16
              ? ' ${homePageController.GoogleTrendsdata[0]['partyName'].substring(0, 10)}...'
              : ' ${homePageController.GoogleTrendsdata[0]['partyName']}',
          '${homePageController.GoogleTrendsdata[0]['id']['region']}',
          'assets/icons/googleTrends.png',
          '- ${homePageController.GoogleTrendsdata[0]['id']['candidateName']}'),
      NewsTemplate3(
          "${homePageController.GoogleTrendsdata[1]['partyName']}".length > 16
              ? ' ${homePageController.GoogleTrendsdata[1]['partyName'].substring(0, 10)}...'
              : ' ${homePageController.GoogleTrendsdata[1]['partyName']}',
          '${homePageController.GoogleTrendsdata[1]['id']['region']}',
          'assets/icons/googleTrends.png',
          '- ${homePageController.GoogleTrendsdata[1]['id']['candidateName']}'),
      NewsTemplate1(
          "${homePageController.GoogleTrendsdata[2]['partyName']}".length > 16
              ? ' ${homePageController.GoogleTrendsdata[2]['partyName'].substring(0, 10)}...'
              : ' ${homePageController.GoogleTrendsdata[2]['partyName']}',
          '${homePageController.GoogleTrendsdata[2]['id']['region']}',
          'assets/icons/googleTrends.png',
          '- ${homePageController.GoogleTrendsdata[2]['id']['candidateName']}'),
      NewsTemplate4(
          "${homePageController.GoogleTrendsdata[3]['partyName']}".length > 16
              ? ' ${homePageController.GoogleTrendsdata[3]['partyName'].substring(0, 10)}...'
              : ' ${homePageController.GoogleTrendsdata[3]['partyName']}',
          '${homePageController.GoogleTrendsdata[3]['id']['region']}',
          'assets/icons/googleTrends.png',
          '- ${homePageController.GoogleTrendsdata[3]['id']['candidateName']}'),
    ];


    //Youtube
     List YoutubeList = [
      SocialMediaTemplate1(
          '${homePageController.Youtubedata[0]['mediaChannelName']}',
          '${homePageController.Youtubedata[0]['videoTitle']}',
          'Views - ${homePageController.Youtubedata[0]['videoViews']}    Likes - ${homePageController.Youtubedata[0]['videoLikes']}'),
      SocialMediaTemplate1(
          '${homePageController.Youtubedata[1]['mediaChannelName']}',
          '${homePageController.Youtubedata[1]['videoTitle']}',
          'Views - ${homePageController.Youtubedata[1]['videoViews']}    Likes - ${homePageController.Youtubedata[1]['videoLikes']}'),
      SocialMediaTemplate1(
          '${homePageController.Youtubedata[2]['mediaChannelName']}',
          '${homePageController.Youtubedata[2]['videoTitle']}',
          'Views - ${homePageController.Youtubedata[2]['videoViews']}    Likes - ${homePageController.Youtubedata[2]['videoLikes']}'),
      SocialMediaTemplate1(
          '${homePageController.Youtubedata[3]['mediaChannelName']}',
          '${homePageController.Youtubedata[3]['videoTitle']}',
          'Views - ${homePageController.Youtubedata[3]['videoViews']}    Likes - ${homePageController.Youtubedata[3]['videoLikes']}'),
    ];

    //Twitter
 List TwitterList = [
      SocialMediaTemplate2(
          '${homePageController.TwitterData[0]['candidateName']}',
          '${homePageController.TwitterData[0]['tweetContent']}',
          '- ${homePageController.TwitterData[0]['candidatePartyName']}'),
      SocialMediaTemplate2(
          '${homePageController.TwitterData[1]['candidateName']}',
          '${homePageController.TwitterData[1]['tweetContent']}',
          '- ${homePageController.TwitterData[1]['candidatePartyName']}'),
      SocialMediaTemplate2(
          '${homePageController.TwitterData[2]['candidateName']}',
          '${homePageController.TwitterData[2]['tweetContent']}',
          '- ${homePageController.TwitterData[2]['candidatePartyName']}'),
      SocialMediaTemplate2(
          '${homePageController.TwitterData[3]['candidateName']}',
          '${homePageController.TwitterData[3]['tweetContent']}',
          '- ${homePageController.TwitterData[3]['candidatePartyName']}'),
    ];
    //FaceBook
     List FaceBookList = [
      SocialMediaTemplate3(
          '${homePageController.Facebookdata[0]['keyWords']}',
          '${homePageController.Facebookdata[0]['titleContent']}',
          '${homePageController.Facebookdata[0]['candidateName']}'.length > 16
              ? '- ${homePageController.Facebookdata[0]['candidateName'].substring(0, 10)}...'
              : '- ${homePageController.Facebookdata[0]['candidateName']}'

          // '${  homePageController. Facebookdata[0]['candidateName']}'
          ),
      SocialMediaTemplate3(
          '${homePageController.Facebookdata[1]['keyWords']}',
          '${homePageController.Facebookdata[1]['titleContent']}',
          '${homePageController.Facebookdata[1]['candidateName']}'.length > 16
              ? '- ${homePageController.Facebookdata[1]['candidateName'].substring(0, 10)}...'
              : '- ${homePageController.Facebookdata[1]['candidateName']}'
          // ,'${  homePageController. Facebookdata[1]['candidateName']}'
          ),
      SocialMediaTemplate3(
          '${homePageController.Facebookdata[2]['keyWords']}',
          '${homePageController.Facebookdata[2]['titleContent']}',
          '${homePageController.Facebookdata[2]['candidateName']}'.length > 16
              ? '- ${homePageController.Facebookdata[2]['candidateName'].substring(0, 10)}...'
              : '- ${homePageController.Facebookdata[2]['candidateName']}'

          // '${  homePageController. Facebookdata[2]['candidateName']}'
          ),
      SocialMediaTemplate3(
          '${homePageController.Facebookdata[3]['keyWords']}',
          '${homePageController.Facebookdata[3]['titleContent']}',
          '${homePageController.Facebookdata[3]['candidateName']}'.length > 16
              ? '- ${homePageController.Facebookdata[3]['candidateName'].substring(0, 10)}...'
              : '- ${homePageController.Facebookdata[3]['candidateName']}'
          // '${  homePageController. Facebookdata[3]['candidateName']}'
          ),
    ];

    //Instagram
 List InstagramList = [
      SocialMediaTemplate4(
          '${homePageController.Instagramdata[0]['candidateName']}',
          '${homePageController.Instagramdata[0]['titleContent']}',
          'Likes- ${homePageController.Instagramdata[0]['likesCount']}   Comments- ${homePageController.Instagramdata[0]['commentsCount']}'),
      SocialMediaTemplate4(
          '${homePageController.Instagramdata[1]['candidateName']}',
          '${homePageController.Instagramdata[1]['titleContent']}',
          'Likes- ${homePageController.Instagramdata[1]['likesCount']}   Comments- ${homePageController.Instagramdata[1]['commentsCount']}'),
      SocialMediaTemplate4(
          '${homePageController.Instagramdata[2]['candidateName']}',
          '${homePageController.Instagramdata[2]['titleContent']}',
          'Likes- ${homePageController.Instagramdata[2]['likesCount']}   Comments- ${homePageController.Instagramdata[2]['commentsCount']}'),
      SocialMediaTemplate4(
          '${homePageController.Instagramdata[3]['candidateName']}',
          '${homePageController.Instagramdata[3]['titleContent']}',
          'Likes- ${homePageController.Instagramdata[3]['likesCount']}   Comments- ${homePageController.Instagramdata[3]['commentsCount']}'),
    ];