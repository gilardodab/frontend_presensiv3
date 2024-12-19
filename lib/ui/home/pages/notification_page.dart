import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../bloc/notification/notification_bloc.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    context.read<NotificationBloc>().add(const NotificationEvent.getNotif());
    super.initState();
  }

  String formattedLastSendNotification(DateTime datetime) {
    Duration difference = DateTime.now().difference(datetime);
    if (difference.inDays > 30) {
      return datetime.toFormattedDate();
    } else if (difference.inDays > 0) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'hari'} lalu';
    } else if (difference.inHours > 0) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'jam'} lalu';
    } else if (difference.inMinutes > 0) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'menit'} lalu';
    } else {
      return 'Sekarang';
    }
  }

  // Fungsi untuk memformat body agar ditampilkan dengan 30 karakter per baris
  String formatBody(String body) {
    const int maxLength = 45;
    if (body.length > maxLength) {
      return body.substring(0, maxLength) + '\n' + body.substring(maxLength);
    } else {
      return body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 114, 76, 175),
        title: const Text(
          'Notifikasi', 
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            color:  Colors.white,
            fontSize: 12
            ), 
            textAlign: TextAlign.center
          ),
          leading:  IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => context.pop(),
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Spacer(),
                    Assets.images.notification.image(width: 183.0),
                    const SpaceHeight(60.0),
                    const Text(
                      'Belum ada Notifikasi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SpaceHeight(20.0),
                    const Text(
                      'Jika Anda mendapat notifikasi dari aktivitas Anda, notifikasi tersebut akan muncul di sini.',
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    Button.filled(
                      onPressed: () => context.pop(),
                      label: 'Back Home',
                    ),
                  ],
                );
              },
              error: (body) {
                return Center(
                  child: Text(body),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              loaded: (notifications) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final item = notifications.notifications![index];
                    return Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title!,
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: AppColors.black,
                              ),
                            ),
                            const SpaceHeight(4.0),
                            Text(
                              formatBody(item.body!), // Menggunakan fungsi formatBody
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          formattedLastSendNotification(
                              item.createdAt!),
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    color: AppColors.stroke,
                    height: 24.0,
                  ),
                  itemCount: notifications.notifications!.length,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
