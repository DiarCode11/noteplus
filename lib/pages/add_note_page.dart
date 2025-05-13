import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:memo/config/helper.dart';
import 'package:memo/config/models/notes.dart';

class DetailPage extends StatefulWidget {
  final String heroTag;
  const DetailPage(
    {
      super.key,
      required this.heroTag
      }
    );

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  Color _currentColor = Colors.blue;
  
  void changeColor(Color color) {
    setState(() {
      _currentColor = color;
    });
    Navigator.of(context).pop();
  }

  void _pickColor() {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text("Pilih warna"),
          content: SingleChildScrollView(
            child: BlockPicker(pickerColor: _currentColor, onColorChanged: changeColor),
          ),
        );
      });
  }

  Future<void> _saveNote() async {
    Notes new_note = Notes(
      title: _titleController.text,
      description: _contentController.text,
      color: _currentColor.toString(),
      datetime: DateTime.now(),
    );

    // Simpan ke database
    int id = await DatabaseHelper.instance.insertNote(new_note);
    print('Note saved with id: $id');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) return;
        _saveNote();
        print('Pop berhasi dengan hasil: $result');
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Hero(
            tag: widget.heroTag,
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: const Color(0xFF141414),
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    elevation: 0,
                    actions: [
                      GestureDetector(
                        onTap: _pickColor,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 20,
                          child: const Icon(Icons.delete_forever, color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        onTap: _pickColor,
                        child: CircleAvatar(
                          backgroundColor: _currentColor,
                          radius: 20,
                          child: const Icon(Icons.color_lens, color: Colors.white),
                        ),
                      ),
                      IconButton(
                        onPressed: () {}, 
                        icon: Icon(Icons.push_pin_outlined, color: Colors.white)
                      ),
                      IconButton(
                        onPressed: () {}, 
                        icon: Icon(Icons.notifications_outlined, color: Colors.white)
                      ),
                    ],
                  ),
                  Expanded(
                    child: Card(
                      color: const Color(0xFF141414),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      margin: EdgeInsets.zero,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: _titleController,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.normal,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Judul',
                                  hintStyle: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 28,
                                  ),
                                  border: InputBorder.none,
                                ),
                                minLines: 1,
                                maxLines: null,
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                controller: _contentController,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Isi Catatan',
                                  hintStyle: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 18,
                                  ),
                                  border: InputBorder.none,
                                ),
                                minLines: 1,
                                maxLines: null,
                              ),
                            ],
                          )
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      )
    );
  }
}