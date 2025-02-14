import 'package:JoDija_view/util/localization/loaclized_init.dart';
import 'package:flutter/cupertino.dart';

class Translation {
  static final Translation _singleton = Translation._internal();
  factory Translation() {
    return _singleton;
  }


AppLocal get appLocal => translate();
  Translation._internal() {

  }

  Map<String, AppLocal> transelation = {};
  AppLocal translate() {
    return transelation[LocalizationConfig().locale.languageCode]!;
  }

  AppLocal translateOf(BuildContext context) {
    return AppLocal.of(context);
  }

  void getlocal() {

    var localval = LocalizationConfig().localizedValues;
    localval.forEach((key, value) {
      transelation[key] = value as AppLocal;
    });
  }
}

abstract class AppLocal extends AppLocalizationsInit {
  static AppLocal of(BuildContext context) {
    return Localizations.of<AppLocal>(context, AppLocal)!;
  }

  AppLocal();
  String get email;
  String get password;
  String get titelHeader;
  String get mainTextheader;
  String get connect;
  String get signIn;
  String get signUp;
  String get changeLanguage;
  String get dashbordTitle;
  String get catigory;
  String  get add;
  String get addCatigory;
  String get addProduct;
  String get addCleint;
  String get productName;
  String get productPrice;
  String get productQuantity;
  String get productTotal ;
  String get clientName;
  String get clientPhone;
  String get leaveYourMassage;
  String get clientEmail;
  String get suggest;
  String get clientAddress;
  String get addOrder;
  String get Cancel;
  String get total;
  String get taxRate;
  String get tax;
  String get netTotal;
  String get OrderDate;
  String get status;
  String get orderNumber;
  String get order;
  String get Ok;
  String get client;
  String get taxRateValue;
  String get taxValue;
  String get thankYouForSuggesment;
  String get netTotalValue;
  String get statusValue;
  String get orderDate;
  String get Print ;
  String get pending;
  String get processing;
  String get delivered;
  String get cancelledFromClient;
  String get returned;
  String get completed;
  String get cancelledFromSupplier;
  String get productsDetails;
  String get close;
  String get save;
  String get edit;
  String get delete;
  String get done ;
  String get next ;
  String get search_for_product;
  String get search_for_client;
  String get productDataSideBar;
  String get clientDataSideBar;
  String get salesMovementSideBar;
  String get noData;
  String get forgotPassword;
  String get moreChoices;
  String get SideBareProfile;
  String get SideBareSuggestion;
  String get SideBareContactUs;
  String get SideBareLogOut;
  String get DrowEngetTextWrite;
  String get DrowEngetTextFontSize;
  String get DrowEngetTextFontFamily;
  String get DrowEngetTextFontDecoration;
  String get DrowEngetTextEnterText;
  String get DrowEngetTextEnterLink;
  String get DrowEngetTextPastLinkHere;
  String get DrowEngetTextPastLinkEdit;
  String get writeWhatYouWantHere;
  String get writeYourFeelingsHere;
  String get appDescription;
  String get hoveNoAccount;
  String get hoveAccount;
  String get registWithUs;


  String get ScreenPrintSetting ;
  String get ScreenPrint;
String get  ScreenPrintSingleCard;
String get  ScreenPrintDoubleCard;




}
