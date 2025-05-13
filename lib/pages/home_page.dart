import 'package:flutter/material.dart';
import 'add_note_page.dart';
import '../config/helper.dart';
import '../config/models/notes.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Notes> notes = [];

  void _loadNotes() async {
    try {
      final data = await _databaseHelper.getNotes();
      setState(() => notes = data);
    } catch (e) {
      print('Error loading notes: $e');
    }
  }

  // List<Map<String, dynamic>> notes = [
  //   {
  //     'title': 'Lorem ipsum dolor sit amet consectetur adipiscing elit',
  //     'content': 'This is the content of note 1',
  //     'date': DateTime.now(),
  //     'color': '0xFF8746AE'
  //   },
  //   {
  //     'title': 'Note 2',
  //     'content': 'This is the content of note 2',
  //     'date': DateTime.now(),
  //     'color': '0xFF82222E'
  //   },
  //   {
  //     'title': 'Note 3',
  //     'content': 'This is the content of note 3',
  //     'date': DateTime.now(),
  //     'color': '0xFF07879E'
  //   },
  //   {
  //     'title': 'Note 4',
  //     'content': 'This is the content of note 4',
  //     'date': DateTime.now(),
  //     'color': '0xFF00760E'
  //   }
  // ];

  ScrollController _scrollController = ScrollController();
  int selectedIndexTab = 0;
  List<Map<String, dynamic>> tab_data = [
    {
      'text': 'Pinned',
      'icon': Icons.push_pin_outlined,
    },
    {
      'text': 'Reminders',
      'icon': Icons.notifications_outlined,
    },
    {
      'text': 'All',
      'icon': Icons.book_outlined,
    },
    {
      'text': 'Archive',
      'icon': Icons.archive_outlined,
    }
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages('id', timeago.IdMessages());
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    // 
    return Container(
      color: const Color(0xFF141414),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          // TAB ROW — pindahkan ke atas ListView
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(tab_data.length, (index) {
                return ElevatedButton.icon(
                  onPressed: () {
                    // Ganti body sesuai tab yang dipilih
                    setState(() {
                      selectedIndexTab = index;
                    });

                    // Geser ke kiri ketika tab terakhir diklik
                    if (index == tab_data.length - 1) {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent, 
                        duration: Duration(milliseconds: 200), 
                        curve: Curves.easeInOut
                      );
                    } else if (index < 2){ // Geser ke kanan ketika selain tab terakhir diklik
                      _scrollController.animateTo(
                        _scrollController.position.minScrollExtent, 
                        duration: Duration(milliseconds: 200), 
                        curve: Curves.easeInOut
                      );
                    }

                  },
                  icon: Icon(tab_data[index]['icon']),
                  label: Text(
                    tab_data[index]['text'],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
                    backgroundColor: selectedIndexTab == index ? const Color(0xFF3F3F3F) : Colors.transparent,
                    foregroundColor: selectedIndexTab == index ? Colors.white : Colors.white70,
                    elevation: selectedIndexTab == index ? 2 : 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 10),

          // NOTE CARDS
          ...List.generate(notes.length, (index) {
            final Notes note = notes[index];
            Map note_data = note.toMap();
            return GestureDetector(
              onTap: () {
                try {
                  print('Card tapped');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailPage(
                      heroTag: 'cardHero_$index',
                    )),
                  );
                } catch (e) {
                  print('Error: $e');
                } 
              },
              child: Hero(
                tag: 'cardHero_$index', 
                child: Material(
                  color: Colors.transparent,
                  child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  color: Color(int.parse(note_data['color'])),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 5,
                  child: Container(
                    height: 250,
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Notes - ${timeago.format(note_data['datetime'], locale: 'id')}',
                                  style: const TextStyle(fontSize: 15, color: Colors.white),
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Transform.rotate(
                                    angle: 0.5,
                                    child: IconButton(
                                      onPressed: () {}, 
                                      icon: Icon(
                                        Icons.push_pin_outlined, 
                                        size: 20, 
                                        color: Colors.black
                                      ), 
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              note_data['title'].toString(),
                              style: const TextStyle(
                                fontSize: 25,
                                height: 1.3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              note_data['description'].toString(),
                              style: const TextStyle(fontSize: 18, color: Colors.white70),
                            ),
                          ],
                        ),                      
                      ],
                    ),
                  ),
                ),
                )
              )
            );
          }),
        ],
      ),
    );
  }
}