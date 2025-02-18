import 'package:chatapphg/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class ChatScreen extends StatelessWidget {
  //Creates a route to ChatScreen
  static Route route(MessageData messageData) => MaterialPageRoute(
      builder: (context) => ChatScreen(
            messageData: messageData,
          ));

  const ChatScreen({
    super.key,
    required this.messageData,
  });
  final MessageData messageData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: CupertinoIcons.back,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title:  _AppBarTitle(messageData: messageData,),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: IconBorder(
                icon: CupertinoIcons.video_camera_solid,
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: IconBorder(
                icon: CupertinoIcons.phone_solid,
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
      body: Text('data'),
    );
  }


}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({super.key, required this.messageData});

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Avatar.small(
          url: messageData.profilePicture,
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                messageData.senderName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                'Online now',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
