class StringUtil {
  // TODO refactor this (now input time in seconds)
  static String createTimeString(int _time) {
    int min;
    int sec;
    String seconds;
    String minutes;

    if (_time != null) {
      min = _time ~/ 60;
      sec = _time % 60;
      int length_seconds = sec.toString().length;
      int length_minutes = min.toString().length;

      if (length_seconds < 2) {
        seconds = '0' + sec.toString();
      } else {
        seconds = sec.toString();
      }

      if (length_minutes < 2) {
        minutes = '0' + min.toString();
      } else {
        minutes = min.toString();
      }
      return minutes + " : " + seconds;

    } else {
      return "";
    }
  }

  static String getFormattedTimeLeft(int timeInMillis) {
    String _minutesString;
    String _secondsString;
    final _minutes = timeInMillis ~/ 60000;
    final _seconds = (timeInMillis ~/ 1000) % 60;

    if (_minutes < 10) {
      _minutesString = '0$_minutes';
    } else
      _minutesString = '$_minutes';

    if (_seconds < 10) {
      _secondsString = '0$_seconds';
    } else
      _secondsString = '$_seconds';

    return '$_minutesString : $_secondsString';
  }

  String createTimeAppBarString(int _time) {
    int min;
    int sec;
    String seconds;
    String minutes;

    if (_time != null) {
      min = _time ~/ 60;
      sec = _time % 60;
      int length_seconds = sec.toString().length;
      int length_minutes = min.toString().length;

      if (length_seconds < 2) {
        seconds = '0' + sec.toString();
      } else {
        seconds = sec.toString();
      }

      if (length_minutes < 2) {
        minutes = '0' + min.toString();
      } else {
        minutes = min.toString();
      }
      return minutes + " : " + seconds;

    } else {
      return "00 : 00";
    }
  }
}