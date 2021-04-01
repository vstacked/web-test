import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final collection = FirebaseFirestore.instance.collection('todos');

  final scrollController = ScrollController();

  final text = ''.obs;
  final fieldController = TextEditingController();
  final fieldNode = FocusNode();

  String _docId = '';

  bool get isFieldEmpty => this.text.isEmpty;

  final _isEditButton = false.obs;
  bool get isEditButton => _isEditButton.value;

  void addOrEditTodo() {
    if (!isEditButton) {
      collection.add({
        "isClear": false,
        "text": text.value,
        "color": '#${Get.theme.scaffoldBackgroundColor.value.toRadixString(16)}',
        "date_added": DateTime.now(),
      });
    } else {
      collection.doc(_docId).update({"text": text.value});
      _docId = '';
      _isEditButton.value = false;
    }

    text.value = '';
    fieldController.clear();
  }

  void editTodo(String id, String value) {
    _docId = id;
    fieldController.text = text.value = value;
    _isEditButton.value = true;
    fieldNode.requestFocus();
    Get.back();
  }

  void deleteTodo(String id) {
    collection.doc(id).delete();
    Get.back();
  }

  void checkTodo(String id, {bool res = true}) {
    collection.doc(id).update({"isClear": res});
  }

  void changeColor(String id, {Color color}) {
    collection.doc(id).update({"color": '#${color.value.toRadixString(16)}'});
    Get.close(2);
  }
}
