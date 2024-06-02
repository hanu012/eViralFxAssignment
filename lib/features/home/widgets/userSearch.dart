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
        return Padding(
          padding: const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 0.0),
          child: Container(
            decoration: BoxDecoration(
                color: MyColors.purple.withOpacity(.1),
                borderRadius: BorderRadius.circular(10)),            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset("assets/images/profile.jpeg"),
              ),
              title: Text(user.name),
              subtitle: Text('${user.phone}, ${user.city}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: MyColors.purple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        '₹ ${user.rupee}',
                        style: TextStyle(
                          color: MyColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: user.rupee > 50 ? MyColors.green : MyColors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: Text(
                          user.rupee > 50 ? MyStrings.high : MyStrings.low,
                          style: TextStyle(
                            color: user.rupee > 50
                                ? MyColors.white
                                : MyColors.white,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
