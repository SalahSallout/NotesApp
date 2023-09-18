import 'package:course_getx/components/crud.dart';
import 'package:course_getx/constant/linkapi.dart';
import 'package:course_getx/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  bool isLoading = false;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Crud crud = Crud();

  addNotes() async {
    if (formState.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(linkaddnote, {
        "title": title.text,
        "content": content.text,
        "id": sharepref!.getString("id"),
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Get.offAndToNamed("/home");
      } else {
        //
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notes"),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formState,
                child: Column(
                  children: [
                    TextFormField(
                      controller: title,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Title is required";
                        }
                        if (val.length > 30) {
                          return "Title can't be longer than 30 characters";
                        }
                        if (val.length < 2) {
                          return "Title must be at least 2 characters long";
                        }
                        return null;
                      },
                      maxLength: 30,
                      decoration: const InputDecoration(
                        labelText: "Title Note",
                        prefixIcon: Icon(Icons.title),
                      ),
                    ),
                    TextFormField(
                      controller: content,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Note is required";
                        }
                        if (val.length > 255) {
                          return "Note can't be longer than 255 characters";
                        }
                        if (val.length < 10) {
                          return "Note must be at least 10 characters long";
                        }
                        return null;
                      },
                      minLines: 1,
                      maxLines: 3,
                      maxLength: 200,
                      decoration: const InputDecoration(
                        labelText: "Note",
                        prefixIcon: Icon(Icons.note),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await addNotes();
                        Get.offAndToNamed("/home");
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
