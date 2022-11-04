import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixbit_test/bloc/login_bloc.dart';
import 'package:pixbit_test/events/login_event.dart';
import 'package:pixbit_test/helpers/app_colors.dart';
import 'package:pixbit_test/helpers/app_style.dart';
import 'package:pixbit_test/repositories/login_repository.dart';
import 'package:pixbit_test/state/login_state.dart';
import 'package:pixbit_test/widgets/button_widget.dart';
import 'package:pixbit_test/widgets/loader.dart';
import 'package:pixbit_test/widgets/text_field_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocProvider(
          create: (context) => LoginBloc(
              loginRepository: RepositoryProvider.of<LoginRepository>(context)),
          child: BlocListener<LoginBloc, LoginMainState>(
            listener: (context, state) {
              if (state is LoginErrorState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: BlocBuilder<LoginBloc, LoginMainState>(
                builder: (context, state) {
              if (state is LoginLoadingState) {
                return Loader();
              }

              if (state is LoginErrorState) {}

              return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 140,
                            ),
                            Text(
                              "Welcome Back",
                              style: AppStyles().largeText(),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Please login to your account",
                              style: AppStyles().smallText(),
                            ),
                            SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          decoration: BoxDecoration(
                              color: Color(AppColors.lightBlueColor),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(22),
                                  topRight: Radius.circular(22))),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 66,
                              ),
                              TextFieldWidget(
                                validator: (value) {
                                  if (value.trim().isEmpty)
                                    return "Username required";

                                  return null;
                                },
                                controller: userNameController,
                                inputFormatter: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z0-9@&.]")),
                                ],
                                label: "Username",
                                icon: Icons.mail,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              TextFieldWidget(
                                validator: (v) {
                                  if (v.trim().isEmpty)
                                    return "Password required";
                                  if (passwordController.text.length < 5) {
                                    return "Minimum 5 digits have to be added";
                                  }
                                },
                                controller: passwordController,
                                label: "Password",
                                icon: Icons.key,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ButtonWidget(
                                onPressed: () {
                                  print("object");
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<LoginBloc>(context)
                                        .add(LoginPressedEvent(
                                            context: context,
                                            userName:
                                            //"nidhinnp@gmail.com",

                                        userNameController.text,
                                            password:
                                            //"12345678Np"
                                           passwordController.text
                                            ));
                                  }
                                },
                                label: "Sign in",
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ));
              // }
            }),
          ),
        ),
      ),
    );
  }
}
