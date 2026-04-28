import 'package:fantasy_baseball_app/model/UserValidationIdentifiers.dart';
import 'package:fantasy_baseball_app/notifiers/AuthorizationModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/UserInfo.dart';

class LoginPanel extends StatefulWidget
{
  const LoginPanel({super.key});

  @override
  LoginPanelState createState() => LoginPanelState();
}

class LoginPanelState extends State<LoginPanel>
{
  String email    = "";
  String password = "";

  @override
  Widget build(BuildContext context)
  {
    UserInfo? userInfo = context.read<AuthorizationModel>().userInfo;

    return Container(
        height: 300,
        margin: EdgeInsets.fromLTRB(400, 40, 400, 0),
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 5),
            )
          ]
        ),
      child: Column(
        children: [
          if (userInfo != null)
            Center(child: Text("Validated!")),
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(100, 40, 100, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Email',
                ),
                onChanged: (String? text)
                {
                  email = text!;
                },
              )
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(100, 40, 100, 0),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Password',
                ),
                onChanged: (String? text)
                {
                  password = text!;
                },
              )
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 150,
                  height: 50,
                  margin: EdgeInsets.fromLTRB(0, 40, 10, 0),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: (){
                      UserValidationIdentifiers identifiers = UserValidationIdentifiers(email: email, password: password);

                      Provider.of<AuthorizationModel>(context, listen: false).validateUser(identifiers);


                    },
                    child: Center(child: Text("Login")),
                  )
                )
              ),
              Center(
                child: Container(
                  width: 150,
                  height: 50,
                  margin: EdgeInsets.fromLTRB(10, 40, 0, 0),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: (){},
                    child: Center(child: Text("Create Account")),
                  )
                )
              ),
            ],
          )
        ],
      ),
    );
  }
}