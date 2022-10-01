import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/modal/user_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final queryPost = FirebaseFirestore.instance.collection('users');

  final ScrollController scrollController = ScrollController();

  List<UserModal> userModalList = [];

  RxBool isPaginationLoading = RxBool(false);
  RxBool isLoading = RxBool(true);

  bool hasMore = true;

  int documentLimit = 10;

  DocumentSnapshot? lastDocument;

  @override
  void onInit() {
    getUserData();
    scrollListener();
    super.onInit();
  }

  void scrollListener() {
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      if (maxScroll == currentScroll && !isPaginationLoading.value && hasMore) {
        getUserData();
      }
    });
  }

  Future<void> getUserData() async {
    try {
      isPaginationLoading.value = true;
      QuerySnapshot querySnapshot;
      if (lastDocument == null) {
        querySnapshot = await queryPost.limit(documentLimit).get();
      } else {
        querySnapshot = await queryPost
            .startAfterDocument(lastDocument!)
            .limit(documentLimit)
            .get();
      }
      if (querySnapshot.docs.length < documentLimit) {
        hasMore = false;
      }
      lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];

      for (var element in querySnapshot.docs) {
        userModalList.add(UserModal.fromJson(element));
      }
    } catch (e) {
      log(e.toString(), name: "Error");
    } finally {
      isLoading.value = false;
      isPaginationLoading.value = false;
    }
  }
}
