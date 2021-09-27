import 'package:task_todo/models/shop_app/login_model/login_model.dart';

abstract class SocialRegisterStates{}
class SocialRegisterInitialState extends SocialRegisterStates{}
class SocialRegisterLoadinState extends SocialRegisterStates{}

class SocialRegisterSuccessState extends SocialRegisterStates{}
class SocialRegisterErrorState extends SocialRegisterStates{
  final String  error;
  SocialRegisterErrorState(this.error);
}
class SocialCreateSuccessState extends SocialRegisterStates{}
class SocialCreateErrorState extends SocialRegisterStates{
  final String  error;
  SocialCreateErrorState(this.error);
}
class SocialRegisterChangeVisibilityState extends SocialRegisterStates{}
