import 'package:app/screens/editelder.dart';
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
            color: Color.fromARGB(255, 236, 235, 233),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3 - 26,
                    child: Column(
                      children: [
                        ClipOval(
                          child: Image.network(
                            element['image'],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7 - 26,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Text("Name : " + element['name'])),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Text("Address : " + element['address'])),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Text("Phone : " + element['phone'])),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Text("NIC : " + element['nic'])),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Text("MAC : " + element['mac'])),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                          APIService.deleteElder(element['nic'], token ?? "")
                              .then((resp) => {
                                    print(resp.body),
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Elder Deleted')),
                                    ),
                                    refresh.call()
                                  })
                        });
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
