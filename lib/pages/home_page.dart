import 'package:flutter/material.dart';
import 'package:myapp/utils/todo_list.dart'; // Ensure this import is correct

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  List<List<dynamic>> toDoList = [
    ['Learn Flutter', false],
    ['Drink coffee', false],
  ];

  // Method to handle changes to the checkbox state
  void _handleCheckboxChange(bool? value, int index) {
    setState(() {
      toDoList[index][1] = value ?? false; // Update the checkbox state
    });
  }

  // Method to save a new task
  void saveNewTask() {
    final taskText = _controller.text.trim();
    if (taskText.isNotEmpty) {
      setState(() {
        toDoList.add([taskText, false]);
        _controller.clear();
      });
    }
  }

  // Method to delete a task
  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(
        title: const Text('Simple Todo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (BuildContext context, index) {
          return TodoList(
            taskName: toDoList[index][0] as String,
            taskCompleted: toDoList[index][1] as bool,
            onChanged: (bool? value) => _handleCheckboxChange(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Add a new todo item',
                  filled: true,
                  fillColor: Colors.deepPurple.shade200,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: saveNewTask,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
