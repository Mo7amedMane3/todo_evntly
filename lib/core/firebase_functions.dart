import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_evntly/models/task_model.dart';
import 'package:todo_evntly/models/user_model.dart';

class FireBaseFunctions {
  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance.collection("Users")
        .withConverter<UserModel>(fromFirestore: (snapshot, _) {
      return UserModel.fromJson(snapshot.data()!);
    },
        toFirestore: (value, _) {
          return value.toJson();
        }
    );
  }
 static Future<void> resetPassword(String email) async {
    {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
  }

  static Future<UserModel?> readUser()async{
    var collection = getUserCollection();
   DocumentSnapshot<UserModel> data = await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
return data.data();
  }



  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance.collection("tasks")
        .withConverter<TaskModel>(fromFirestore: (snapshot, _) {
      return TaskModel.fromJson(snapshot.data()!);
    },
        toFirestore: (value, _) {
          return value.toJson();
        }
    );
  }
  static saveUsers(UserModel user){
    var collection = getUserCollection();
    var dokRef = collection.doc(user.id);
    return dokRef.set(user);
  }




  static Future<void> createTask(TaskModel task) {
    var collection = getTasksCollection();
    var dokRef = collection.doc();
    task.id = dokRef.id;
    return dokRef.set(task);
  }

  static Future<void> updateTask(TaskModel task) {
    var collection = getTasksCollection();
    var dokRef = collection.doc(task.id);
    return dokRef.update(task.toJson());
  }

  static Future<void> deleteTask(TaskModel task) {
    var collection = getTasksCollection();
    var dokRef = collection.doc(task.id);
    return dokRef.delete();
  }

  static Stream<QuerySnapshot<TaskModel>> getFavouriteTasks() {
    var data = getTasksCollection().where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)

        .where("isFavorite", isEqualTo: true).snapshots();
    return data;

  }






 static Stream<QuerySnapshot<TaskModel>> getTasksStream({String? category}) {
   var collection = getTasksCollection();

   if (category != null) {
     return collection.where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
         .where("category", isEqualTo: category)
         .snapshots();
   } else {
     return collection.where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
         .snapshots();
   }
 }



 static Future<void> signOut()async {
    FirebaseAuth.instance.signOut();
  }


 static Future<QuerySnapshot<TaskModel>>getTasks({String ? category}) async{
   var collection = getTasksCollection();
   QuerySnapshot<TaskModel> data;
   if(category!=null){
      data = await collection.where("category",
         isEqualTo: category).get();
   }else{
     data = await collection.get();
   }
   return data;
 }



  static Future<void>login(
      String emailAddress,
      String password,

   {required Function onSuccess,required Function onError})async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password,

      );
      onSuccess();

      // onSuccess();
      // if(credential.user!.emailVerified){
      //   onSuccess();
      // } else{
      //   onError("Email not verified");
      // }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        onError('Wrong password provided for that user.');
      } else if (e.code == 'wrong-password') {
        onError('Wrong password provided for that user.');
      }else{
        onError(e.code);
      }
    }
  }


 static Future<void> CreateUser (String email,
     String password,
     String name,
     String nid,
     { required Function onSuccess,required Function onError}) async{
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
        );
     await saveUsers(
        UserModel(name: name,
              email: email,
              nid: nid,id: credential.user!.uid)
      );
      await credential.user!.sendEmailVerification();
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError('The password provided is too weak.');

      } else if
            (e.code == 'email-already-in-use') {
          onError('The account already exists for that email.');
      }else{
        onError(e.code);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}