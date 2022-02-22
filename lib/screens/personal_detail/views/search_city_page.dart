import 'package:flutter/material.dart';
import 'package:quickly_delivery/constants/constants.dart';
import 'package:quickly_delivery/screens/location_search/place_service.dart';
import 'package:quickly_delivery/screens/personal_detail/bloc/profile_bloc.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';
import 'package:provider/provider.dart';

import 'add_address_page.dart';

class CitySearchPage extends StatefulWidget {
  final String sessionToken;
  const CitySearchPage({Key? key, required this.sessionToken})
      : super(key: key);

  static const routeName = "/search_city";

  @override
  _CitySearchPageState createState() => _CitySearchPageState();
}

class _CitySearchPageState extends State<CitySearchPage> {
  TextEditingController searchQuery = TextEditingController();
  PlaceApiProvider? apiClient;

  @override
  void initState() {
    apiClient = PlaceApiProvider(widget.sessionToken);
    searchQuery.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 65,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 12, right: 12, top: 16),
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TextField(
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                controller: searchQuery,
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.start,
                onSubmitted: (String _) {},
                cursorColor: AppColors.lightColor,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Search city...",
                  prefixIcon: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  suffixIcon: Image.asset(ConstantImages.searchIcon),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColors.dividerColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColors.dividerColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColors.dividerColor,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyles.semiBold17(AppColors.lightColor),
                  counterText: "",
                ),
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: getBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    return FutureBuilder(
      future: searchQuery.text == ""
          ? null
          : apiClient!.fetchSuggestions(
              searchQuery.text, Localizations.localeOf(context).languageCode),
      builder: (context, AsyncSnapshot<List<Suggestion>?> snapshot) =>
          searchQuery.text == ''
              ? Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Search city',
                    style: TextStyles.medium17(AppColors.blackColor),
                  ),
                )
              : snapshot.hasData
                  ? ((snapshot.data?.length ?? 0) > 0)
                      ? ListView.builder(
                          itemBuilder: (context, index) => ListTile(
                            leading: const Icon(
                              Icons.location_on,
                              color: AppColors.primaryColor,
                            ),
                            title: Text(
                              (snapshot.data![index]).description,
                              style: TextStyles.medium14(AppColors.blackColor),
                            ),
                            onTap: () {
                              context.read<ProfileBloc>().add(SetGooglePlaceId(
                                  snapshot.data![index].placeId));
                              Navigator.pushNamed(
                                  context, AddAddressPage.routeName,
                                  arguments: snapshot.data![index].placeId);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (BuildContext context) =>
                              //           const AddAddressPage()),
                              // );
                            },
                          ),
                          itemCount: snapshot.data?.length,
                        )
                      : Text('Search result not found',
                          style: TextStyles.medium17(AppColors.blackColor))
                  : Text('Loading...',
                      style: TextStyles.medium17(AppColors.blackColor)),
    );
  }
}

// class CitySearchPage extends SearchCityDelegate<UserAddress> {
//   CitySearchPage(this.sessionToken) {
//     apiClient = PlaceApiProvider(sessionToken);
//   }
//
//   final sessionToken;
//   PlaceApiProvider? apiClient;
//
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         tooltip: 'Clear',
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       )
//     ];
//   }
//
//   @override
//   Widget? buildLeading(BuildContext context) {
//     return null;
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     return Text("");
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return FutureBuilder(
// //       future: query == ""
// //           ? null
// //           : apiClient!.fetchSuggestions(
// //               query, Localizations.localeOf(context).languageCode),
// //       builder: (context, AsyncSnapshot<List<Suggestion>?> snapshot) =>
// //           query == ''
// //               ? Container(
// //                   padding: const EdgeInsets.all(16.0),
// //                   child: Text(
// //                     'Search city',
// //                     style: TextStyles.medium17(AppColors.blackColor),
// //                   ),
// //                 )
// //               : snapshot.hasData
// //                   ? ((snapshot.data?.length ?? 0) > 0)
// //                       ? ListView.builder(
// //                           itemBuilder: (context, index) => ListTile(
// //                             leading: const Icon(
// //                               Icons.location_on,
// //                               color: AppColors.primaryColor,
// //                             ),
// //                             title: Text(
// //                               (snapshot.data![index]).description,
// //                               style: TextStyles.medium14(AppColors.blackColor),
// //                             ),
// //                             onTap: () {
// //                               Navigator.pushNamed(
// //                                   context, AddAddressPage.routeName);
// //                               // Navigator.push(
// //                               //   context,
// //                               //   MaterialPageRoute(
// //                               //       builder: (BuildContext context) =>
// //                               //           const AddAddressPage()),
// //                               // );
// //                             },
// //                           ),
// //                           itemCount: snapshot.data?.length,
// //                         )
// //                       : Text('Search result not found',
// //                           style: TextStyles.medium17(AppColors.blackColor))
// //                   : Text('Loading...',
// //                       style: TextStyles.medium17(AppColors.blackColor)),
// //     );
//   }
// }
