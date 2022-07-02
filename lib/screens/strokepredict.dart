import 'dart:async';
import 'dart:convert';
import 'package:app/services/apiService.dart';
import 'package:app/services/fireService.dart';
import 'package:app/services/storeService.dart';
import 'package:flutter/material.dart';

class StrokePredict extends StatefulWidget {
  const StrokePredict({Key? key}) : super(key: key);

  @override
  State<StrokePredict> createState() => _StrokePredictState();
}

class _StrokePredictState extends State<StrokePredict> {
  final _formKey = GlobalKey<FormState>();

  Map data = {};
  String strokeProbability = "N/A";
  bool submitEnabled = true;
  Map genderVals = {'Female': 0, 'Male': 1, 'Other': 2};
  Map marriedVal = {'No': 0, 'Yes': 1};
  Map hypertensionVal = {'No': 0, 'Yes': 1};
  Map heart_diseaseVal = {'No': 0, 'Yes': 1};
  Map worktypeVal = {
    'Govt_job': 0,
    'Never_worked': 1,
    'Private': 2,
    'Self-employed': 3
  };
  Map residenceVal = {'Rural': 0, 'Urban': 1};
  Map smokeVal = {
    'Unknown': 0,
    'formerly smoked': 1,
    'never smoked': 2,
    'smokes': 3
  };
  @override
  void initState() {
    super.initState();
    data = {
      "gender": "Female",
      "age": 49,
      "hypertension": "Yes",
      "heart_disease": "Yes",
      "ever_married": "Yes",
      "work_type": "Private",
      "Residence_type": "Rural",
      "avg_glucose_level": 171.23,
      "bmi": 34.9,
      "smoking_status": "smokes"
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
            const Text("Stroke Predictor",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                  fontSize: 25,
                )),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Image.network(
                "https://www.cdc.gov/stroke/images/FAST-Graphic.jpg?_=77295",
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
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "STROKE PROBABILITY",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(40),
                  child: Text(
                    strokeProbability,
                    style: TextStyle(
                        color: Color.fromARGB(255, 9, 86, 13), fontSize: 40),
                  ),
                ),
              ],
            ),
            TextFormField(
              initialValue: data['age'].toString(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter age';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  data['age'] = double.parse(value.toString());
                });
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.view_agenda),
                hintText: 'Enter Age',
                labelText: 'Age',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: data['bmi'].toString(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter bmi';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  data['bmi'] = double.parse(value.toString());
                });
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.numbers),
                hintText: 'Enter BMI',
                labelText: 'BMI',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: data['avg_glucose_level'].toString(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Average Glucose Level';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  data['avg_glucose_level'] = double.parse(value.toString());
                });
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.local_laundry_service_rounded),
                hintText: 'Enter Average Glucose Level',
                labelText: 'Average Glucose Level',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            generateDropDown(
                "Gender", <String>['Female', 'Male', 'Other'], "gender"),
            generateDropDown(
                "Ever Married", <String>['Yes', 'No'], "ever_married"),
            generateDropDown(
                "Has/Had Hypertension", <String>['Yes', 'No'], "hypertension"),
            generateDropDown("Has/Had Heart Disease", <String>['Yes', 'No'],
                "heart_disease"),
            generateDropDown(
                "Work Type",
                <String>[
                  'Govt_job',
                  'Never_worked',
                  'Private',
                  'Self-employed'
                ],
                "work_type"),
            generateDropDown(
                "Residence Type", <String>['Rural', 'Urban'], "Residence_type"),
            generateDropDown(
                "Smoking Status",
                <String>[
                  'Unknown',
                  'formerly smoked',
                  'never smoked',
                  'smokes'
                ],
                "smoking_status"),
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
                              submit(data);
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
    print(data);
    Map toSubmitdata = {
      "gender": genderVals[data["gender"]],
      "age": data["age"],
      "hypertension": hypertensionVal[data["hypertension"]],
      "heart_disease": heart_diseaseVal[data["heart_disease"]],
      "ever_married": marriedVal[data["ever_married"]],
      "work_type": worktypeVal[data["work_type"]],
      "Residence_type": residenceVal[data["Residence_type"]],
      "avg_glucose_level": data["avg_glucose_level"],
      "bmi": data["bmi"],
      "smoking_status": smokeVal[data["smoking_status"]]
    };

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Predicting . . .')),
    );
    Map resbody = {};
    print(toSubmitdata);
    APIService.predict(toSubmitdata)
        .then((resp) => {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Stoke Predicted')),
              ),
              print(resp.body),
              resbody = json.decode(resp.body),
              setState(() {
                submitEnabled = true;
                strokeProbability = (resbody["probability(1)"] * 100)
                        .toString()
                        .substring(0, 4) +
                    " %";
              })
            })
        .catchError((onError) => {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Prediction Failed')),
              )
            });
  }

  Widget generateDropDown(title, List<String> list, listnerField) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Icon(
              Icons.accessibility_outlined,
              color: Color.fromARGB(255, 144, 141, 141),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Color.fromARGB(255, 129, 124, 124), fontSize: 12),
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: DropdownButton<String>(
              value: data[listnerField],
              items: list.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newval) {
                setState(() {
                  data[listnerField] = newval;
                });
              },
            ),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ]),
    );
  }
}
