// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../browserSettings.dart';
import '../ui/mini.dart';
import 'webController.dart';

class WebTab extends StatelessWidget {
  const WebTab({
    Key? key,
    required this.webProvider,
    required this.adsList,
  }) : super(key: key);

  final WebProvider webProvider;

  final List adsList;
  @override
  Widget build(BuildContext context) {
    final Browser browser = Get.find();
    final items = Get.put(WebProvider());
    final mini = Get.put(MiniatureProvider());
    var webItem = browser.webViewTabs[browser.getCurrentTabIndex()].webProvider;

    var i = 0;
    return GetX<WebProvider>(
      builder: (_) {
        return InAppWebView(
          onWebViewCreated: (c) async {
            webItem.webViewController = c;
            webProvider.webViewController = c;
          },
          initialUrlRequest: URLRequest(url: Uri.parse(webItem.url)),
          windowId: webProvider.windowId,
          initialOptions: InAppWebViewGroupOptions(
              android: AndroidInAppWebViewOptions(
            supportMultipleWindows: true,
            useShouldInterceptRequest: true,
          )),
          androidShouldInterceptRequest: (webCont, request) async {
            var url = request.url.toString();
            var i = 0;
            log(url);
            while (i < adsList.length) {
              if (url.contains(adsList.elementAt(i))) {
                log("URL:$url");
                return WebResourceResponse();
              }
              i++;
            }
            return null;
          },
          onLoadStop: (c, url) async {
            webProvider.url = url.toString();

            webItem.title = await webItem.webViewController?.getTitle();
            if (browser.miniatureTabs.isEmpty &&
                browser.webViewTabs.length == 1) {
              var favicons = await webItem.webViewController?.getFavicons();

              if (browser.miniatureTabs.isEmpty) {
                if (favicons!.isNotEmpty) {
                  var miniFav = Mini(
                      miniatureProvider:
                          MiniatureProvider(favicon: favicons.first));

                  browser.addMiniature(miniFav);
                  log("первое создание MINI LIST");
                }
              }

              // MiniatureProvider().updateMiniature(mini.miniatureProvider);
            }

            log('//THISURL: $url');
            log('TITLE: ${webProvider.title}');
            log("LOADSTOP: ${i++}");

            webProvider.dellAds();
            items.updateWithValue(webItem);

            log('TITLE: ${webItem.title}');
          },
          onLoadStart: (c, url) async {
            webProvider.url = url.toString();

            var favicons = await webItem.webViewController!.getFavicons();
            if (browser.miniatureTabs.isNotEmpty) {
              if (favicons.isNotEmpty) {
                var miniItem = browser
                    .miniatureTabs[browser.getCurrentTabIndex()]
                    .miniatureProvider;
                miniItem.favicon = favicons.first;
                mini.updateMiniature(miniItem);
                log('ОБНОВИЛИ ФАВИКОН ПРИ СТАРТЕ СТРАНИЦЫ');
              }
            }

            log("LOADSTART: ${i++}");
          },
          onCreateWindow: (c, w) async {
            var webTab = WebTab(
              key: GlobalKey(),
              webProvider: WebProvider(
                url: w.request.url.toString(),
                windowId: w.windowId,
              ),
              adsList: adsList,
            );
            // var mini = MiniatureItem(Uri.parse(webItem.favicon));
            browser.addTab(webTab);
            var favicons = await webItem.webViewController!.getFavicons();
            if (browser.miniatureTabs.isNotEmpty) {
              if (favicons.isNotEmpty) {
                var mini = Mini(
                    miniatureProvider:
                        MiniatureProvider(favicon: favicons.first));

                log("ADD MINI ITEM");
                browser.addMiniature(mini);
              } else {
                var mini = Mini(miniatureProvider: MiniatureProvider());

                log("ADD MINI ITEM");
                browser.addMiniature(mini);
              }
            }

            return true;
          },
          onCloseWindow: (c) {
            webItem.webViewController!.reload();
          },
          onProgressChanged: (c, val) {
            webProvider.progress = val / 100;
            items.updateWithValue(webProvider);
          },
          onLoadError: (controller, url, code, message) async {
            var errorUrl = url ?? Uri.parse(webProvider.url);

            webItem.webViewController?.loadData(data: """
<html lang="en"><head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="robots" content="noindex,follow">
    <title>Oops</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <link  rel="shortcut icon" href="${await rootBundle.load('assets/browser.jpg')}"/>
	<style>${await rootBundle.loadString('assets/404.css')}</style>
	<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,700,600" rel="stylesheet" type="text/css">
	<link href="http://fonts.googleapis.com/css?family=Roboto:400,900,300,700" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Ultra" rel="stylesheet" type="text/css">
	<link href="http://fonts.googleapis.com/css?family=Rochester" rel="stylesheet" type="text/css">	
  <style type="text/css"></style></head>
	<body class="dusk">
	            <div class="col-md-12">
				<div class="owl-background">
					<div class="moon"></div>
					<div class="owl">
								<div class="wing1"></div>
								<div class="wing2"></div>
								<div class="wing3"></div>
								<div class="wing4"></div>
								<div class="wing5"></div>
								<div class="wing6"></div>
								<div class="wing7"></div>
								<div class="wing8"></div>
								<div class="wing9"></div>
								<div class="wing10"></div>
								<div class="wing11"></div>
								<div class="wing12"></div>
						<div class="owl-head">
								<div class="ears"></div>			
						</div>
						<div class="owl-body">
							<div class="owl-eyes">
								<div class="owleye">
										<div class="owleye inner"></div>
										<div class="owleye inner inner-2"></div>
										<div class="eyelid top"></div>
										<div class="eyelid bottom"></div>
								</div>
										<div class="owleye">
										<div class="owleye inner"></div>
										<div class="owleye inner inner-2"></div>
										<div class="eyelid top"></div>
										<div class="eyelid bottom"></div>
								</div>
								<div class="nose"></div>
							</div>
									<div class="feet">
									<div class="foot1"></div>
									<div class="foot2"></div>
							</div>
						</div>				
						<div class="branch"></div>
				    </div>
				</div> 
				</div>
				<div class="col-md-12">
				<div class="message">
						<h1>Oops!</h1></br>
						 <p>Could not load web pages at <strong>${url!.origin}</strong> because:</p><br>
					<p><b>$message</b></p></br>
          <p><h4>Or this page has been blocked by ADblock<h4></p>					
				</div>
				</div>
				<div id="stars1"></div>
				<div id="stars2"></div>
				<div id="stars3"></div>
				<div id="sstar"></div>	
</body></html>
    """, baseUrl: errorUrl, historyUrl: errorUrl);
            webItem.url = url.toString();
            var miniItem = browser
                .miniatureTabs[browser.getCurrentTabIndex()].miniatureProvider;
            miniItem.favicon =
                await controller.getFavicons().then((value) => value.first);
            mini.updateMiniature(miniItem);
            items.updateWithValue(webItem);
          },
          onTitleChanged: (c, title) {
            webItem.title = title;
            items.updateWithValue(webItem);
          },
        );
      },
    );
  }

  faviconLogic(List<Favicon> favicons) {
    for (var fav in favicons) {
      if (fav.width != null) {}
    }
  }
}
