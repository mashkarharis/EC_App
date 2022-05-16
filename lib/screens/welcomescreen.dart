import 'package:app/screens/elderdetails.dart';
import 'package:app/screens/loginscreen.dart';
import 'package:app/services/apiService.dart';
import 'package:app/services/storeService.dart';
import 'package:app/widgets/custometextwidget.dart';
import 'package:app/widgets/roundedbutton.dart';
import 'package:flutter/material.dart';

void gotoauthscreen(BuildContext context) {
  StoreService.get("token")
      .then((token) => {
            print(token),
            APIService.introspect(token ?? "")
                .then((resp) => {
                      print(resp.statusCode),
                      if (resp.statusCode == 200)
                        {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ElderListScreen()),
                            (Route<dynamic> route) => false,
                          )
                        }
                      else
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()))
                        }
                    })
                // ignore: invalid_return_type_for_catch_error
                .catchError((onError) => {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(onError.toString())),
                      )
                    })
          })
      .catchError((onError) => {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(onError.toString())),
            )
          });
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        const Positioned.fill(
          child: Image(
            image: AssetImage('assets/images/welcome1.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(
                      height: 10,
                    ),
                    Image(
                      image: AssetImage('assets/images/finallogo.png'),
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextWidget(null, 0.9, "Hi, Welcome", TextAlign.center,
                        Colors.white, 30, FontWeight.bold),
                    CustomTextWidget(null, 0.9, "to Elder Care",
                        TextAlign.center, Colors.white, 30, FontWeight.w100),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextWidget(
                        null,
                        0.9,
                        "Explore the app, Find some place to help elders.",
                        TextAlign.center,
                        Colors.white,
                        15,
                        FontWeight.w100),
                  ],
                ),
                Positioned(
                  bottom: 10,
                  child: RoundedButton(
                      null,
                      Icons.ac_unit_rounded,
                      Colors.black,
                      Colors.white,
                      gotoauthscreen,
                      "Get Started",
                      0.8,
                      context),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
