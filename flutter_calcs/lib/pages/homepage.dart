import 'package:flutter/material.dart';

import 'package:flutter_calcs/constants/color_constants.dart';
import 'package:flutter_calcs/models/project_model.dart';
import 'package:flutter_calcs/services/http_service.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';

import '../models/project_search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  late final Future<ProjectModel> futureProjects;

  List<ProjectSearch> searchList = [];
  List<ProjectSearch> finder = [];
  var jobNames = [];
  var jobNumbers = [];
  var techs = [];
  var pms = [];
  var address = [];
  var majors = [];
  var budget = [];

  @override
  void initState() {
    super.initState();
    futureProjects = fetchProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Upcoming/Live Projects',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: ColorConstants.darkScaffoldBackgroundColor,
      ),
      drawer: const CustomDrawer(),
      backgroundColor: ColorConstants.lightScaffoldBackgroundColor,

      // ignore: avoid_unnecessary_containers
      body: Center(
        child: FutureBuilder<ProjectModel>(
            future: futureProjects,
            builder: (context, snapshot) {
              // finder.clear();
              if (snapshot.hasData) {
                var data = snapshot.data!;
                // var columns = data.columns;
                var rows = data.rows;
                jobNames = [];
                jobNumbers = [];
                techs = [];
                pms = [];
                address = [];
                majors = [];
                budget = [];

                for (var item in rows!) {
                  var cells = item.cells;
                  for (var elements in cells!) {
                    if (elements.columnId != null) {
                      if (elements.columnId == 2057691532158852) {
                        var displayValues = elements.displayValue;
                        if (displayValues != null) {
                          jobNames.add(displayValues);
                        }
                        if (displayValues == null) {
                          pms.removeLast();
                          techs.removeLast();
                          address.removeLast();
                          majors.removeLast();
                          budget.removeLast();
                        }
                      }
                      if (elements.columnId == 697505454286724) {
                        var projectNumber = elements.displayValue;
                        if (projectNumber != null) {
                          jobNumbers.add(projectNumber);
                        }
                      }
                      if (elements.columnId == 7452904895342468) {
                        var techAssigned = elements.displayValue;
                        if (techAssigned != null) {
                          if (techAssigned == 'tslade@agcoombs.com.au') {
                            techAssigned = 'Travis Slade';
                            techs.add(techAssigned);
                          } else {
                            techs.add(techAssigned);
                          }
                        }
                        if (techAssigned == null) {
                          techAssigned = 'No tech assigned as yet';
                          techs.add(techAssigned);
                        }
                      }
                      if (elements.columnId == 2949305267971972) {
                        var pmName = elements.displayValue;
                        if (pmName != null) {
                          pms.add(pmName);
                        }
                        if (pmName == null) {
                          pmName = 'No project manager allocated';
                          pms.add(pmName);
                        }
                      }
                      if (elements.columnId == 5201105081657220) {
                        var addressValue = elements.displayValue;
                        if (addressValue != null) {
                          address.add(addressValue);
                        }
                        if (addressValue == null) {
                          addressValue = '';
                          address.add(addressValue);
                        }
                      }
                      if (elements.columnId == 52961559766916) {
                        var majorValue = elements.displayValue;
                        if (majorValue != null) {
                          majors.add(majorValue);
                        }
                        if (majorValue == null) {
                          majorValue = 'No';
                          majors.add(majorValue);
                        }
                      }
                      if (elements.columnId == 4226807856686980) {
                        var budgetHours = elements.displayValue;
                        if (budgetHours != null) {
                          budget.add(budgetHours);
                        }
                        if (budgetHours == null) {
                          budgetHours = 'TBA';
                          budget.add(budgetHours);
                        }
                      }
                    }
                  }
                }

                int index = 0;
                searchList = [];
                for (int i = 0; i < jobNames.length; i++) {
                  ProjectSearch myProjects = ProjectSearch(
                      address: jobNames[index],
                      budget: budget[index],
                      jobNumber: jobNumbers[index],
                      major: majors[index],
                      name: jobNames[index],
                      pM: pms[index],
                      tech: techs[index]);

                  index++;

                  searchList.add(myProjects);
                }
                return Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 20, right: 20),
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: controller,
                          onChanged: search,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true),
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.white30),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.white30,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor:
                                ColorConstants.lightScaffoldBackgroundColor,
                            labelText: 'Search or filter projects',
                            hintText: 'Search by name, job number, tech....',
                            focusColor: Colors.white,
                            labelStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                // ignore: unnecessary_const
                                color: Colors.white60,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: finder.isNotEmpty
                                ? finder.length
                                : searchList.length,
                            itemBuilder: (context, index) {
                              var projectData;
                              if (finder.isEmpty) {
                                projectData = searchList[index];
                              } else {
                                projectData = finder[index];
                              }
                              return MaterialButton(
                                onPressed: () => showModalBottomSheet<void>(
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return FractionallySizedBox(
                                      heightFactor: 0.8,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(27.0),
                                            topLeft: Radius.circular(27.0)),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          color: ColorConstants
                                              .secondaryDarkAppColor,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Flexible(
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  margin: const EdgeInsets.only(
                                                      left: 20, right: 20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10.0,
                                                                  bottom: 5.0)),
                                                      const Center(
                                                        child: Text(
                                                          'Project Details',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                      Row(
                                                        // ignore: prefer_const_literals_to_create_immutables
                                                        children: [
                                                          const Text(
                                                            'Project: ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white70,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 17),
                                                          ),
                                                          const SizedBox(
                                                              width: 20),
                                                          Flexible(
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                              child: Text(
                                                                projectData
                                                                    .name,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        17),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Flexible(
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              'Job Number: ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 17),
                                                            ),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              projectData
                                                                  .jobNumber,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 18),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              'Address: ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 17),
                                                            ),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Flexible(
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                                child: Text(
                                                                  projectData
                                                                      .address,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 3,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              'Vic Major: ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 17),
                                                            ),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              projectData.major,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 18),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            'Project Manager: ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white70,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 17),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          Flexible(
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                              child: Text(
                                                                projectData.pM,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Flexible(
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              'Technician: ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 17),
                                                            ),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              projectData.tech,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 18),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              'Budget Hours: ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 17),
                                                            ),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              projectData
                                                                  .budget,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 18),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              // ElevatedButton(
                                              //   child: const Text('Close BottomSheet'),
                                              //   onPressed: () => Navigator.pop(context),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                child: Container(
                                  height: 50,
                                  margin: const EdgeInsets.only(
                                      top: 30, left: 20, right: 20),
                                  decoration: const BoxDecoration(
                                    color: ColorConstants
                                        .darkScaffoldBackgroundColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                  padding: const EdgeInsets.all(15),
                                  child: Center(
                                    child: Text(
                                      projectData.name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                print(snapshot);
                return Text(
                  '${snapshot.error}',
                  style: const TextStyle(color: Colors.white),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }

  void search(String query) {
    List<ProjectSearch> suggestions = searchList.where((search) {
      final projectName = search.name.toLowerCase();
      final projectNumber = search.jobNumber;
      final tech = search.tech.toLowerCase();
      final input = query.toLowerCase();
      return projectName.contains(input) ||
          projectNumber.contains(input) ||
          tech.contains(input);
      // }
    }).toList();

    setState(() {
      finder.clear();
      finder = suggestions;
    });
  }
}
