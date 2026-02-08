import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_evntly/models/user_model.dart';

import '../core/firebase_functions.dart';

class AuthProvider extends ChangeNotifier {
  User?fireBaseUser;
  UserModel?userModel;

AuthProvider(){
  fireBaseUser=FirebaseAuth.instance.currentUser;
  if(fireBaseUser!=null){
    initUser();
  }
}
  initUser()async{
    userModel=await FireBaseFunctions.readUser();
    notifyListeners();


  }

}
