import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';

class AdminUserListScreen extends StatefulWidget {
  static const String routeName = '/AdminUserList';
  const AdminUserListScreen({super.key});

  @override
  State<AdminUserListScreen> createState() => _AdminUserListScreenState();
}

class _AdminUserListScreenState extends State<AdminUserListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User list'),
      ),
      body: FirebaseDatabaseListView(
        query: User.usersRef,
        itemBuilder: (context, doc) {
          final user = User.fromSnapshot(doc);
          return ListTile(
            title: Text(user.displayName),
            subtitle: Text(user.uid),
            trailing: Text(isAdmin ? '관리자' : ''),
            onTap: () {
              AdminService.instance.showUserUpdate(
                context: context,
                uid: user.uid,
              );
            },
          );
        },
      ),
    );
  }
}
