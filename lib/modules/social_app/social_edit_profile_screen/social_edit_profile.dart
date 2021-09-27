import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/layout/social_app/social_cubit.dart';
import 'package:task_todo/layout/social_app/social_states.dart';
import 'package:task_todo/shared/components/component.dart';
import 'package:task_todo/shared/components/news_component.dart';
import 'package:task_todo/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {

        var model = SocialCubit.get(context).model;
        nameController.text = model.name;
        bioController.text = model.bio;
        return Scaffold(
          appBar: defalutAppBar(
              context: context,
              text: 'Edit your Profile',
              actions: [
                defaultTextButton(function: () {
                  SocialCubit.get(context).update(name: nameController.text, bio: bioController.text, phone: phoneController.text);
                }, text: 'UPDATE'),
                SizedBox(
                  width: 10,
                )
              ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is ProfileUpdatingSuccessState)
                    LinearProgressIndicator(),
                  Container(
                    height: 210,
                    child: Stack(
                      // alignment: AlignmentDirectional.topCenter,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 160,
                              child: Image(
                                image: SocialCubit.get(context).coverImage==null?NetworkImage('${model.cover}'):
                                FileImage(SocialCubit.get(context).coverImage),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 150,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 20,
                                child: IconButton(
                                  iconSize: 16,
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: Icon(IconBroken.Camera),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                radius: 65,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: SocialCubit.get(context).profileImage==null?
                                  NetworkImage('${model.image}'):FileImage(SocialCubit.get(context).profileImage),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20,
                                  child: IconButton(
                                    iconSize: 16,
                                    onPressed: () {
                                      SocialCubit.get(context).getProfileImage();
                                    },
                                    icon: Icon(IconBroken.Camera),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefaultTextFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: ( value) {
                          if(value.isEmpty)
                            return 'Plz write your Name';
                          return null;
                        },
                        label: 'Change your name',
                        prefix: IconBroken.Add_User),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefaultTextFormField(
                        controller: bioController,
                        type: TextInputType.text,
                        validate: ( value) {
                          if(value.isEmpty)
                            return 'Plz write your Bio';
                          return null;
                        },
                        label: 'Change your bio',
                        prefix: IconBroken.Info_Square),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefaultTextFormField(
                        controller: phoneController,
                        type: TextInputType.number,
                        validate: ( value) {
                          if(value.isEmpty)
                            return 'Plz write your phone';
                          return null;
                        },
                        label: 'Change your phone',
                        prefix: IconBroken.Call),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
