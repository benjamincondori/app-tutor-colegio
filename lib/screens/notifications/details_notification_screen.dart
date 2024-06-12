import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/push_message.dart';
import '../../services/bloc/notifications_bloc.dart';

class DetailsNotificationScreen extends StatelessWidget {
  final String? pushMessageId;
  final String? titulo;
  final String? mensaje;
  final String? fecha;
  final String? tipo;

  const DetailsNotificationScreen(
      {super.key,
      this.titulo,
      this.mensaje,
      this.fecha,
      this.pushMessageId,
      this.tipo});

  @override
  Widget build(BuildContext context) {
    final PushMessage? message =
        context.watch<NotificationsBloc>().getMessageById(pushMessageId ?? '');

    final tipoNotification =
        (message != null) ? message.data!['tipo'] : tipo ?? '';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Comunicado '),
            Text(
              '($tipoNotification)',
              style: TextStyle(fontSize: 14, color: Colors.grey[300]),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (message != null) ? message.title : titulo ?? '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Text(
              (message != null) ? message.body : mensaje ?? '',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 15),
            Text(
              (message != null) ? message.data!['fecha'] : fecha ?? '',
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}
