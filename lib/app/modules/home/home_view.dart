import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:test_203version/app/modules/home/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ToDo')),
      body: LayoutBuilder(
        builder: (context, constaints) {
          if (constaints.maxWidth > 600) return Row(children: _body());
          return Column(children: _body());
        },
      ),
    );
  }

  List<Widget> _body() {
    return [
      Expanded(
        flex: 3,
        child: StreamBuilder<QuerySnapshot>(
          stream: controller.collection.orderBy('date_added').snapshots(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return const Center(child: CircularProgressIndicator());
            else if (!snapshot.hasData) return const SizedBox();
            return Scrollbar(
              controller: controller.scrollController,
              child: GroupedListView<QueryDocumentSnapshot, String>(
                controller: controller.scrollController,
                elements: snapshot.data.docs,
                groupBy: (res) =>
                    DateFormat('EEEE, dd MMMM yyyy').format((res.data()['date_added'] as Timestamp).toDate()),
                order: GroupedListOrder.DESC,
                useStickyGroupSeparators: true,
                groupSeparatorBuilder: (value) => Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Get.theme.scaffoldBackgroundColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(value), Divider(thickness: 1.5)],
                  ),
                ),
                itemBuilder: (_, doc) {
                  var res = doc.data();
                  return ListTile(
                    tileColor: Color(num.parse((res['color'] as String).replaceAll('#', '0xFF'))),
                    onTap: () {
                      controller.checkTodo(doc.id, res: !res['isClear']);
                    },
                    onLongPress: () {
                      Get.dialog(
                        AlertDialog(
                          elevation: 0,
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.color_lens, color: Colors.green, size: 50),
                                  onPressed: () {
                                    Get.dialog(
                                      AlertDialog(
                                        content: BlockPicker(
                                          pickerColor:
                                              Color(num.parse((res['color'] as String).replaceAll('#', '0xFF'))),
                                          onColorChanged: (value) {
                                            controller.changeColor(doc.id, color: value);
                                          },
                                          availableColors: [
                                            Colors.amber,
                                            Colors.lightBlue,
                                            Colors.lime,
                                            Colors.orange,
                                            Colors.red,
                                            Colors.pink,
                                            Colors.blue,
                                            Colors.green,
                                            Get.theme.scaffoldBackgroundColor,
                                          ],
                                          layoutBuilder: (context, colors, child) => Container(
                                            height: 275,
                                            width: 275,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: GridView.count(
                                                shrinkWrap: true,
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 5.0,
                                                mainAxisSpacing: 5.0,
                                                children: colors.map((Color color) => child(color)).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        backgroundColor: Colors.transparent,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                    );
                                  },
                                  iconSize: 50),
                              IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue, size: 50),
                                  onPressed: () => controller.editTodo(doc.id, res['text']),
                                  iconSize: 50),
                              IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red, size: 50),
                                  onPressed: () => controller.deleteTodo(doc.id),
                                  iconSize: 50),
                            ],
                          ),
                        ),
                      );
                    },
                    leading: Checkbox(
                      value: res['isClear'],
                      onChanged: (value) {
                        controller.checkTodo(doc.id, res: value);
                      },
                    ),
                    title: Text(
                      '${res['text']}',
                      style: TextStyle(
                        decoration: res['isClear'] ? TextDecoration.lineThrough : TextDecoration.none,
                        fontWeight: res['isClear'] ? FontWeight.w300 : FontWeight.w400,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      Obx(
        () => Expanded(
          child: Material(
            color: Colors.grey[300].withOpacity(.5),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller.fieldController,
                    focusNode: controller.fieldNode,
                    decoration: InputDecoration(
                      hintText: 'Add new todo',
                      border: OutlineInputBorder(),
                    ),
                    maxLength: 300,
                    onChanged: controller.text,
                    onSubmitted: controller.text,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 200, height: 40),
                    child: ElevatedButton(
                      onPressed: !controller.isFieldEmpty
                          ? () {
                              controller.addOrEditTodo();
                            }
                          : null,
                      child: Text(!controller.isEditButton ? 'Add' : 'Edit'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ];
  }
}
