import 'package:url_launcher/url_launcher.dart';

openEmail(String email, String subject) async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: email,
    query: 'subject=$subject',
  );
  var url = params.toString();
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Can\'t launch email: $url');
  }
}

openUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Can\'t launch url: $url');
  }
}

String printDuration(Duration duration, {bool h = true}) {
  String twoDigits(int n) => (n ?? 0).toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration?.inMinutes?.remainder(60));
  String twoDigitSeconds = twoDigits(duration?.inSeconds?.remainder(60));
  return "${h ? twoDigits(duration?.inHours) : ''}${h ? ':' : ''}$twoDigitMinutes:$twoDigitSeconds";
}
