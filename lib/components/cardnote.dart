import 'package:flutter/material.dart';

class CardNotes extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final String content;
  final void Function()? onDelete;
  const CardNotes({
    Key? key,
    required this.onTap,
    required this.title,
    required this.content,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset('images/images.png'),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text(title),
                subtitle: Text(content),
                trailing: IconButton(
                    onPressed: onDelete, icon: const Icon(Icons.delete)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
