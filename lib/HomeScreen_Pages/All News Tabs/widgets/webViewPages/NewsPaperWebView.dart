import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:http/http.dart'as http;
class InAppWeb extends StatefulWidget {
  final String url;
  final String mediaName;
  const InAppWeb({Key? key,required this.url,required this.mediaName}) : super(key: key);

  @override
  State<InAppWeb> createState() => _InAppWebState();
}

class _InAppWebState extends State<InAppWeb> {
  WebViewController controller=WebViewController();
  @override
  void initState() {
    controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse(widget.url));
    // TODO: implement initState
    super.initState();

  }
  late final PlatformWebViewControllerCreationParams params;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:  Text(widget.mediaName,style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black),),
      ),
      body:  FadeInUp(
        from: 200,
        child: WebViewWidget(
          controller: controller,
         
        ),
      ),
    );
  }
}