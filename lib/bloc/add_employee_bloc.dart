import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixbit_test/events/add_employee_event.dart';
import 'package:pixbit_test/events/login_event.dart';
import 'package:pixbit_test/helpers/api_endpoints.dart';
import 'package:pixbit_test/helpers/shared_preferences.dart';
import 'package:pixbit_test/repositories/add_employee_repository.dart';
import 'package:pixbit_test/repositories/list_contacts_repository.dart';
import 'package:pixbit_test/repositories/login_repository.dart';
import 'package:pixbit_test/screens/final_screen.dart';
import 'package:pixbit_test/state/add_employee_state.dart';
import 'package:pixbit_test/state/login_state.dart';

import '../screens/home_screen.dart';

class AddEmployeeBloc extends Bloc<AddEmployeeMainEvent, AddEmployeeMainState> {
  AddEmployeeReposiotry addEmployeeReposiotry = AddEmployeeReposiotry();
  AddEmployeeBloc({required this.addEmployeeReposiotry})
      : super(AddEmployeeInitialState()) {
    on<AddEmployeePressedEvent>((event, emit) async {
      emit(AddEmployeeLoadingState());

      try {
        Preferences preferences = await Preferences();
        var response = await addEmployeeReposiotry.addEmployeeREpository(
            email: event.email,
            dateOfBirth: event.dob,
            designationId: event.designationId,
            firstName: event.firstName,
            lastName: event.lastName,
            gender: event.gender,
            mobile: event.mobile,
            resume: event.resume,
            profilePicture: event.profilePicture,
            presentAddress: event.presentAddres);
        print("adddata${response['message']}");

        print("adddata${response}");
        if (response["message"] == "Employee has been saved") {
          Navigator.pushReplacement(
              event.context,
              MaterialPageRoute(
                  builder: (context) => RepositoryProvider(
                      create: (context) => ContactsRepository(),
                      child: HomeScreen())));
        }
        emit(AddEmployeeLoadedState(mesage: response['message']));
      } catch (e) {
        print(e);
        emit(AddEmployeeErrorState(message: e.toString()));
      }
    });
  }
}
