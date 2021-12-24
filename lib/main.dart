
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main(){
  runApp(MaterialApp(home:InitialUrlScreen(),));
}



class InitialUrlScreen extends StatefulWidget {
  @override
  State<InitialUrlScreen> createState() => _InitialUrlScreenState();
}

class _InitialUrlScreenState extends State<InitialUrlScreen> {
  late WebViewController controller;

  double progress=0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(await controller.canGoBack()){
          controller.goBack();
          return false;
        }
        else{
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          // title: Text("Initial URL"),
          // leading: IconButton(icon: Icon(Icons.clear),
          //   onPressed: ()async{
          //       controller.clearCache();
          //       CookieManager().clearCookies();
          //
          //   },
          // ),
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: ()async{
              if(await controller.canGoBack()){
                controller.goBack();
              }
            },
          ),
          actions: [

            IconButton(icon: Icon(Icons.refresh),
              onPressed: ()=>controller.reload()
            )
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              color: Colors.red,
              value: progress,
              backgroundColor: Colors.black,
            ),
            Expanded(
              child: WebView(
                initialUrl: "https://balogs.co.uk/sign-up/",
             //   javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller){
                  this.controller=controller;
                },
    onProgress: (progress)=> setState(()=>this.progress=progress/100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}