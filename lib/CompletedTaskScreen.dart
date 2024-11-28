import 'package:flutter/material.dart';
import 'TaskScreen.dart'; // Modelo de tarefa

class CompletedTasksScreen extends StatelessWidget {
  final List<Task> completedTasks;

  CompletedTasksScreen({required this.completedTasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas Concluídas'),
      ),
      body: completedTasks.isEmpty
          ? Center(
              child: Text(
                'Nenhuma tarefa concluída!',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                final task = completedTasks[index];
                return Card(
                  child: ListTile(
                    title: Text(task.title),
                    subtitle: Text(
                      'Prioridade: ${task.priority}\n${task.description}',
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
    );
  }
}
