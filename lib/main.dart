import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/notes_page.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF141414), // Warna tetap
          elevation: 0, // Tidak ada bayangan
        ),
      ),

      home: const MainPage(title: 'NotePlus'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _counter = 0;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<IconData> icons = [
    LineAwesomeIcons.home,
    LineAwesomeIcons.edit,
    Icons.format_list_bulleted,
    LineAwesomeIcons.microphone,
    LineAwesomeIcons.user_1,
  ];

  final List<Widget> activePages = [
    const HomePage(),
    const NotesPage(),
    const NotesPage(),
    const NotesPage(),
    const NotesPage(),
  ];

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });

    Future.delayed(Duration(milliseconds: 100), () {
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Menyembunyikan keyboard saat mengetuk di luar TextField
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 0,
          title: _isSearching
              ? TextField(
                  controller: _searchController,
                  focusNode: _focusNode, // Fokus otomatis
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: const TextStyle(
                      color: Colors.white54,
                      fontSize: 20,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    suffixIcon: IconButton(
                      icon:
                          const Icon(Icons.clear, color: Colors.white, size: 20),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _isSearching = false;
                        });
                      },
                    ),
                  ),
                )
              : Text(
                  widget.title,
                  style: const TextStyle(color: Colors.white),
                ),
          backgroundColor: const Color(0xFF141414),
          actions: _isSearching
              ? []
              : [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: CircleAvatar(
                      radius: 27,
                      backgroundColor: const Color(0xFF3F3F3F),
                      child: IconButton(
                        onPressed: _startSearch,
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
        ),
        body: activePages[_counter],
        bottomNavigationBar: BottomAppBar(
          height: 80,
          color: const Color.fromARGB(255, 48, 48, 48),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(icons.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _counter = index;
                      print('Selected index: $_counter');
                    });
                  },
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor:
                        _counter == index ? Colors.white : Colors.transparent,
                    child: Icon(
                      icons[index],
                      size: 26,
                      color: _counter == index ? Colors.black : Colors.white,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
