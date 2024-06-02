import 'package:assignment/features/home/widgets/dialog.dart';
import 'package:assignment/features/home/widgets/shimmer.dart';
import 'package:assignment/features/home/widgets/userSearch.dart';
import 'package:assignment/utils/colors.dart';
import 'package:assignment/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.purple,
        title: Text(
          MyStrings.usrList,
          style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: MyColors.white,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: UserSearch(
                    users: controller.users,
                    onUpdate: (filteredUsers) {
                      controller.displayedUsers.value = filteredUsers;
                    }),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                controller.currentIndex.value < controller.users.length) {
              controller.loadMoreUsers();
            }
            return false;
          },
          child: controller.initialLoad.value
              ? ShimmerList()
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.displayedUsers.length,
                        itemBuilder: (context, index) {
                          final user = controller.displayedUsers[index];
                          return Padding(
                            padding:
                                const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: MyColors.purple.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child:
                                      Image.asset("assets/images/profile.jpeg"),
                                ),
                                title: Text(user.name),
                                subtitle: Text('${user.phone}, ${user.city}'),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: MyColors.purple,
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                    ),
                                    SizedBox(height: 4.0),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: user.rupee > 50
                                              ? MyColors.green
                                              : MyColors.red,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 4.0),
                                          child: Text(
                                            user.rupee > 50
                                                ? MyStrings.high
                                                : MyStrings.low,
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
                                        onUpdate: controller.updateRupee,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (controller.isLoading.value)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
        );
      }),
    );
  }
}
