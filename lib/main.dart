import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'pages/home_page.dart';
import 'pages/notes_page.dart';
import 'pages/add_note_page.dart';
import 'pages/add_list_page.dart';
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
  bool _isSearching = false;
  int _currentPage = 0;
  bool _isAnimating = false;
  final TextEditingController _searchController = TextEditingController();
  final PageController _pageController = PageController();
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

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _onNavbarTapped (int index) async {
    if (_currentPage == index || _isAnimating) return;

    setState(() {//Matikan tombol saat animasi
      _isAnimating = true;
    });

    await _pageController.animateToPage(
      index, 
      duration: Duration(milliseconds: 300), 
      curve: Curves.easeInOut
    );

    setState(() {
      _isAnimating = false;
      _currentPage = index;
    });
    print('Tapped index: $_currentPage');
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });

    Future.delayed(Duration(milliseconds: 100), () {
      _focusNode.requestFocus();
    });
  }

  @override 
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
          backgroundColor: Color(0xFF141414),
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
        body: HomePage(),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 20, right: 20),
          child: SpeedDial(
            icon: Icons.add,
            activeIcon: Icons.close,
            backgroundColor: Colors.white,
            overlayColor: Colors.black54,
            spaceBetweenChildren: 8,
            children: [
              SpeedDialChild(
                child: const Icon(
                  LineAwesomeIcons.edit,
                  color: Colors.white,
                ),
                label: 'Note',
                backgroundColor: Colors.green,
                onTap: () {
                  print('Note');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailPage(heroTag: "Note",),));
                },
              ),
              SpeedDialChild(
                child: const Icon(
                  Icons.format_list_bulleted,
                  color: Colors.white,
                ),
                label: 'List',
                backgroundColor: Colors.red,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddListPage(),));
                },
              ),
              SpeedDialChild(
                child: const Icon(
                  LineAwesomeIcons.microphone,
                  color: Colors.white,
                ),
                label: 'Voice Note',
                backgroundColor: Colors.blue,
                onTap: () {
                  print('Voice Note');
                },
              ),
            ],
          ),
        )
        // bottomNavigationBar: BottomAppBar(
        //   height: 80,
        //   color: const Color.fromARGB(255, 48, 48, 48),
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: List.generate(icons.length, (index) {
        //         return GestureDetector(
        //           onTap: () => _onNavbarTapped(index),
        //           child: CircleAvatar(
        //             radius: 28,
        //           backgroundColor: (_isAnimating || _currentPage != index) 
        //             ? Colors.transparent // Tidak aktifkan warna saat animasi
        //             : Colors.white, // Aktifkan warna putih saat tidak animasi
        //           child: Icon(
        //             icons[index],
        //             size: 26,
        //             color: (_isAnimating || _currentPage != index) 
        //               ? Colors.white // Tidak berubah warna saat animasi
        //               : Colors.black, // Warna hitam saat aktif
        //             ),
        //           ),
        //         );
        //       }),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
