import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quickly_delivery/constants/constants.dart';
import 'package:quickly_delivery/data/authenticate/authentication_repository.dart';
import 'package:quickly_delivery/data/authenticate/login_api_models.dart';
import 'package:quickly_delivery/utils/app-prefrences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unauthenticated()) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );

    on<AuthenticationStatusChanged>((event, emit) async {
      await _mapAuthenticationStatusChangedToState(event, emit);
    });
  }

  final AuthenticationRepository _authenticationRepository;

  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
      AuthenticationStatusChanged event, emit) async {
    try {
      switch (event.status) {
        case AuthenticationStatus.unauthenticated:
          return emit(const AuthenticationState.unauthenticated());
        case AuthenticationStatus.authenticated:
          final user = await _tryGetUser();
          log("====user====user====user===user====");
          log(user?.toString() ?? "");
          Constants.userId = user?.user?.id ?? 0;
          return user != null
              ? emit(AuthenticationState.authenticated(user))
              : emit(const AuthenticationState.unauthenticated());
        default:
          return emit(const AuthenticationState.unknown());
      }
    } catch (e) {
      log("===========_mapAuthenticationStatusChangedToState==============");
      log(e.toString());
      return emit(const AuthenticationState.unknown());
    }
  }

  Future<dynamic?> _tryGetUser() async {
    try {
      final user = await AppPrefrences.instance.getSessionData();
      return user;
    } on Exception {
      return null;
    }
  }
}
