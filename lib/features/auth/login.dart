import 'package:assignment/features/auth/controller/controller.dart';
import 'package:assignment/utils/colors.dart';
import 'package:assignment/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:  MyColors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color:  MyColors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color:  MyColors.purple1),
                          boxShadow: [
                            BoxShadow(
                                color: MyColors.purple,
                                blurRadius: 20.0,
                                offset: Offset(0, 10))
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color:
                                        Color.fromRGBO(143, 148, 251, 1)))),
                            child: TextField(
                              controller: controller.mobileController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:MyStrings.mobileNo,
                                  hintStyle:
                                  TextStyle(color: MyColors.grey700)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              controller: controller.passController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: MyStrings.pass,
                                  hintStyle:
                                  TextStyle(color: MyColors.grey700)),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.login();
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                             MyColors.purple,
                              MyColors.purple1,
                            ])),
                        child: Center(
                          child: Text(
                            MyStrings.login,
                            style: TextStyle(
                                color: MyColors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
