import 'dart:io';

const REVENUE_IOS_KEY = 'klRWquXussoxppFDFBOGwoZvTgwawgBm';
const REVENUE_ANDROID_KEY = 'joxdRNutDmmrudomDHmIbGerKngVcZlD';

final String REVENUE_KEY =
    Platform.isIOS ? REVENUE_IOS_KEY : REVENUE_ANDROID_KEY;

final String UrlAgreement =
    'https://mymorningnow.blogspot.com/p/terms-of-use.html';
final String UrlPrivacy =
    'https://mymorningnow.blogspot.com/p/privacy-policy.html';

// Мин кол-во секунд для записи в журнал прогресса
const int minPassedSec = 15;
