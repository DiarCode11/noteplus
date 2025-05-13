import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddListPage extends StatefulWidget {
  const AddListPage(
    {
      super.key,
      }
    );

  @override
  State<AddListPage> createState() => _AddListPageState();
}

class _AddListPageState extends State<AddListPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _listController = TextEditingController();
  Color _currentColor = Colors.blue;
  bool _isChecked = false;
  
  void changeColor(Color color) {
    setState(() {
      _currentColor = color;
    });
    Navigator.of(context).pop();
  }

  List<Widget> listItems = [];

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

  @override
  void dispose() {
    _titleController.dispose();
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color(0xFF141414),
      body: Container(
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
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Transform.scale(
                                    scale: 1.5,
                                    child: Checkbox(
                                      value: _isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isChecked = value!;
                                        });
                                      },
                                    )
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _listController,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 22,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'List',
                                        hintStyle: const TextStyle(
                                          color: Colors.white54,
                                          fontSize: 22,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      minLines: 1,
                                      maxLines: null,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {}, 
                                    icon: Icon(Icons.delete, color: Colors.white, size: 25,)
                                  )
                                ],
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 10),
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add, 
                                        color: Colors.white
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Add List",
                                        style: TextStyle(
                                          color: Colors.white, 
                                          fontSize: 20
                                        ),
                                      ),
                                    ],
                                  )
                                )
                              ],
                            ),
                          )
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
    );
  }
}