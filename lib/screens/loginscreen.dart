import 'package:app/constants/colors.dart';
import 'package:app/services/apiService.dart';
import 'package:app/services/storeService.dart';
import 'package:app/widgets/clickabletextwidget.dart';
import 'package:app/widgets/custometextwidget.dart';
import 'package:app/widgets/roundedbutton.dart';
import 'package:flutter/material.dart';

void abc(BuildContext context) {
  print("object");
}

void gotosignupscreen(BuildContext context) {
  // Navigator.push(
  //     context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  late String email;
  late String password;

  void LogIn(BuildContext context) {
    try {
      if (formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Processing Data')),
        );
        print(email);
        print(password);
        APIService.login(email, password)
            .then((resp) => {
                  print(resp.body.toString()),
                  if (resp.statusCode != 200)
                    {throw Exception("Invalid Username or Password")},
                  StoreService.add("token", resp.body.toString())
                      .then((value) => {Navigator.pop(context)})
                      .catchError((onError) => {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(onError.toString())),
                            ),
                          })
                })
            .catchError((onError) => {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(onError.toString())),
                  ),
                });
      }
    } catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ex.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(''),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomTextWidget(null, 0.9, "Welcome Back CareTaker!",
                      TextAlign.center, Colors.black, 30, FontWeight.bold),
                  BuildForm(context),
                  const SizedBox(
                    height: 20,
                  ),
                  RoundedButton(null, Icons.login, Colors.white,
                      CustomColors.purple, LogIn, "LOG IN", 0.8, context),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget BuildForm(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.90,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            const Image(image: AssetImage('assets/images/loginstation.png')),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                  return 'Please Enter Valid Email';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.black12,
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.black26),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Check Password';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.black12,
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.black26),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
