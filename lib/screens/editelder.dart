import 'dart:async';
import 'package:app/services/apiService.dart';
import 'package:app/services/fireService.dart';
import 'package:app/services/storeService.dart';
import 'package:flutter/material.dart';

class EditElder extends StatefulWidget {
  final dynamic elder;
  final Function() refresh;
  const EditElder(
    this.elder,
    this.refresh,
    Key? key,
  ) : super(key: key);

  @override
  State<EditElder> createState() => _EditElderState();
}

class _EditElderState extends State<EditElder> {
  final _formKey = GlobalKey<FormState>();

  Map eldermap = {};
  bool submitEnabled = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eldermap = {
      "nic": widget.elder["nic"],
      "name": widget.elder["name"],
      "address": widget.elder["address"],
      "phone": widget.elder["phone"],
      "image": widget.elder["image"],
      "mac": widget.elder["mac"],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            BuildForm(context)
          ],
        ),
      ),
    );
  }

  Widget BuildForm(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.99,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text("Edit Elder",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                  fontSize: 25,
                )),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                child: Text("Change Image"),
                onPressed: () async {
                  setState(() {
                    submitEnabled = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Wait Till Image Uploaded")),
                  );
                  Result res = await FireService().upload("Gallery", context);
                  if (res.success) {
                    setState(() {
                      eldermap['image'] = res.meta;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("Upload Failed Due to : " + res.meta)),
                    );
                  }
                  setState(() {
                    submitEnabled = true;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Image Uploaded : "),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Image.network(
                eldermap['image'] ?? "",
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset(
                    "assets/images/404.png",
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                  );
                },
              ),
            ),
            TextFormField(
              initialValue: eldermap['nic'],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some nic';
                }
                return null;
              },
              enabled: false,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  eldermap['nic'] = value;
                });
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.info),
                hintText: 'Enter NIC',
                labelText: 'NIC',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: eldermap['name'],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some name';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  eldermap['name'] = value;
                });
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.info),
                hintText: 'Enter Name',
                labelText: 'Name',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: eldermap['phone'],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some Phone';
                }
                return null;
              },
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                setState(() {
                  eldermap['phone'] = value;
                });
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.phone),
                hintText: 'Enter a phone number',
                labelText: 'Phone',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: eldermap['address'],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some address';
                }
                return null;
              },
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                setState(() {
                  eldermap['address'] = value;
                });
              },
              minLines: 1,
              maxLines: 100,
              decoration: const InputDecoration(
                icon: Icon(Icons.info),
                hintText: 'Enter Address',
                labelText: 'Address',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: eldermap['mac'],
              validator: (value) {
                return null;
              },
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  eldermap['mac'] = value;
                });
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.info),
                hintText: 'Enter MAC',
                labelText: 'MAC',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green)),
                    child: const Text('Submit'),
                    onPressed: !submitEnabled
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                              submit(eldermap);
                            }
                          })),
          ],
        ),
      ),
    );
  }

  submit(Map eldermap) {
    setState(() {
      submitEnabled = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Elder Updating')),
    );
    StoreService.get("token").then((token) => {
          eldermap.putIfAbsent("token", () => token),
          print(eldermap),
          APIService.editElder(eldermap).then((resp) => {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Elder Updated')),
                ),
                widget.refresh.call(),
                Timer(Duration(seconds: 2), () {
                  Navigator.of(context).pop();
                })
              })
        });
  }
}
