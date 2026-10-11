import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('заметки')),
        body: const MyNotes(),
      ),
    );
  }
}
class MyNotes extends StatefulWidget {
  const MyNotes({super.key});
  @override
  State<MyNotes> createState() => MyNotesState();
}

class MyNotesState extends State<MyNotes> {
  final TextEditingController myController = TextEditingController();
  List<String> myNotes = [];
  int? number;
  void addNote() {
    String newNote = myController.text;
    if (newNote.trim().isEmpty) {
      return;
    }

    setState(() {
      if (number == null) {
        myNotes.add(newNote);
      } else {
        myNotes[number!] = newNote;
        number = null;
      }
      myController.clear();
    });
  }

  void changeNote(int i) {
    setState(() {
      myController.text = myNotes[i];
      number = i;
    });
  }

  void removeNote(int i) {
    setState(() {
      myNotes.removeAt(i);
      if (number == i) {
        number = null;
        myController.clear();
      } else if (number != null && number! > i) {
        number = number! - 1;
      }
    });
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: myController,
          decoration: const InputDecoration(hintText: 'введите заметку'),
        ),
        ElevatedButton(
          onPressed: addNote,
          child: Text(number == null ? 'сохранить' : 'изменить заметку'),
        ),
        const Text('записи'),

        Expanded(
          child: ListView.builder(
            itemCount: myNotes.length,
            itemBuilder: (context, i) {
              return ListTile(
                title: Text(myNotes[i]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        changeNote(i);
                      },
                      child: const Text('изменить'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        removeNote(i);
                      },
                      child: const Text('удалить'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
