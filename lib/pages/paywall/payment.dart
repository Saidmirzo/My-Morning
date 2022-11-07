// import 'dart:io';
// import 'dart:ui';
// import 'package:adapty_flutter/models/adapty_paywall.dart';
// import 'package:app_tracking_transparency/app_tracking_transparency.dart';
// import 'package:appmetrica_plugin/appmetrica_plugin.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:morningmagic/components/dialog_component.dart';
// import 'package:morningmagic/dialog/connection_dialog.dart';
// import 'package:morningmagic/pages/paywall/payment_sale.dart';
// import 'package:morningmagic/pages/welcome/welcome_page.dart';
// import 'package:morningmagic/resources/colors.dart';
// import 'package:morningmagic/resources/my_const.dart';
// import 'package:morningmagic/services/analitics/all.dart';
// import 'package:morningmagic/services/analitics/analyticService.dart';
// import 'package:morningmagic/services/connection_service/connection_service.dart';
// import 'package:morningmagic/services/notifications.dart';
// import 'package:morningmagic/utils/shared_preferences.dart';
// import 'package:morningmagic/widgets/my_url.dart';
// import '../../adjust_config.dart';
// import '../../storage.dart';

// class PaymentPage extends StatefulWidget {
//   const PaymentPage({Key key}) : super(key: key);

//   @override
//   State<PaymentPage> createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   int _selected = 0;
//   @override
//   void initState() {
//     super.initState();

