import 'package:flutter/material.dart';
import 'package:todo_practica/models/nota.dart';

class ModalNota extends StatefulWidget {
  final Nota? nota;
  final Function(Nota) onNotaGuardada;

  const ModalNota({Key? key, this.nota, required this.onNotaGuardada})
      : super(key: key);

  @override
  State<ModalNota> createState() => _ModalNotaState();
}

class _ModalNotaState extends State<ModalNota> {
  late TextEditingController _tituloController;
  late TextEditingController _descripcionController;

  @override
  void initState() {
    _tituloController =
        TextEditingController(text: widget.nota?.titulo ?? '');
    _descripcionController =
        TextEditingController(text: widget.nota?.descripcion ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.white,
      child: Form(
        child: Column(
          children: [
            TextFormField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título de la nota'),
            ),
            TextFormField(
              controller: _descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
              maxLines: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_tituloController.text.isNotEmpty &&
                        _descripcionController.text.isNotEmpty) {
                      Nota notaGuardada = Nota(
                        titulo: _tituloController.text,
                        descripcion: _descripcionController.text,
                      );

                      widget.onNotaGuardada(notaGuardada);

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Nota guardada correctamente'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ambos campos deben ser completados'),
                        ),
                      );
                    }
                  },
                  child: const Text('Guardar'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
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

