import 'package:assignment/features/home/model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomeController extends GetxController {
  var users = <User>[].obs;
  var displayedUsers = <User>[].obs;
  var currentIndex = 0.obs;
  var isLoading = false.obs;
  var initialLoad = true.obs;
  final itemsPerPage = 20;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadInitialUsers();
  }

  Future<void> loadInitialUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsersJson = prefs.getString('users');
    if (savedUsersJson != null) {
      List<dynamic> decodedUsers = jsonDecode(savedUsersJson);
      users.value = decodedUsers.map((e) => User.fromJson(e)).toList();
    } else {
      users.value = List.generate(
        43,
            (index) => User(
          name: 'User $index',
          phone: '+91123456789$index',
          city: 'City $index',
          image: 'assets/images/background.png',
          rupee: index % 100,
        ),
      );
      await saveUsers();

    }
    loadMoreUsers(initialLoad: true);
  }

  Future<void> saveUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedUsers = jsonEncode(users);
    await prefs.setString('users', encodedUsers);
  }

  void loadMoreUsers({bool initialLoad = false}) async {
    if (isLoading.value) return;
    isLoading.value = true;

    await Future.delayed(Duration(seconds: 2));

    if (currentIndex.value < users.length) {
      displayedUsers.addAll(users.skip(currentIndex.value).take(itemsPerPage));
      currentIndex.value += itemsPerPage;
    }
    isLoading.value = false;
    if (initialLoad) this.initialLoad.value = false;
  }

  void updateRupee(int index, int newRupee) {
    users[index].rupee = newRupee;
    displayedUsers[index].rupee = newRupee;
    users.refresh();
    displayedUsers.refresh();
    saveUsers();
  }

  void filterUsers(String query) {
    displayedUsers.value = users.where((user) {
      return user.name.contains(query) ||
          user.phone.contains(query) ||
          user.city.contains(query);
    }).toList();
  }
}

