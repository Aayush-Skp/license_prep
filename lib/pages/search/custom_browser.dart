import 'package:flutter/material.dart';
import 'package:license_entrance/app/theme.dart';
import 'package:license_entrance/common/widgets/common_loading_widget.dart';
import 'package:license_entrance/common/widgets/page_wrapper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomBrowser extends StatefulWidget {
  final String initialUrl;

  const CustomBrowser({Key? key, required this.initialUrl}) : super(key: key);

  @override
  State<CustomBrowser> createState() => _CustomBrowserState();
}

class _CustomBrowserState extends State<CustomBrowser> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) {
                setState(() => _isLoading = true);
              },
              onPageFinished: (url) {
                setState(() => _isLoading = false);
              },
              onNavigationRequest: (request) {
                if (request.url.contains("blockeddomain.com")) {
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.initialUrl));
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      backgroundColor: CustomTheme.appBarColor,
      title: 'Broswer',
      padding: EdgeInsets.symmetric(horizontal: 0),
      showBackButton: false,
      showAppBar: true,
      useOwnAppBar: true,
      appBar: AppBar(
        backgroundColor: CustomTheme.appBarColor,
        title: Text(
          "Browser",
          style: TextStyle(color: CustomTheme.primaryText.withAlpha(150)),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: CustomTheme.primaryText.withAlpha(150),
            ),
            onPressed: () => _controller.reload(),
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: CustomTheme.primaryText.withAlpha(150),
            ),
            onPressed: () async {
              if (await _controller.canGoBack()) {
                _controller.goBack();
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: CustomTheme.primaryText.withAlpha(150),
            ),
            onPressed: () async {
              if (await _controller.canGoForward()) {
                _controller.goForward();
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            Container(
              color: CustomTheme.appBarColor,
              child: const Center(child: CommonLoadingWidget()),
            ),
        ],
      ),
    );
  }
}
