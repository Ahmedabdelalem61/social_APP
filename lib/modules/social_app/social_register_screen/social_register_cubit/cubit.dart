import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/models/social_app/social_user_model.dart';

import 'package:task_todo/modules/social_app/social_register_screen/social_register_cubit/states.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates>{
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) =>BlocProvider.of(context);
  void userRegister({
  @required String email,
  @required String password,
  @required String phone,
  @required String name,
}){
    emit(SocialRegisterLoadinState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      print('register mail  ${value.user.email}');
      print(value.user.uid);
      UserCreate(
        name: name,
        phone: phone,
        uid: value.user.uid,
        email: email,
      );
    }).catchError((Error){
      print("eeeeeeeeeeeeeeeeeeeeeror");
      emit(SocialRegisterErrorState(Error.toString()));
    });
  }
  void UserCreate(
      {
        @required String email,
        @required String uid,
        @required String phone,
        @required String name,
      }
      ){
    SocilaUserModel userModel = SocilaUserModel(
      email: email,
      phone: phone,
      name: name,
      uid : uid,
      isEmailVerified: false,
      image: 'https://image.freepik.com/free-photo/image-magnetic-handsome-helpless-young-man-shrugging-with-shoulders-looking-directly-raising-arms_176532-10250.jpg',
      cover:'https://image.freepik.com/free-photo/social-media-audience-person-filming-through-smartphone_53876-129002.jpg'
    );
    FirebaseFirestore.instance.collection("users").doc(uid).set(userModel.toMap()).then((value) {
      emit(SocialCreateSuccessState());
      print("user have beeeeeeeeeen created");
    }).catchError((error){
      emit(SocialCreateErrorState(error.toString()));
      print("user have beeeeeeeeeen not been created");
    });

  }
  IconData suuffix = Icons.visibility;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    isPassword?suuffix= Icons.visibility:suuffix = Icons.visibility_off_outlined;
    emit(SocialRegisterChangeVisibilityState());
  }

}