import 'package:example/screens/chat/chat.screen.dart';
import 'package:example/screens/chat/open_chat.screen.dart';
import 'package:example/screens/entry/entry.screen.dart';
import 'package:example/screens/forum/forum.screen.dart';
import 'package:example/screens/meetup/meetup.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Text(
            'Intl.getCurrentLocale(): ${Intl.getCurrentLocale()}',
          ),
          Text(
            'getLanguageCode: ${getLanguageCode(context)}',
          ),
          Text(
            'getDeviceCurrentLocale: ${getDeviceCurrentLocale(context)}',
          ),
          const Text(
            "DateFormat.yMMMEd(getLanguageCode(context)).format(DateTime.now())",
            style: TextStyle(fontSize: 9),
          ),
          Text(
            DateFormat.yMMMEd(getLanguageCode(context)).format(DateTime.now()),
          ),
          const Text(
            "DateFormat.yMMMEd('ko').format(DateTime.now())",
            style: TextStyle(fontSize: 9),
          ),
          Text(
            DateFormat.yMMMEd('ko').format(DateTime.now()),
          ),
          const Text(
            "DateFormat.yMMMEd().format(DateTime.now())",
            style: TextStyle(fontSize: 9),
          ),
          Text(
            DateFormat.yMMMEd().format(DateTime.now()),
          ),
          const Text(
            "DateFormat.jm().format(DateTime.now())",
            style: TextStyle(fontSize: 9),
          ),
          Text(
            DateFormat.jm().format(DateTime.now()),
          ),
          Login(
            yes: (uid) {
              return Column(
                children: [
                  const ChatRoomCreateButton(),
                  const Text("@TODO: 채팅방 방장이, 채팅 삭제, 채팅방 멤버 강퇴 기능 추가"),
                  Text(
                      "Logged in as ${FirebaseAuth.instance.currentUser?.email}, $uid"),
                  Text("Admin: ${AdminService.instance.isAdmin}"),
                  Wrap(
                    spacing: 8,
                    children: [
                      ElevatedButton(
                          onPressed: () => UserService.instance
                              .showProfileUpdateScreen(context: context),
                          child: const Text('Profile Update')),
                      ElevatedButton(
                        onPressed: () async {
                          await UserService.instance.signOut();
                          if (context.mounted) {
                            context.go(EntryScreen.routeName);
                          }
                        },
                        child: const Text('Sign Out'),
                      ),
                      ElevatedButton(
                        onPressed: () => context.push(ChatScreen.routeName),
                        child: const Text('Chat'),
                      ),
                      ElevatedButton(
                        onPressed: () => context.push(OpenChatScreen.routeName),
                        child: const Text('Open Chat'),
                      ),
                      ElevatedButton(
                        onPressed: () => context.push(ForumScreen.routeName),
                        child: const Text('Fourm'),
                      ),
                      ElevatedButton(
                        onPressed: () => context.push(MeetupScreen.routeName),
                        child: const Text('Meetup'),
                      ),
                      ElevatedButton(
                        onPressed: () => AdminService.instance
                            .showDashboard(context: context),
                        child: const Text('Admin dashboard'),
                      ),
                    ],
                  ),
                ],
              );
            },
            no: () => const Text("Not logged in"),
          ),
          const Expanded(child: UserListView())
        ],
      ),
    );
  }
}
