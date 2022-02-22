import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Flavor { development, production }

class ConstantImages {
  static const String appIcon = "assets/icons/app_icon.jpg";
  static const String splashIcon = "assets/images/splash_icon.jpg";
  static const String loginIcon = "assets/images/login_page.svg";
  static const String emptyProfileIcon = "assets/images/profile_photo.jpg";
  static const String searchIcon = "assets/images/search_icon.jpg";

  static const String bikeIcon = "assets/images/Bike.jpg";
  static const String cycleIcon = "assets/images/cycle.jpg";
  static const String locationIcon = "assets/images/location.jpg";
  static const String locationPinIcon = "assets/images/location_pin.png";

  static const String dashboardLogo = "assets/images/dashboard_logo.jpg";

  static const String darkTaskIcon = "assets/images/dark_task.jpg";
  static const String lightTaskIcon = "assets/images/light_task.jpg";
  static const String lightFeedIcon = "assets/images/light_feed.jpg";
  static const String darkFeedIcon = "assets/images/dark_feed.jpg";
  static const String lightProfileIcon = "assets/images/light_profile.jpg";
  static const String darkProfileIcon = "assets/images/dark_profile.jpg";

  static const String balanceIcon = "assets/images/balance_icon.jpg";

  static const String mangoIcon = "assets/images/mango.jpg";
  static const String potatoIcon = "assets/images/potato.jpg";

  static const String collectionIcon = "assets/images/collection.jpg";
  static const String bankAccountIcon = "assets/images/bank_account.jpg";
  static const String payoutsIcon = "assets/images/payouts.jpg";
  static const String walletIcon = "assets/images/wallet_1.jpg";

  static const String logoutIcon = "assets/images/logout.jpg";

  static const String walletListIcon = "assets/images/wallet_list.jpg";
  static const String caseCollectionIcon = "assets/images/case_collection.jpg";
  static const String payoutListIcon = "assets/images/payout_list.jpg";
}

@immutable
class Constants {
  static num userId = 0;
  static num storeId = 1;
  static num deliveryBoyId = 0;
  static String userEmail = "";
  static num homePagePerDataLimit = 10;
  static num cartPagePerDataLimit = 500;

  static final String androidKey = 'AIzaSyDUi0Nx5jIr_nHB0_wWfUdUSCc_Kl6FxI0';
  static final String iosKey = 'YOUR_API_KEY_HERE';

  static String getNextPageId(String url) {
    Map<String, dynamic> param = Uri.parse(url).queryParameters;
    return param['offset'].toString();
  }

  const Constants({
    required this.endpoint,
    required this.apiKey,
  });

  factory Constants.of() {
    if (_instance != null) return _instance!;

    final flavor = EnumToString.fromString(
      Flavor.values,
      const String.fromEnvironment('FLAVOR'),
    );

    switch (flavor) {
      case Flavor.development:
        _instance = Constants._dev();
        break;
      case Flavor.production:
      default:
        _instance = Constants._prd();
    }
    return _instance!;
  }

  factory Constants._dev() {
    return const Constants(
      endpoint: 'http://139.59.53.172/api/v1/',
      apiKey: '',
    );
  }

  factory Constants._prd() {
    return const Constants(
      endpoint: 'http://139.59.53.172/api/v1/',
      apiKey: '', //for use in future
    );
  }

  static Constants? _instance;

  final String endpoint;
  final String apiKey;
}

class DocumentTypes {
  static String aadharCard = "aadhar_card";
  static String addressProof = "address_proof";
  static String bankAccountPassbook = "bank_account_passbook";
  static String drivingLicense = "driving_license";
  static String other = "other";
  static String panCard = "pan_card";
  static String voterId = "voter_id";
}
