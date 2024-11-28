import 'package:flutter/material.dart';
import 'AddTaskScrenn.dart';

class Task {
  final String title;
  final String description;
  final String priority;
  bool isCompleted; // Novo campo para o status de conclusão

  Task({
    required this.title,
    this.description = '',
    required this.priority,
    this.isCompleted = false,
  });
}

class TaskScreen extends StatefulWidget {
  final List<Task> tasks;
  final Function(Task) onUpdateTask;
  final Function(Task) onMoveToCompleted;

  TaskScreen({
    required this.tasks,
    required this.onUpdateTask,
    required this.onMoveToCompleted,
  });

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  void _toggleCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
      if (task.isCompleted) {
        widget.onMoveToCompleted(task); // Mover para concluídas
        // Exibir a mensagem de tarefa concluída
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tarefa "${task.title}" concluída!'),
            duration: Duration(seconds: 2), // Duração de 2 segundos
          ),
        );
      } else {
        widget.onUpdateTask(task); // Atualizar status de tarefa
      }
    });
  }

  // Função para navegar para a tela de adicionar tarefa
  void _navigateToAddTask() async {
    final Task? newTask = await Navigator.push<Task?>(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskScreen(), // Tela de adicionar tarefa
      ),
    );

    if (newTask != null) {
      setState(() {
        widget.tasks.add(newTask); // Adiciona a tarefa criada à lista
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filtrando tarefas não concluídas
    final activeTasks = widget.tasks.where((task) => !task.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Tarefas'),
      ),
      body: activeTasks.isEmpty
          ? Center(
              child: Text(
                'Nenhuma tarefa pendente!',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: activeTasks.length,
              itemBuilder: (context, index) {
                final task = activeTasks[index];
                return Card(
                  child: ListTile(
                    title: Text(task.title),
                    subtitle: Text(
                      'Prioridade: ${task.priority}\n${task.description}',
                    ),
                    isThreeLine: true,
                    trailing: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) {
                        _toggleCompletion(task);
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTask, // Chama a função para navegar para a tela de adicionar tarefa
        child: Icon(Icons.add),
        tooltip: 'Adicionar nova tarefa',
      ),
    );
  }
}
