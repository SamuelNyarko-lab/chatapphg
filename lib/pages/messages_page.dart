import 'package:chatapphg/helpers.dart';
import 'package:chatapphg/screens/screens.dart';
import 'package:chatapphg/theme.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      //this gives the option to have both horizontal and vertical scroll widgets
      slivers: [
        SliverToBoxAdapter(
          //added this to make the widget a sliver and gives it a fixed size
          child: _Stories(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(childCount: 10, _delegate),
        )
      ],
    );
  }

  Widget _delegate(BuildContext context, int index) {
    final Faker faker = Faker();
    final date = Helpers.randomDate();
    return MessageTile(
      messageData: MessageData(
        senderName: faker.person.name(),
        message: faker.lorem.sentence(),
        messageDate: date,
        dateMessage: Jiffy.parseFromDateTime(date).fromNow(),
        profilePicture: Helpers.randomPictureUrl(),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile({super.key, required this.messageData});
  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //This also adds the splash effect

        Navigator.push(context, ChatScreen.route(messageData));
      },
      child: Container(
        height: 100,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.2,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Avatar.medium(
                  url: messageData.profilePicture,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                      ),
                      child: Text(
                        messageData.senderName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          letterSpacing: 0.2,
                          wordSpacing: 1.5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Text(
                        messageData.message,
                        style: TextStyle(
                          color: AppColors.textFaded,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      messageData.dateMessage.toUpperCase(),
                      style: TextStyle(
                        color: AppColors.textFaded,
                        letterSpacing: -0.2,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.secondary,
                      ),
                      child: Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.textLigth,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Stories extends StatelessWidget {
  const _Stories({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: SizedBox(
        height: 145,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                top: 8.0,
                bottom: 16.0,
              ),
              child: Text(
                'Stories',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                  color: AppColors.textFaded,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final faker = Faker();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 60,
                        child: _StoryCard(
                          storyData: StoryData(
                            name: faker.person.name(),
                            url: Helpers.randomPictureUrl(),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    Key? key,
    required this.storyData,
  }) : super(key: key);

  final StoryData storyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar.medium(url: storyData.url),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              storyData.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                letterSpacing: 0.3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
