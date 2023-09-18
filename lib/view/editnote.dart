import 'package:course_getx/components/crud.dart';
import 'package:course_getx/constant/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditNotes extends StatefulWidget {
  final notes;
  const EditNotes({super.key, this.notes});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  bool isLoading = false;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Crud crud = Crud();

  EditNotes() async {
    if (formState.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(linkeditnote, {
        "title": title.text,
        "content": content.text,
        "id": widget.notes['notes_id'].toString(),
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
  void initState() {
    title.text = widget.notes['notes_title'];
    content.text = widget.notes['notes_content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Notes"),
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
                        await EditNotes();
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
