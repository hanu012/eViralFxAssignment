import 'package:assignment/features/home/model/userModel.dart';
import 'package:assignment/features/home/widgets/dialog.dart';
import 'package:assignment/utils/colors.dart';
import 'package:assignment/utils/strings.dart';
import 'package:flutter/material.dart';

class UserSearch extends SearchDelegate {
  final List<User> users;
  final Function(List<User>) onUpdate;

  UserSearch({required this.users, required this.onUpdate});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  void close(BuildContext context, result) {
    onUpdate(users);
    super.close(context, result);
  }

  @override
  Widget buildResults(BuildContext context) {
    List<User> filteredUsers = users.where((user) {
      String lowerQuery = query.toLowerCase();
      return user.name.toLowerCase().contains(lowerQuery) ||
          user.phone.toLowerCase().contains(lowerQuery) ||
          user.city.toLowerCase().contains(lowerQuery);
    }).toList();


    WidgetsBinding.instance.addPostFrameCallback((_) {
      onUpdate(filteredUsers);
    });

    if (filteredUsers.isEmpty) {
      return Center(
        child: Text(MyStrings.noResFound),
      );
    }

    return ListView.builder(
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        final user = filteredUsers[index];
        return ListTile(
          leading: Image.asset(user.image),
          title: Text(user.name),
          subtitle: Text('${user.phone}, ${user.city}'),
          trailing: Text(
            user.rupee > 50 ? MyStrings.high : MyStrings.low,
            style: TextStyle(
              color: user.rupee > 50 ? MyColors.green : MyColors.red,
            ),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return ChangeRupeeDialog(
                  index: index,
                  user: user,
                  onUpdate: (index, rupee) {
                    filteredUsers[index].rupee = rupee;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      onUpdate(filteredUsers);
                    });
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
