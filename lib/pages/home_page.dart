import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      'text': 'Archive',
      'icon': Icons.archive_outlined,
    }
  ];

  @override
  Widget build(BuildContext context) {
    // 
    return Container(
      color: Color(0xFF141414),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(tab_data.length, (index) {
              return ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    selectedIndexTab = index;
                  });
                }, 
                icon: Icon(tab_data[index]['icon']),
                label: Text(
                  tab_data[index]['text'], 
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
                  backgroundColor: selectedIndexTab == index ? const Color(0xFF3F3F3F) : Colors.transparent,
                  foregroundColor: selectedIndexTab == index ? Colors.white : Colors.white70,
                  elevation: selectedIndexTab == index ? 2 : 0, // tambahkan ini
                  shadowColor: Colors.transparent, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  )
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    color: Color(int.parse(notes[index]['color'])),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 5,
                    child: Container(
                      height: 300,
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Membuat jarak antara konten atas & tombol bawah
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Notes - ${notes[index]['date'].day}/${notes[index]['date'].month}/${notes[index]['date'].year}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
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
                                overflow: TextOverflow.ellipsis
                              ),
                              const SizedBox(height: 18),
                              Text(
                                notes[index]['content'].toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          // Tombol di bagian bawah
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
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {}, 
                                  child: Transform.rotate(
                                    angle: 0.5, // dalam radian (~28.6 derajat)
                                    child: Icon(Icons.push_pin_outlined, size: 30),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(60, 60),
                                    backgroundColor: Colors.black54,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                    )
                  );
                },
              ),
            )
        ],
      )
    );
  }
}