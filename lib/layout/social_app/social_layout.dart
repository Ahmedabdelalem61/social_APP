import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/layout/social_app/social_cubit.dart';
import 'package:task_todo/layout/social_app/social_states.dart';
import 'package:task_todo/modules/social_app/social_addpost_screen/social_addpost_screen.dart';
import 'package:task_todo/modules/social_app/social_login_screen/social_login_screen.dart';
import 'package:task_todo/shared/components/component.dart';
import 'package:task_todo/shared/components/news_component.dart';
import 'package:task_todo/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(listener: (context, state) {
      if (state is SocialNewPostState) {
        navigateTo(context, AddPost());
      }
    }, builder: (context, state) {
      var model = SocialCubit.get(context).model;
      // make acubit and the nav Bar wait me after the meeting
      var cubit = SocialCubit.get(context);
      return Scaffold(
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image(
                //     fit: BoxFit.contain,
                //     image: NetworkImage(SocialCubit.get(context).model.image)),
                RaisedButton(
                  child: Text('Logout'),
                  color: Colors.blue.withOpacity(.5),
                  onPressed: () {
                    navigateAndFinish(context, SocialLoginScreen());
                  },
                ),
                Column(
                  children: [
                    if(!FirebaseAuth.instance.currentUser.emailVerified)
                      Container(
                        color: Colors.amber.shade400,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline),
                              SizedBox(width: 10,),
                              Text('please verify your email'),
                              Spacer(),
                              defaultTextButton(function: (){
                                FirebaseAuth.instance.currentUser.sendEmailVerification().then((value) {
                                  showToast(text: 'check your mail', state: ToastState.SUCCESS);
                                }).catchError((err){

                                });
                              }, text: 'send'),
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(icon: Icon(IconBroken.Notification), onPressed: () {}),
            IconButton(icon: Icon(IconBroken.Search), onPressed: () {}),
          ],
          title: Text(cubit.titles[cubit.currentIndex]),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(IconBroken.Chat), label: 'Chat'),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Paper_Upload), label: 'Post'),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.User), label: 'Users'),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting), label: 'Settings'),
          ],
          currentIndex: cubit.currentIndex,
          onTap: (index) {
            cubit.chaneNavButton(index);
          },
        ),
        body: cubit.screens[cubit.currentIndex],
      );
    });
  }
}



