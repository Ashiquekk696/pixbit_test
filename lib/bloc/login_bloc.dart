import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixbit_test/events/login_event.dart';
import 'package:pixbit_test/helpers/api_endpoints.dart';
import 'package:pixbit_test/helpers/shared_preferences.dart';
import 'package:pixbit_test/repositories/list_contacts_repository.dart';
import 'package:pixbit_test/repositories/login_repository.dart';
import 'package:pixbit_test/state/login_state.dart';

import '../screens/home_screen.dart';

class LoginBloc extends Bloc<LoginMainEvent, LoginMainState> {
  LoginRepository loginRepository;
  var errorText;
  LoginBloc({required this.loginRepository}) : super(LoginInitialState()) {
    on<LoginPressedEvent>((event, emit) async {
      emit(LoginLoadingState());

      try {
        Preferences preferences = await Preferences();
        var response = await loginRepository.loginRepository(
            email: event.userName, password: event.password);

        errorText = response['message'];
        print("error text is $errorText");
        if (response["message"] == "User Logged in") {
          await Preferences().setLoginData(
              token: response['data']['access_token'], loggedIn: true);
          Navigator.pushReplacement(
              event.context,
              MaterialPageRoute(
                  builder: (context) => RepositoryProvider(
                      create: (context) => ContactsRepository(),
                      child: HomeScreen())));

          emit(LoginLoadedState(mesage: response['message']));
        } else
          emit(LoginErrorState(message: errorText));
      } catch (e) {
        print(e);
        emit(LoginErrorState(message: errorText));
      }
    });
  }
}
