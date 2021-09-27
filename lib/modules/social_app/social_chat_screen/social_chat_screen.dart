import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/layout/social_app/social_cubit.dart';
import 'package:task_todo/layout/social_app/social_states.dart';
import 'package:task_todo/models/social_app/social_user_model.dart';
import 'package:task_todo/modules/social_app/social_chat_details/social_chat_details_screen.dart';
import 'package:task_todo/shared/components/news_component.dart';

class SocialChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.length > 0,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildChatItem(context,SocialCubit.get(context).users[index]),
              separatorBuilder: (context, index) => ItemDivider(),
              itemCount: SocialCubit.get(context).users.length),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildChatItem(context,SocilaUserModel model) {
    return InkWell(
      onTap: (){
        navigateTo(context, SocialDetailsScreen(model: model,));
      },
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('${model.image}'),
              radius: 25,
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
    );
  }
}
