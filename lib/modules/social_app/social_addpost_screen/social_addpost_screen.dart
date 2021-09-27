import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/layout/social_app/social_cubit.dart';
import 'package:task_todo/layout/social_app/social_states.dart';
import 'package:task_todo/shared/components/component.dart';
import 'package:task_todo/shared/components/news_component.dart';
import 'package:task_todo/shared/styles/icon_broken.dart';

class AddPost extends StatelessWidget {
  TextEditingController postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){} ,
      builder: (context,state){
        var model = SocialCubit.get(context).model;
        return Scaffold(
          appBar: defalutAppBar(context: context, text: 'New Post', actions: [
            defaultTextButton(function: () {
              if(SocialCubit.get(context).PostImage==null)
                SocialCubit.get(context).uploadPost(dateTime: DateTime.now().toString(), post: postController.text);
              else{
                SocialCubit.get(context).uploadPostImage(post: postController.text, dateTime: DateTime.now().toString());
              }
            }, text: 'POST'),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                if(state is SocialCreatePostUploadingState)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(),
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${model.image}'),
                      radius: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${model.name}',
                            style: TextStyle(
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    scrollPhysics: BouncingScrollPhysics(),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'What you are thinking now...'),
                  ),
                ),
                if(SocialCubit.get(context).PostImage!=null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 160,
                      child: Image(
                        image: FileImage(SocialCubit.get(context).PostImage),
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
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: Icon(IconBroken.Close_Square),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Add photo'),
                            ],
                          ),
                        )),
                    Expanded(
                        child: TextButton(
                          child: Text('# tags'),
                          onPressed: () {},
                        ))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
