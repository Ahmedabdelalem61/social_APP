import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_todo/layout/social_app/social_layout.dart';
import 'package:task_todo/modules/shop_app/cubit/cubit.dart';
import 'package:task_todo/modules/shop_app/cubit/states.dart';
import 'package:task_todo/modules/shop_app/register/register_screen.dart';
import 'package:task_todo/modules/social_app/social_login_screen/social_login_cubit/cubit.dart';
import 'package:task_todo/modules/social_app/social_login_screen/social_login_cubit/states.dart';
import 'package:task_todo/modules/social_app/social_register_screen/social_register_screen.dart';
import 'file:///E:/api%20news%20app/TODO-main/lib/layout/shop_app/shop_layout.dart';
import 'package:task_todo/shared/components/component.dart';
import 'package:task_todo/shared/components/constants.dart';
import 'package:task_todo/shared/components/news_component.dart';
import 'package:task_todo/shared/network/local/cashe_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  var emaiController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if(state is SocialLoginErrorState){
            showToast(text: state.error, state: ToastState.ERROR);
          }
          if(state is SocialLoginSuccessState)
          CasheHelper.saveData(key: 'uid', value: state.uid).then((value) {
            navigateAndFinish(context, SocialLayout());
          });
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Image(image: AssetImage('assets/images/signin.png')),
                      Text('LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: Colors.black)),
                      SizedBox(
                        height: 30,
                      ),
                      Text('Join us now!',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),
                      DefaultTextFormField(
                          controller: emaiController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Email Adress must not be empty";
                            }
                            return null;
                          },
                          label: 'Email Adress',
                          prefix: Icons.email_outlined),
                      SizedBox(
                        height: 20,
                      ),
                      DefaultTextFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "password must not be empty";
                            }
                            return null;
                          },
                          label: 'password',
                          ispassword: SocialLoginCubit.get(context).isPassword,
                          suffixPressed: (){
                            SocialLoginCubit.get(context).changePasswordVisibility();
                          },
                          prefix: Icons.lock_outline,
                          suffix:SocialLoginCubit.get(context).suuffix ,
                          onSubmit: (val) {
                            // if (formKey.currentState.validate()) {
                            //   SocialLoginCubit.get(context).userLogin(
                            //       email: emaiController.text,
                            //       password: passwordController.text
                            //   );
                            // }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! SocialLoginLoadinState,
                        builder: (context) => defaultButton(
                             whenPress: () {
                              if (formKey.currentState.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                    email: emaiController.text,
                                    password: passwordController.text);

                              }
                             },
                            text: 'login',
                            upperCase: true),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('don\'t have any account'),
                          defaultTextButton(function: () {
                            navigateTo(context, SocialRegisterScreen());
                          }, text: 'Register'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

