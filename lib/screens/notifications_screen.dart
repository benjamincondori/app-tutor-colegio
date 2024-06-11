import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/bloc/notifications_bloc.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.select(
          (NotificationsBloc bloc ) => Text('${ bloc.state.status }')
        ),
        actions: [
          IconButton(onPressed: (){
            context.read<NotificationsBloc>()
              .requestPermission();
          }, 
          icon: const Icon( Icons.settings ))
        ],
      ),
      body: const _NotificationsView(),
    );
  }
}


class _NotificationsView extends StatelessWidget {
  const _NotificationsView();

  @override
  Widget build(BuildContext context) {

    final notifications = context.watch<NotificationsBloc>().state.notifications;

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (BuildContext context, int index) {
        final notification = notifications[index];
        return ListTile(
          title: Text( notification.title ),
          subtitle: Text( notification.body ),
          leading: notification.imageUrl != null 
            ? Image.network( notification.imageUrl! )
            : null,
          onTap: () {
            // context.push('/push-details/${ notification.messageId }');
            Navigator.of(context).pushNamed(
              'home/details',
              arguments: { 'pushMessageId': notification.messageId }
            );
          },
        );
      },
    );
  }
}