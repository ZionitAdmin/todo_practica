
import 'package:flutter/material.dart';
import 'package:todo_practica/models/nota.dart';
import 'package:todo_practica/widgets/nota_tile.dart';
import 'package:todo_practica/widgets/modal_nota.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Nota> misNotas = [
    Nota(titulo: 'titulo1', descripcion: 'descripcion de la nota1'),
    Nota(titulo: 'titulo2', descripcion: 'descripcion de la nota2'),
    Nota(titulo: 'titulo3', descripcion: 'descripcion de la nota3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notas App', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return ModalNota(
                onNotaGuardada: (Nota nuevaNota) {
                  setState(() {
                    misNotas.add(nuevaNota);
                  });
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: misNotas.length,
        itemBuilder: (context, index) {
          return NotaTile(
            nota: misNotas[index],
            onEditar: (Nota notaEditada) {
              _editarNota(index, notaEditada);
            },
            onEliminar: () {
              _eliminarNota(index);
            },
          );
        },
      ),
    );
  }

  void _editarNota(int index, Nota notaEditada) {
    setState(() {
      misNotas[index] = notaEditada;
    });
  }

  void _eliminarNota(int index) {
    setState(() {
      misNotas.removeAt(index);
    });
  }
}
