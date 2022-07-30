import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskly/models/task.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late double _deviceHeight, _deviceWidth;


  String? _newTaskContent;
  String _newManfacturer = 'JayJay Tech';
  double _newWeigth = 10;

  Box? _box;
  _HomePageState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight * 0.15,
        title: const Text(
          "DroneTech!",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: _tasksView(),
      floatingActionButton: _addTaskButton(),
    );
  }


  Widget _tasksView() {
    return FutureBuilder(
      future: Hive.openBox('tasks'),
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (_snapshot.hasData) {
          _box = _snapshot.data;
          return _tasksList();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _tasksList() {
    List tasks = _box!.values.toList();
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext _context, int _index) {
        var task = Task.fromMap(tasks[_index]);
        return ListTile(
            selected: true,
            title: Text(
              Task.fromMap(tasks[_index]).IDtag,
              style: TextStyle(
                decoration: task.Service ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  task.dateAcquired.toString(),

                ),
                Text(task.Manufacturer),
                Text(task.weigth.toString())
              ],
            ),
            trailing: Row(
              children: [
                Text('Service'),
                Icon(
                  task.Service
                      ? Icons.check_box_outlined
                      : Icons.check_box_outline_blank_outlined,
                  color: Colors.red,
                ),
              ],
            ),
            onTap: () {
              task.Service = !task.Service;
              _box!.putAt(
                _index,
                task.toMap(),
              );
              setState(() {});
            },
            onLongPress:(){
              _box!.deleteAt(_index);
              setState(() {
              });
            }
        );
      },
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: _displayTaskPopup,
      child: const Icon(
        Icons.add,
      ),
    );
  }
  void _displayTaskPopup() {
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          title: const Text("Add Drone Device!"),
          content: TextField(
            onSubmitted: (_) {
              if (_newTaskContent != null) {
                var _task = Task(
                    IDtag: _newTaskContent!,
                    weigth: _newWeigth,
                    Manufacturer: _newManfacturer,
                    dateAcquired: DateTime.now(),
                    Service: false);
                _box!.add(_task.toMap());
                setState(() {
                  _newTaskContent = null;
                  Navigator.pop(context);
                });
              }
            },
            onChanged: (_value) {
              setState(() {
                _newTaskContent = _value;
              });
            },
          ),
        );
      },
    );
  }
  Widget Myname(){
    return ListTile(
      title: Text('it works'),

    );
  }

}
