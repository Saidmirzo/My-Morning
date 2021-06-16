import 'package:url_launcher/url_launcher.dart';

openEmail(String email, String subject) async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: email,
    query: 'subject=$subject',
  );
  var url = params.toString();
  if (await canLaunch(url))
    await launch(url);
  else
    print('Can\'t launch email: $url');
}

openUrl(String url) async {
  if (await canLaunch(url))
    await launch(url);
  else
    print('Can\'t launch url: $url');
}
