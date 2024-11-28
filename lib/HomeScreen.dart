import 'package:flutter/material.dart';
import 'TaskScreen.dart'; // Tela de tarefas
import 'CompletedTaskScreen.dart'; // Tela de progresso

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Task> _tasks = [];
  final List<Task> _completedTasks = [];

  void _updateTask(Task task) {
    setState(() {
      final index = _tasks.indexWhere((t) => t.title == task.title);
      if (index != -1) {
        _tasks[index] = task;
      }
    });
  }

  void _moveToCompleted(Task task) {
    setState(() {
      _tasks.remove(task); 
      _completedTasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _screens = [
      TaskScreen(
        tasks: _tasks,
        onUpdateTask: _updateTask,
        onMoveToCompleted: _moveToCompleted,
      ),
      CompletedTasksScreen(completedTasks: _completedTasks),
    ];

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Tarefas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Concluídas',
          ),
        ],
      ),
    );
  }
}
