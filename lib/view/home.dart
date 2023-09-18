import 'package:course_getx/components/cardnote.dart';
import 'package:course_getx/components/crud.dart';
import 'package:course_getx/constant/linkapi.dart';
import 'package:course_getx/main.dart';
import 'package:course_getx/view/addnotes.dart';
import 'package:course_getx/view/editnote.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Crud crud = Crud();

  Future<Map<String, dynamic>> getNotes() async {
    var response = await crud
        .postRequest(linkviewnote, {"id": sharepref!.getString("id")});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              sharepref?.clear();
              Get.offAndToNamed("/login");
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddNotes());
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(children: [
        FutureBuilder<Map<String, dynamic>>(
          future: getNotes(),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: Text("No Data Available"),
              );
            }
            final data = snapshot.data!;
            if (data['status'] == 'failed' ||
                data['data'] == null ||
                (data['data'] as List).isEmpty) {
              return const Center(
                child: Text("No Notes Found"),
              );
            }
            return ListView.builder(
              itemCount: (data['data'] as List).length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                return CardNotes(
                  onDelete: () async {
                    var response = await crud.postRequest(linkdeletenote, {
                      "id": snapshot.data!['data'][i]['notes_id'].toString()
                    });
                    setState(() {});
                    if (response['status'] == "success") {
                      Navigator.of(context).pushReplacementNamed("/home");
                    }
                  },
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditNotes(
                              notes: snapshot.data!['data'][i],
                            )));
                  },
                  title: "${data['data'][i]['notes_title']}",
                  content: "${data['data'][i]['notes_content']}",
                );
              },
            );
          },
        ),
      ]),
    );
  }
}
