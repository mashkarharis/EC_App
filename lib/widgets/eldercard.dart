import 'package:app/screens/editelder.dart';
import 'package:app/screens/strokepredict.dart';
import 'package:app/services/apiService.dart';
import 'package:app/services/storeService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ElderCard extends StatelessWidget {
  final dynamic element;
  final Function() refresh;
  const ElderCard(this.element, this.refresh, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 217, 217, 246),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Image.network(
                          element['image'],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.monitor_heart,
                              size: 40,
                            ),
                            tooltip: 'Stroke Predictor',
                            color: Color.fromARGB(255, 198, 19, 70),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StrokePredict()));
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              size: 30,
                            ),
                            tooltip: 'Update',
                            color: Color.fromARGB(255, 93, 84, 3),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditElder(element, refresh, null)));
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              size: 30,
                            ),
                            tooltip: 'Delete',
                            color: Colors.red,
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Elder Deleting')),
                              );
                              StoreService.get("token").then((token) => {
                                    APIService.deleteElder(
                                            element['nic'], token ?? "")
                                        .then((resp) => {
                                              print(resp.body),
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content:
                                                        Text('Elder Deleted')),
                                              ),
                                              refresh.call()
                                            })
                                  });
                            },
                          ),
                        ],
                      ),
                    ])
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 0, right: 5, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 80,
                          child: Text("Name"),
                        ),
                        Text(element['name'])
                      ],
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 80,
                          child: Text("Address"),
                        ),
                        Text(element['address'])
                      ],
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 80,
                          child: Text("Phone"),
                        ),
                        Text(element['phone'])
                      ],
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 80,
                          child: Text("NIC"),
                        ),
                        Text(element['nic'])
                      ],
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 80,
                          child: Text("MAC"),
                        ),
                        Text(element['mac'])
                      ],
                    )),
              ]),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
