import 'package:flutter/material.dart';
import 'package:todo_practica/models/nota.dart';
import 'package:todo_practica/values/tema.dart';




class HomePage extends StatefulWidget {
  
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
              return ModalNuevaNota(
                onNotaAgregada: (Nota nuevaNota) {
                  setState(() {
                    misNotas.add(nuevaNota);
                  });
                },
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: misNotas.length,
        itemBuilder: (context, index) {
          return _buildNotaItem(misNotas[index]);
        },
      ),
    );
  }

  Widget _buildNotaItem(Nota nota) {
    return ListTile(
      title: Text(nota.titulo!),
      subtitle: Text(nota.descripcion!),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _editarNota(nota);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _eliminarNota(nota);
            },
          ),
        ],
      ),
    );
  }

  void _editarNota(Nota nota) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ModalEditarNota(
          nota: nota,
          onNotaEditada: (Nota notaEditada) {
            setState(() {
            
              int index = misNotas.indexOf(nota);
              misNotas[index] = notaEditada;
            });
          },
        );
      },
    );
  }

  void _eliminarNota(Nota nota) {
    setState(() {
      misNotas.remove(nota);
    });
  }
}

class ModalNuevaNota extends StatefulWidget {
  final Function(Nota) onNotaAgregada;

  const ModalNuevaNota({Key? key, required this.onNotaAgregada}) : super(key: key);

  @override
  State<ModalNuevaNota> createState() => _ModalNuevaNotaState();
}

class _ModalNuevaNotaState extends State<ModalNuevaNota> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: blanco,
      child: Form(
        child: Column(
          children: [
            TextFormField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Titulo de la nota'),
            ),
            TextFormField(
              controller: _descripcionController,
              decoration: const InputDecoration(labelText: 'Descripcion'),
              maxLines: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    
                    Nota nuevaNota = Nota(
                      titulo: _tituloController.text,
                      descripcion: _descripcionController.text,
                    );

                 
                    widget.onNotaAgregada(nuevaNota);

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Nota agregada correctamente'),
                      ),
                    );
                  },
                  child: Text('Aceptar'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descripcionController.dispose();
    _tituloController.dispose();
    super.dispose();
  }
}

class ModalEditarNota extends StatefulWidget {
  final Nota nota;
  final Function(Nota) onNotaEditada;

  const ModalEditarNota({Key? key, required this.nota, required this.onNotaEditada})
      : super(key: key);

  @override
  State<ModalEditarNota> createState() => _ModalEditarNotaState();
}

class _ModalEditarNotaState extends State<ModalEditarNota> {
  late TextEditingController _tituloController;
  late TextEditingController _descripcionController;

  @override
  void initState() {
    _tituloController = TextEditingController(text: widget.nota.titulo);
    _descripcionController = TextEditingController(text: widget.nota.descripcion);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: blanco,
      child: Form(
        child: Column(
          children: [
            TextFormField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Titulo de la nota'),
            ),
            TextFormField(
              controller: _descripcionController,
              decoration: const InputDecoration(labelText: 'Descripcion'),
              maxLines: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    
                    Nota notaEditada = Nota(
                      titulo: _tituloController.text,
                      descripcion: _descripcionController.text,
                    );

                
                    widget.onNotaEditada(notaEditada);

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Nota editada correctamente'),
                      ),
                    );
                  },
                  child: Text('Aceptar'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descripcionController.dispose();
    _tituloController.dispose();
    super.dispose();
  }
}
