import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/modules/social_app/social_login_screen/social_login_cubit/states.dart';
import 'package:task_todo/shared/network/local/cashe_helper.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>{
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) =>BlocProvider.of(context);
  void userLogin({
  @required String email,
  @required String password,
}){
    emit(SocialLoginLoadinState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
    emit(SocialLoginSuccessState(value.user.uid));
    print("login mail ${value.user.email}");
    print("login mail ${value.user.uid}");

    }).catchError((error){
      emit(SocialLoginErrorState(error.toString()));
    });
  }
  IconData suuffix = Icons.visibility;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    isPassword?suuffix= Icons.visibility:suuffix = Icons.visibility_off_outlined;
    emit(SocialLoginChangeVisibilityState());
  }

}