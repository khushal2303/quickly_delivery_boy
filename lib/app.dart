import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickly_delivery/custom_widgets/accept_reject_delivery_widget.dart';
import 'package:quickly_delivery/data/app_dio.dart';
import 'package:quickly_delivery/data/profile/profile_datasource.dart';
import 'package:quickly_delivery/data/profile/profile_repository.dart';
import 'package:quickly_delivery/data/vehicale/vehicale_datasource.dart';
import 'package:quickly_delivery/data/vehicale/vehicale_repository.dart';
import 'package:quickly_delivery/screens/dashboard/dashboard_page.dart';
import 'package:quickly_delivery/screens/login/login_screen.dart';
import 'package:quickly_delivery/screens/personal_detail/bloc/profile_bloc.dart';
import 'package:quickly_delivery/screens/personal_detail/location_bloc/location_bloc.dart';
import 'package:quickly_delivery/screens/personal_detail/personal_detail_page.dart';
import 'package:quickly_delivery/screens/personal_detail/views/add_address_page.dart';
import 'package:quickly_delivery/screens/personal_detail/views/search_city_page.dart';
import 'package:quickly_delivery/screens/splash/bloc/authentication_bloc.dart';
import 'package:quickly_delivery/screens/splash/splash_screen.dart';
import 'package:quickly_delivery/screens/vehicale_detail_screen/bloc/vehicale_bloc_bloc.dart';
import 'package:quickly_delivery/screens/vehicale_detail_screen/vehical_detail_page.dart';

import 'data/authenticate/authentication_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        child: const AppView(),
        providers: [
          BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider(
            create: (_) => LocationBloc(),
          ),
          BlocProvider(
            create: (_) => VehicaleBloc(
              repository: VehicaleRepository(
                VehicaleDataSource(
                  dio: AppDio.getInstance(),
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (_) => ProfileBloc(
              repository: ProfileRepository(
                ProfileDataSource(
                  dio: AppDio.getInstance(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class _AppViewState extends State<AppView> {
  NavigatorState get _navigator => navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        // If you push the PassArguments route
        if (settings.name == CitySearchPage.routeName) {
          final args = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return CitySearchPage(
                sessionToken: args,
              );
            },
          );
        }
        if (settings.name == PersonalDetailPage.routeName) {
          return MaterialPageRoute(
            builder: (context) {
              return const PersonalDetailPage();
            },
          );
        }

        if (settings.name == AddAddressPage.routeName) {
          return MaterialPageRoute(
            builder: (context) {
              return const AddAddressPage();
            },
          );
        }
        return SplashScreen.route();
      },
      theme: ThemeData(fontFamily: 'Montserrat'),
      navigatorKey: navigatorKey,
      routes: {
        PersonalDetailPage.routeName: (context) => const PersonalDetailPage(),
        AddAddressPage.routeName: (context) => const AddAddressPage(),
        CitySearchPage.routeName: (context) => const CitySearchPage(
              sessionToken: "",
            ),
      },
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                // _navigator.pushNamedAndRemoveUntil(
                //     PersonalDetailPage.routeName, (route) => false);
                _navigator.pushAndRemoveUntil<void>(
                  DashboardPage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                // _navigator.pushNamedAndRemoveUntil(
                //     PersonalDetailPage.routeName, (route) => false);
                _navigator.pushAndRemoveUntil<void>(
                  LoginScreen.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: child!,
          ),
        );
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
