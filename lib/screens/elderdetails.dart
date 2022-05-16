import 'dart:convert';
import 'dart:math';

import 'package:app/screens/addelder.dart';
import 'package:app/screens/mapScreen.dart';
import 'package:app/screens/myaccount.dart';
import 'package:app/screens/welcomescreen.dart';
import 'package:app/services/apiService.dart';
import 'package:app/services/pushNotificationService.dart';
import 'package:app/services/storeService.dart';
import 'package:app/widgets/custometextwidget.dart';
import 'package:app/widgets/eldercard.dart';
import 'package:flutter/material.dart';

class ElderListScreen extends StatefulWidget {
  const ElderListScreen({Key? key}) : super(key: key);

  @override
  State<ElderListScreen> createState() => _ElderListScreenState();
}

class _ElderListScreenState extends State<ElderListScreen> {
  List elders = [];

  refresh() {
    setState(() {
      elders = [];
    });
  }

  @override
  void initState() {
    super.initState();
    elders = [];
  }

  @override
  Widget build(BuildContext context) {
    FCM firebaseMessaging = FCM();
    firebaseMessaging.initialize(context, elders);
    firebaseMessaging.streamCtlr.stream.listen((msgData) {
      //_changeMsg(msgData);
    });

    List<ElderCard> cards = <ElderCard>[];
    try {
      if (elders.isEmpty) {
        StoreService.get("token").then((token) => {
              APIService.listElders(token ?? "").then((resp) => {
                    print(resp.body),
                    if (resp.statusCode == 200)
                      {
                        setState(
                          () {
                            elders = jsonDecode(resp.body);
                          },
                        )
                      }
                  })
            });
      }
      elders.forEach((element) {
        print(element['nic']);
        cards.add(ElderCard(element, refresh));
      });
    } catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ex.toString())),
      );
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Elder Details'),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.map_sharp,
                              size: 40,
                            ),
                            tooltip: 'Map',
                            color: Colors.purple,
                            onPressed: () {
                              StoreService.get("token").then((token) => {
                                    APIService.onMapLoad(token ?? "")
                                        .then((resp) => {
                                              print(resp.body),
                                              if (resp.statusCode == 200)
                                                {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MapScreen(
                                                                  null,
                                                                  jsonDecode(resp
                                                                      .body)))),
                                                }
                                              else
                                                {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            "Map Data Fetching Failed")),
                                                  ),
                                                }
                                            })
                                  });
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.refresh,
                              size: 40,
                            ),
                            tooltip: 'Refresh',
                            color: Color.fromARGB(255, 62, 105, 13),
                            onPressed: () {
                              setState(() {
                                elders = [];
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              size: 40,
                            ),
                            tooltip: 'Add',
                            color: Color.fromARGB(255, 1, 44, 3),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddElder(refresh, null)));
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.person,
                              size: 40,
                            ),
                            tooltip: 'MyAccount',
                            color: Color.fromARGB(255, 9, 60, 103),
                            onPressed: () {
                              StoreService.get("token").then((token) => {
                                    APIService.myAccount(token ?? "")
                                        .then((resp) => {
                                              print(resp.body),
                                              if (resp.statusCode == 200)
                                                {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MyAccount(
                                                                  jsonDecode(
                                                                      resp.body),
                                                                  null))),
                                                }
                                              else
                                                {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            "Account Data Fetching Failed")),
                                                  ),
                                                }
                                            })
                                  });
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.logout,
                              size: 40,
                            ),
                            tooltip: 'LogOut',
                            color: Color.fromARGB(255, 151, 27, 19),
                            onPressed: () {
                              StoreService.clean()
                                  .then((value) => {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WelcomeScreen()),
                                          (Route<dynamic> route) => false,
                                        )
                                      })
                                  .catchError((onError) => {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text(onError.toString())),
                                        ),
                                      });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  const CustomTextWidget(null, 1, "Take Care", TextAlign.center,
                      Colors.grey, 13, FontWeight.normal),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomTextWidget(null, 1, "Let's Help Them",
                      TextAlign.center, Colors.black, 30, FontWeight.bold),
                  const SizedBox(
                    height: 10,
                  ),
                  Image(
                    image: AssetImage('assets/images/cloud.png'),
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: cards,
              )
            ],
          ),
        ),
      ),
    );
  }
}
