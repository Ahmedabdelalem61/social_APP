import 'package:task_todo/models/shop_app/login_model/login_model.dart';

abstract class SocialLoginStates{}
class SocialLoginInitialState extends SocialLoginStates{}
class SocialLoginLoadinState extends SocialLoginStates{}
class SocialLoginSuccessState extends SocialLoginStates{
  final String uid;

  SocialLoginSuccessState(this.uid);
}
class SocialLoginErrorState extends SocialLoginStates{
  final String  error;
  SocialLoginErrorState(this.error);
}
class SocialLoginChangeVisibilityState extends SocialLoginStates{}
