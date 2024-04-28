import 'package:flutter/material.dart';
import 'package:furniture_app/components/loading/loading_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  const WebViewScreen({super.key, required this.url});
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    print(widget.url);
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            
          },
          onPageStarted: (String url) {
            
          },
          onPageFinished: (String url) {
            // Handle page finished loading here
          },
          onWebResourceError: (WebResourceError error) {
            // Handle web resource error here
          },
          onUrlChange: (UrlChange change) {
            
          }
        ),
      )
      ..addJavaScriptChannel('Suscess', onMessageReceived: (JavaScriptMessage message) {
        if (message.message == 'Suscess') {
          Navigator.pop(context);
        }
      })
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
