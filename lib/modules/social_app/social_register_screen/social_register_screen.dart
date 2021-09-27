import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/layout/social_app/social_layout.dart';
import 'package:task_todo/modules/shop_app/register/cubit/cubit.dart';
import 'package:task_todo/modules/shop_app/register/cubit/states.dart';
import 'package:task_todo/modules/social_app/social_register_screen/social_register_cubit/cubit.dart';
import 'package:task_todo/modules/social_app/social_register_screen/social_register_cubit/states.dart';
import 'package:task_todo/shared/components/component.dart';
import 'package:task_todo/shared/components/news_component.dart';
class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emaiController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if(state is SocialCreateSuccessState){
            navigateAndFinish(context, SocialLayout());
          }
          if(state is SocialRegisterErrorState){
            showToast(text: state.error, state: ToastState.WARNING);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
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
                      Text('REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: Colors.black)),
                      SizedBox(
                        height: 30,
                      ),
                      Text('Join us now and communicate!',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.grey)),
                      SizedBox(
                        height: 20,
                      ),

                      DefaultTextFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "name must not be empty";
                            }
                            return null;
                          },
                          label: 'User name',
                          prefix: Icons.person),
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
                          ispassword: SocialRegisterCubit.get(context).isPassword,
                          suffixPressed: (){
                            SocialRegisterCubit.get(context).changePasswordVisibility();
                          },
                          prefix: Icons.lock_outline,
                          suffix:SocialRegisterCubit.get(context).suuffix ,
                          onSubmit: (val) {

                          }),
                      SizedBox(
                        height: 20,
                      ),
                      DefaultTextFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "phone number must not be empty";
                            }
                            return null;
                          },
                          label: 'phone',
                          prefix: Icons.phone),
                      SizedBox(
                        height: 20,
                      ),

                      ConditionalBuilder(
                        condition: state is! SocialRegisterLoadinState,
                        builder: (context) => defaultButton(
                            whenPress: () {
                              if (formKey.currentState.validate()) {
                                SocialRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emaiController.text,
                                    password: passwordController.text,
                                    phone:phoneController.text

                                );

                              }
                            },
                            text: 'register',
                            upperCase: true),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
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