//     CustomSharedPreferences().isFirstOpen().then((value) {
//       if (value) {
//         AppMetrica.reportEvent('paywall_open');
//       } else {
//         AppMetrica.reportEvent('paywall_inapp_open');
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           SizedBox(
//             child: SvgPicture.asset("assets/images/paywall/paywall_bg.svg",
//                 fit: BoxFit.cover),
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           FutureBuilder(
//             future: billingService.getPaywall("paywall_1"),
//             builder: (context, AsyncSnapshot<AdaptyPaywall> snapshot) {
//               if (snapshot.hasError) {
//                 ScaffoldMessenger.of(context)
//                     .showSnackBar(SnackBar(content: Text(snapshot.error)));
//               }
//               if (!snapshot.hasData || snapshot.hasError) {
//                 return const SizedBox.shrink();
//               }
//               List products = snapshot.data.customPayload['products'];
//               return Stack(
//                 children: [
//                   ClipRRect(
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                       child: SafeArea(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 0, horizontal: 20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   IconButton(
//                                     onPressed: () async {
//                                       Get.back();
//                                       if (await CustomSharedPreferences()
//                                               .isOpenSale() ||
//                                           await CustomSharedPreferences()
//                                               .isFirstOpen()) {
//                                         AppMetrica.reportEvent('paywall_close');
//                                         Get.to(const PaymentSalePage());
//                                       } else {
//                                         AppMetrica.reportEvent(
//                                             'paywall_inapp_close');
//                                       }
//                                     },
//                                     icon: const Icon(Icons.close),
//                                     constraints: const BoxConstraints(),
//                                   ),
//                                 ],
//                               ),
//                               RichText(
//                                 textAlign: TextAlign.center,
//                                 text: TextSpan(
//                                   style: const TextStyle(fontSize: 27),
//                                   children: [
//                                     TextSpan(
//                                         text:
//                                             "paywall_title".tr.split("@d")[0]),
//                                     TextSpan(
//                                         text: "paywall_title".tr.split("@d")[1],
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.w800)),
//                                     TextSpan(
//                                         text: "paywall_title".tr.split("@d")[2],
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.w800)),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 15),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: HexColor("#844BB9"),
//                                   borderRadius: BorderRadius.circular(100),
//                                 ),
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 15, vertical: 5),
//                                 child: Text(
//                                   'cancel_subscribe_any_time'.tr,
//                                   style: const TextStyle(
//                                       color: Colors.white, fontSize: 15),
//                                 ),
//                               ),
//                               const Spacer(),
//                               Column(
//                                 children: [
//                                   for (var i = 0; i < products.length; i++) ...[
//                                     GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           _selected = i;
//                                         });
//                                       },
//                                       child: Container(
//                                         width: double.infinity,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: HexColor("#592F72")
//                                                   .withOpacity(0.4),
//                                               spreadRadius: 2,
//                                               blurRadius: 10,
//                                               offset: const Offset(0, 0),
//                                             )
//                                           ],
//                                         ),
//                                         child: Card(
//                                           clipBehavior:
//                                               Clip.antiAliasWithSaveLayer,
//                                           color: _selected == i &&
//                                                   products.length > 1
//                                               ? HexColor("#E8DFFF")
//                                               : Colors.white,
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(15),
//                                             side: _selected == i
//                                                 ? BorderSide(
//                                                     color: HexColor("#8400FF"),
//                                                     width: 4)
//                                                 : const BorderSide(
//                                                     color: Colors.transparent,
//                                                     width: 4),
//                                           ),
//                                           child: Stack(
//                                             children: [
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         vertical: 25,
//                                                         horizontal: 15),
//                                                 child: Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                         products[i]['title'][Get
//                                                                         .locale
//                                                                         .languageCode ==
//                                                                     "ru"
//                                                                 ? "ru"
//                                                                 : "en"]
//                                                             .toString()
//                                                             .replaceAll(
//                                                                 "@price",
//                                                                 "${snapshot.data.products[i].price} ${snapshot.data.products[i].currencySymbol}"),
//                                                         style: TextStyle(
//                                                             fontSize:
//                                                                 Platform.isIOS
//                                                                     ? 18
//                                                                     : 17,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             color: AppColors
//                                                                 .violet)),
//                                                     Text(
//                                                         products[i]['body'][
//                                                                 Get.locale.languageCode == "ru"
//                                                                     ? "ru"
//                                                                     : "en"]
//                                                             .toString()
//                                                             .replaceAll(
//                                                                 "@price_month",
//                                                                 "${(snapshot.data.products[i].price / 12).toStringAsFixed(2)} ${snapshot.data.products[i].currencySymbol}")
//                                                             .replaceAll(
//                                                                 "@price_day_month",
//                                                                 "${(snapshot.data.products[i].price / 30).toStringAsFixed(2)} ${snapshot.data.products[i].currencySymbol}")
//                                                             .replaceAll(
//                                                                 "@price_day_year",
//                                                                 "${(snapshot.data.products[i].price / 360).toStringAsFixed(2)} ${snapshot.data.products[i].currencySymbol}")
//                                                             .replaceAll(
//                                                                 "@price",
//                                                                 "${snapshot.data.products[i].price} ${snapshot.data.products[i].currencySymbol}"),
//                                                         style: TextStyle(
//                                                             fontSize: Platform.isIOS
//                                                                 ? 15
//                                                                 : 14,
//                                                             color: AppColors.violet)),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Visibility(
//                                                 visible: i == 0 &&
//                                                     products.length > 1,
//                                                 child: Positioned(
//                                                   top: 0,
//                                                   right: 0,
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color:
//                                                           HexColor("#9B51E0"),
//                                                       borderRadius:
//                                                           const BorderRadius
//                                                                   .only(
//                                                               bottomLeft: Radius
//                                                                   .circular(
//                                                                       20)),
//                                                     ),
//                                                     padding: const EdgeInsets
//                                                             .symmetric(
//                                                         horizontal: 22,
//                                                         vertical: 7),
//                                                     child: Text(
//                                                       "popular".tr,
//                                                       style: TextStyle(
//                                                           color: Colors.white,
//                                                           fontWeight:
//                                                               FontWeight.w500,
//                                                           fontSize:
//                                                               Platform.isIOS
//                                                                   ? 14
//                                                                   : 13),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 10),
//                                   ]
//                                 ],
//                               ),
//                               if (products.length == 1) ...[
//                                 const Spacer(),
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 20, vertical: 12),
//                                   decoration: BoxDecoration(
//                                       color: HexColor("#592F72"),
//                                       borderRadius: BorderRadius.circular(100)),
//                                   child: Text(
//                                     products.first['features_title'][
//                                         Get.locale.languageCode == "ru"
//                                             ? "ru"
//                                             : "en"],
//                                     style: TextStyle(
//                                         fontSize: Platform.isIOS ? 14 : 13,
//                                         color: Colors.white),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 15),
//                                 Column(
//                                   children: [
//                                     for (var i = 0;
//                                         i <
//                                             products
//                                                 .first['features'][
//                                                     Get.locale.languageCode ==
//                                                             "ru"
//                                                         ? "ru"
//                                                         : "en"]
//                                                 .length;
//                                         i++) ...[
//                                       Row(
//                                         children: [
//                                           SvgPicture.asset(
//                                               "assets/images/paywall/feature_done.svg",
//                                               width: 30,
//                                               height: 30),
//                                           const SizedBox(width: 10),
//                                           Flexible(
//                                             child: Text(
//                                               products.first['features'][
//                                                   Get.locale.languageCode ==
//                                                           "ru"
//                                                       ? "ru"
//                                                       : "en"][i],
//                                               style: TextStyle(
//                                                   fontSize:
//                                                       Platform.isIOS ? 15 : 14,
//                                                   color: HexColor("#592F72")),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 20),
//                                     ],
//                                   ],
//                                 ),
//                               ],
//                               // const SizedBox(height: 15),
//                               const Spacer(),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   RichText(
//                                       text: myUrl(
//                                           'privacy_title'.tr, UrlPrivacy,
//                                           textColor: AppColors.violet,
//                                           underline: false)),
//                                   // const SizedBox(height: 5),
//                                   RichText(
//                                       text: myUrl(
//                                           'agreement_title'.tr, UrlAgreement,
//                                           textColor: AppColors.violet,
//                                           underline: false)),
//                                 ],
//                               ),
//                               const SizedBox(height: 15),
//                               // continue button
//                               Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   boxShadow: const [
//                                     BoxShadow(
//                                       color: Colors.white,
//                                       spreadRadius: 6,
//                                       blurRadius: 60,
//                                       offset: Offset(0, 0),
//                                     )
//                                   ],
//                                 ),
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     primary: AppColors.violetOnb,
//                                     minimumSize: Size(double.infinity,
//                                         Platform.isIOS ? 70 : 60),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                   ),
//                                   onPressed: () async {
//                                     if (await ConnectionRepo.isConnected()) {
//                                       try {
//                                         DialogComponent().loading();
//                                         AppMetrica.reportEvent(
//                                             'paywall_inapp_close');
//                                         await billingService.purchase(
//                                             snapshot.data.products[_selected]);
//                                         appAnalitics.logEvent('first_trial');
//                                         AnalyticService.analytics
//                                             .logEcommercePurchase(
//                                                 value: snapshot.data
//                                                     .products[_selected].price,
//                                                 currency: snapshot
//                                                     .data
//                                                     .products[_selected]
//                                                     .currencyCode);
//                                         AdJust.trackevent(AdJust.trialEvent);
//                                         billingService.init();
//                                         Navigator.popUntil(
//                                             context, (route) => route.isFirst);
//                                         if (await CustomSharedPreferences()
//                                                 .isOpenSale() ||
//                                             await CustomSharedPreferences()
//                                                 .isFirstOpen()) {
//                                           AppMetrica.reportEvent(
//                                               'subscription_trial');
//                                           Get.to(const WelcomePage());
//                                           pushNotifications =
//                                               PushNotifications();
//                                           WidgetsBinding.instance
//                                               .addPostFrameCallback(
//                                             (timeStamp) async {
//                                               if (GetPlatform.isIOS) {
//                                                 AppTrackingTransparency
//                                                     .requestTrackingAuthorization();
//                                               }
//                                             },
//                                           );
//                                         } else {
//                                           AppMetrica.reportEvent(
//                                               'subscription_inapp_trial');
//                                         }
//                                       } catch (e) {
//                                         Get.back();
//                                         print(e);
//                                       }
//                                     } else {
//                                       showDialog(
//                                         context: context,
//                                         builder: (context) {
//                                           return const ConnectionDialog();
//                                         },
//                                       );
//                                     }
//                                   },
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       const SizedBox(width: 25),
//                                       const Spacer(),
//                                       Text(
//                                         billingService.isPro()
//                                             ? 'change_tarif'.tr
//                                             : 'continue'.tr,
//                                         style: const TextStyle(
//                                             fontSize: 17,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       const Spacer(),
//                                       const Icon(Icons.arrow_forward, size: 25),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               GestureDetector(
//                                 onTap: () async {
//                                   if (await ConnectionRepo.isConnected()) {
//                                     billingService.restore();
//                                   } else {
//                                     showDialog(
//                                       context: context,
//                                       builder: (context) {
//                                         return const ConnectionDialog();
//                                       },
//                                     );
//                                   }
//                                 },
//                                 child: Text(
//                                   'restore'.tr,
//                                   style: const TextStyle(
//                                       color: AppColors.primary,
//                                       decoration: TextDecoration.underline),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
