import 'package:flutter/material.dart';
import 'package:bookeapp/models/chat_params.dart';
import 'package:bookeapp/models/user.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<AppUserData>>(context);

    return ListView.builder(
        itemCount:users.length,
        itemBuilder: (context, index) {
          return UserTile(users[index]);
        }
    );
  }
}

class UserTile extends StatelessWidget {
  final AppUserData user;

  UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AppUser?>(context);

    if (currentUser == null) throw Exception("current user not found");

    return GestureDetector(
      onTap: (){
        if (currentUser.uid == user.uid) return;
        Navigator.pushNamed(
          context,
          '/chat',
          arguments: ChatParams(currentUser.uid, user),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.only(top: 7.0, bottom: 6.0, left: 10.0, right: 10.0),
          child: ListTile(
            title: Text('U : ${user.name}'),
            subtitle: Text('Drink ${user.waterCounter} water of glass'),
          ),
        ),
      ),
    );
  }
}



