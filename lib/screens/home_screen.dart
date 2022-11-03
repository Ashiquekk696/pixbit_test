import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixbit_test/bloc/home_bloc.dart';
import 'package:pixbit_test/events/home_events.dart';
import 'package:pixbit_test/helpers/app_colors.dart';
import 'package:pixbit_test/helpers/app_style.dart';
import 'package:pixbit_test/repositories/add_employee_repository.dart';
import 'package:pixbit_test/repositories/designations_repository.dart';
import 'package:pixbit_test/repositories/list_contacts_repository.dart';
import 'package:pixbit_test/repositories/login_repository.dart';
import 'package:pixbit_test/screens/add_employee_screen.dart';
import 'package:pixbit_test/screens/employee_details_screen.dart';
import 'package:pixbit_test/state/home_state.dart';
import 'package:pixbit_test/widgets/app_bar_widget.dart';
import 'package:pixbit_test/widgets/loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    getScrolledData();
    super.initState();
  }

  var currentPage = 1;
  getScrolledData() async {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        currentPage++;
        print(currentPage);
        BlocProvider(
            create: (context) => HomeBloc(
                contactsRepository:
                    RepositoryProvider.of<ContactsRepository>(context),
                page: currentPage.toString()));
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RepositoryProvider(
                      create: (context) => AddEmployeeReposiotry(),
                      child: RepositoryProvider(
                          create: (context) => DesignationsRepository(),
                          child: AddEmployeeScreen()))));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc(
            contactsRepository:
                RepositoryProvider.of<ContactsRepository>(context),
            page: currentPage.toString())
          ..add(HomeDataEvent()),
        child: Column(
          children: [
            AppBarWidget(
              label: "Employee",
            ),
            Expanded(
                child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: BlocBuilder<HomeBloc, HomeMainState>(
                  builder: (context, state) {
                if (state is HomeLoadingState) {
                  return Loader();
                }
                if (state is HomeErrorState) {
                  print("loading");
                }

                if (state is HomeLoadedState) {
                  getScrolledData() async {
                    scrollController.addListener(() {
                      if (scrollController.position.pixels ==
                          scrollController.position.maxScrollExtent) {
                        currentPage++;
                        print(currentPage);

                        setState(() {});
                      }
                    });
                  }

                  return ListView.builder(
                      controller: scrollController
                        ..addListener(() {
                          getScrolledData();
                          if (scrollController.position.pixels ==
                              scrollController.position.maxScrollExtent) {
                            BlocProvider(
                                create: (context) => HomeBloc(
                                    contactsRepository: RepositoryProvider.of<
                                        ContactsRepository>(context),
                                    page: currentPage.toString()));
                          }
                        }),
                      itemCount: state.employeeModel?.length ?? 0,
                      itemBuilder: (context, i) {
                        return Column(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EmployeeDetailsScreen(
                                                employeeData:
                                                    state.employeeModel?[i],
                                              )));
                                },
                                child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(left: 20),
                                  height: 77,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 55,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(state
                                                        .employeeModel?[i]
                                                        .profileImage ??
                                                    ""),
                                                fit: BoxFit.fill)),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                state.employeeModel?[i]
                                                        .firstName ??
                                                    "",
                                                style: AppStyles()
                                                    .mediumSmallText(),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                state.employeeModel?[i]
                                                        .lastName ??
                                                    "",
                                                style: AppStyles()
                                                    .mediumSmallText(),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            state.employeeModel?[i].mobile
                                                    .toString() ??
                                                "",
                                            style: AppStyles().smallText(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        );
                      });
                }
                return Loader();
              }),
            ))
          ],
        ),
      ),
    );
  }
}
