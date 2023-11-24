import 'package:url_launcher/url_launcher.dart';

abstract class UrlHandler {
  Future<void> openUrl(String uri);
}

class UrlLauncher extends UrlHandler {
  @override
  Future<void> openUrl(String uri) async {
    launchUrl(
      Uri.parse(uri),
      mode: LaunchMode.externalApplication,
    );
  }
}
