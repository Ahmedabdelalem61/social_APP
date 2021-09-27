import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/layout/social_app/social_cubit.dart';
import 'package:task_todo/layout/social_app/social_states.dart';
import 'package:task_todo/models/social_app/message_model.dart';
import 'package:task_todo/models/social_app/social_user_model.dart';
import 'package:task_todo/shared/styles/icon_broken.dart';

class SocialDetailsScreen extends StatelessWidget {
  SocilaUserModel model;
  TextEditingController messageController = TextEditingController();

  SocialDetailsScreen({this.model});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).receiveMessage(receiverId: model.uid);
        print("hey bro the messages length is ${SocialCubit.get(context).messagesModel.length}");
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(IconBroken.Arrow___Left_2),
                ),
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('${model.image}'),
                      radius: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${model.name}',
                      style: TextStyle(
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit
                    .get(context).messagesModel.length > 0,
                builder: (context) =>
                    Column(
                      children: [
                        Expanded(
                          child: ListView.separated(itemBuilder: (context,index){
                            if(SocialCubit.get(context).messagesModel[index].receiverId==model.uid)
                            return BuildMyMessage(SocialCubit.get(context).messagesModel[index]);
                            return BuildMessage(SocialCubit.get(context).messagesModel[index]);
                          },
                              separatorBuilder: (context,index)=>SizedBox(height: 10,),
                              itemCount: SocialCubit
                                  .get(context)
                                  .messagesModel
                                  .length),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            //clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[300],
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 7, horizontal: 7),
                                      hintText: 'type your meassage here',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(Icons.send, color: Colors.blue),
                                    onPressed: () {
                                      SocialCubit.get(context).sendMessage(
                                          text: messageController.text,
                                          receiverId: model.uid,
                                          dateTime: DateTime.now().toString());
                                    })
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  Widget BuildMessage(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(15),
              topStart: Radius.circular(15),
              bottomEnd: Radius.circular(15),
            ),
            color: Colors.grey[300],
          ),
          child: Text(model.text),
        ),
      ),
    );
  }

  Widget BuildMyMessage(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(15),
              topStart: Radius.circular(15),
              bottomStart: Radius.circular(15),
            ),
            color: Colors.blue.withOpacity(.2),
          ),
          child: Text(model.text),
        ),
      ),
    );
  }
}
