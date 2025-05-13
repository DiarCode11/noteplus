import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Map<String, dynamic>> notes = [
    {
      'title': 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
      'content': 'This is the content of note 1',
      'date': DateTime.now(),
      'color': '0xFF8746AE'
    },
    {
      'title': 'Note 2',
      'content': 'This is the content of note 2',
      'date': DateTime.now(),
      'color': '0xFF82222E'
    },
    {
      'title': 'Note 3',
      'content': 'This is the content of note 3',
      'date': DateTime.now(),
      'color': '0xFF07879E'
    },
    {
      'title': 'Note 4',
      'content': 'This is the content of note 4',
      'date': DateTime.now(),
      'color': '0xFF00760E'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF141414),
      child: ListView(
        children: List.generate(notes.length, (index) {
          return GestureDetector(
            onTap: () {
              print('Card tapped');
            },
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              color: Color(int.parse(notes[index]['color'])),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 5,
              child: Container(
                height: 300,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notes - ${notes[index]['date'].day}/${notes[index]['date'].month}/${notes[index]['date'].year}',
                          style: const TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          notes[index]['title'].toString(),
                          style: const TextStyle(
                            fontSize: 28,
                            height: 1.3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 18),
                        Text(
                          notes[index]['content'].toString(),
                          style: const TextStyle(fontSize: 18, color: Colors.white70),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              print('Tombol ditekan');
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(280, 60),
                              backgroundColor: Colors.black12,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text(
                              'Set a reminder',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Transform.rotate(
                              angle: 0.5,
                              child: const Icon(Icons.push_pin_outlined, size: 30),
                            ),
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(60, 60),
                              backgroundColor: Colors.black54,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          );
        }),
      )
    );
  }
}