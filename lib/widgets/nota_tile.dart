import 'package:flutter/material.dart';
import 'package:todo_practica/models/nota.dart';
import 'package:todo_practica/widgets/modal_nota.dart';


class NotaTile extends StatelessWidget {
  final Nota nota;
  final Function(Nota) onEditar;
  final VoidCallback onEliminar;

  const NotaTile({
    Key? key,
    required this.nota,
    required this.onEditar,
    required this.onEliminar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(nota.titulo!),
      subtitle: Text(nota.descripcion!),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _editarNota(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onEliminar,
          ),
        ],
      ),
    );
  }

  void _editarNota(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ModalNota(
          nota: nota,
          onNotaGuardada: onEditar,
        );
      },
    );
  }
}
