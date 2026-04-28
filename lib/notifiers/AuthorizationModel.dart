import 'package:fantasy_baseball_app/model/UserValidationIdentifiers.dart';
import 'package:flutter/material.dart';

import 'package:fantasy_baseball_app/data/UserDataSource.dart';
import 'package:fantasy_baseball_app/model/UserInfo.dart';

class AuthorizationModel extends ChangeNotifier
{
  UserDataSource userDataSource = UserDataSource();

  bool      _finishedAuthorizing = true;
  UserInfo? _userInfo;

  bool      get finishedAuthorizing => _finishedAuthorizing;
  UserInfo? get userInfo            => _userInfo;

  void validateUser(UserValidationIdentifiers identifiers)
  {
    _finishedAuthorizing = false;

    notifyListeners();

    userDataSource.validateUser(identifiers).then((UserInfo? user){
      _userInfo             = user;
      _finishedAuthorizing  = true;

      notifyListeners();
    });
  }
}