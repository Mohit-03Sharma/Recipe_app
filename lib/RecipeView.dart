import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_recipe_app/model.dart';
import 'package:http/http.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeView extends StatefulWidget {
  final String url;
  RecipeView(this.url, {super.key});

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  final WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled)
    ..loadRequest(Uri.parse('https://www.flutter.dev'));
  // List<RecipeModel> recipeList = <RecipeModel>[];
  // bool isLoading = true;

  // getRecipe(String query) async {
  //   String url =
  //       "https://api.edamam.com/search?q=$query&app_id=bf06027c&app_key=f94b9573d8ff7aa0b350ac9d88bbb90d&from=0&to=3&calories=591-722&health=alcohol-free";
  //   Response response = await get(Uri.parse(url));
  //   Map data = jsonDecode(response.body);
  //   // print(data);
  //   data["hits"].forEach((element) {
  //     RecipeModel recipeModel = RecipeModel();
  //     recipeModel = RecipeModel.fromMap(element["recipe"]);
  //     recipeList.add(recipeModel);
  //     setState(() {
  //       isLoading = false;
  //     });
  //   });
  // }

  // webUrl(index) {
  //   getRecipe(widget.query);
  //   return recipeList[index].appUrl;
  // }

  @override
  void initState() {
    super.initState();

    // Completer<WebViewController> controller = Completer<WebViewController>();
    // controller = (WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..loadFlutterAsset((controller) {
    //     setState(() {
    //       controller.complete;
    //     });
    //   } as String)) as Completer<WebViewController>
    //   ..loadRequest(Uri.parse(url));

    //   late final PlatformWebViewControllerCreationParams params;
    //   if (WebViewPlatform.instance is WebKitWebViewPlatform) {
    //     params = WebKitWebViewControllerCreationParams(
    //       allowsInlineMediaPlayback: true,
    //       mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
    //     );
    //   } else {
    //     params = const PlatformWebViewControllerCreationParams();
    //   }

    //   final WebViewController controller =
    //       WebViewController.fromPlatformCreationParams(params);
    //   // #enddocregion platform_features

    //   controller
    //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //     ..setBackgroundColor(const Color(0x00000000))
    //     ..setNavigationDelegate(
    //       NavigationDelegate(
    //         onProgress: (int progress) {
    //           debugPrint('WebView is loading (progress : $progress%)');
    //         },
    //         onPageStarted: (String url) {
    //           debugPrint('Page started loading: $url');
    //         },
    //         onPageFinished: (String url) {
    //           debugPrint('Page finished loading: $url');
    //         },
    //         onWebResourceError: (WebResourceError error) {
    //           debugPrint('''
    //                 Page resource error:
    //                   code: ${error.errorCode}
    //                   description: ${error.description}
    //                   errorType: ${error.errorType}
    //                   isForMainFrame: ${error.isForMainFrame}
    //             ''');
    //         },
    //         onNavigationRequest: (NavigationRequest request) {
    //           if (request.url.startsWith('https://www.youtube.com/')) {
    //             debugPrint('blocking navigation to ${request.url}');
    //             return NavigationDecision.prevent;
    //           }
    //           debugPrint('allowing navigation to ${request.url}');
    //           return NavigationDecision.navigate;
    //         },
    //         onUrlChange: (UrlChange change) {
    //           debugPrint('url change to ${change.url}');
    //         },
    //       ),
    //     )
    //     ..addJavaScriptChannel(
    //       'Toaster',
    //       onMessageReceived: (JavaScriptMessage message) {
    //         ScaffoldMessenger.of(context).showSnackBar(
    //           SnackBar(content: Text(message.message)),
    //         );
    //       },
    //     )
    //     ..loadRequest(Uri.parse('https://flutter.dev'));
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Recipe App"),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
