import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pixbit_test/events/designation_event.dart';
import 'package:pixbit_test/events/home_events.dart';
import 'package:pixbit_test/events/login_event.dart';
import 'package:pixbit_test/helpers/api_endpoints.dart';
import 'package:pixbit_test/helpers/shared_preferences.dart';
import 'package:pixbit_test/models/designations_model.dart';
import 'package:pixbit_test/models/employees_model.dart';
import 'package:pixbit_test/repositories/designations_repository.dart';
import 'package:pixbit_test/repositories/list_contacts_repository.dart';
import 'package:pixbit_test/repositories/login_repository.dart';
import 'package:pixbit_test/state/designtaions_state.dart';
import 'package:pixbit_test/state/home_state.dart';
import 'package:pixbit_test/state/login_state.dart';

import '../screens/home_screen.dart';

class DesignationsBloc extends Bloc<DesignationsMainEvent, DesignationsMainState> {
  DesignationsRepository designationsRepository = DesignationsRepository();
  List<DesignationsModel> designationsData = [];
  DesignationsBloc({required this.designationsRepository}) : super(DesignationsLoadingState()) {
    on<DesignationsDataEvent>((event, emit) async {
      emit(DesignationsLoadingState());

      try {
        var response = await designationsRepository.getAllDesignations();
        print("contct res is $response");
        response['data']['data'].forEach((e) {
          designationsData.add(DesignationsModel.fromJson(e));
        });

        emit(DesignationsLoadedState(designationsModel: designationsData));
      } catch (e) {
        print(e);
        emit(DesignationsErrorState(message: e.toString()));
      }
    });
  }
}
