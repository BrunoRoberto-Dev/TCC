import 'package:flutter/material.dart';
import 'package:foco_alternativo/models/user_model.dart';
import 'package:foco_alternativo/repository/user_repository.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.put(SignUpController());

  final email = TextEditingController();
  final password = TextEditingController();
  final nick = TextEditingController();

  final userRepo = Get.put(UserRepository());

  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
  }
}