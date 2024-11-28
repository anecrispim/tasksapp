import 'package:flutter/material.dart';
import 'TaskScreen.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _priority = 'Média';
  bool _isSaving = false;

  void _saveTask() {
    if (_isSaving) return;
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('O título é obrigatório!')),
      );
      return;
    }

    setState(() {
      _isSaving = true; // Evita novos cliques enquanto processa
    });

    // Cria a nova tarefa
    final newTask = Task(
      title: _titleController.text,
      description: _descriptionController.text,
      priority: _priority,
    );

    Navigator.pop(context, newTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Tarefa'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descrição'),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            Text('Prioridade'),
            DropdownButton<String>(
              value: _priority,
              onChanged: (value) {
                setState(() {
                  _priority = value!;
                });
              },
              items: ['Alta', 'Média', 'Baixa']
                  .map((priority) => DropdownMenuItem(
                        value: priority,
                        child: Text(priority),
                      ))
                  .toList(),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: _isSaving ? null : _saveTask,
              child: Text('Salvar Tarefa'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
