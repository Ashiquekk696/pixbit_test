import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pixbit_test/events/home_events.dart';
import 'package:pixbit_test/events/login_event.dart';
import 'package:pixbit_test/helpers/api_endpoints.dart';
import 'package:pixbit_test/helpers/shared_preferences.dart';
import 'package:pixbit_test/models/employees_model.dart';
import 'package:pixbit_test/repositories/list_contacts_repository.dart';
import 'package:pixbit_test/repositories/login_repository.dart';
import 'package:pixbit_test/state/home_state.dart';
import 'package:pixbit_test/state/login_state.dart';

import '../screens/home_screen.dart';

class HomeBloc extends Bloc<HomeMainEvent, HomeMainState> {
  ContactsRepository contactsRepository = ContactsRepository();
  List<EmployeeModel> employeeData = [];
  var page;
  HomeBloc({required this.contactsRepository,this.page}) : super(HomeLoadingState()) {
    on<HomeDataEvent>((event, emit) async {
      emit(HomeLoadingState());

      try {
        var response =
            await contactsRepository.getAllContacts(page:page);
        print("contct res is $response");
        response['data']['data'].forEach((e) {
          employeeData.add(EmployeeModel.fromJson(e));
        });

        emit(HomeLoadedState(employeeModel: employeeData));
      } catch (e) {
        print(e);
        emit(HomeErrorState(message: e.toString()));
      }
    });
  }
}
