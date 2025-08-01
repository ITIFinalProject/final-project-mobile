import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/events/event_cubit/event_cubit.dart';
import 'package:eventify_app/models.dart/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardEventUpcoming extends StatelessWidget {
  final EventModel event;

  const CardEventUpcoming({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var isIntersted = context.read<EventCubit>().isInterested(event.id);
    return SizedBox(
      width: size.width * 0.6,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: ThemeManager.secondaryColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child:
                  event.bannerUrl != null && event.bannerUrl!.isNotEmpty
                      ? Image.network(
                        event.bannerUrl ?? '',
                        width: size.width * 0.5,
                        height: size.height * 0.2,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;

                          return Center(
                            child: CircularProgressIndicator(
                              color: ThemeManager.primaryColor,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error, color: Colors.red);
                        },
                      )
                      : (event.templateIndex!=null)?Image.asset(
                        'assets/images/template${event.templateIndex}.jpg',
                        width: size.width * 0.5,
                        height: size.height * 0.2,
                        fit: BoxFit.cover,
                      ):Image.network('https://i.pinimg.com/1200x/2b/7f/a9/2b7fa911454725f7fd5b9d2f4dd41046.jpg',
                        width: size.width * 0.5,
                        height: size.height * 0.2,
                        fit: BoxFit.cover,
                      ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Text(
                          event.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 5,
                          children: [
                            Icon(Icons.access_time),
                            Text(
                              event.time.split('-')[0],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<EventCubit>().toggleInterestedEvent(event);
                  },
                  icon: Icon(
                    isIntersted?Icons.star:Icons.star_border_outlined,
                    color: isIntersted?Colors.amber:ThemeManager.primaryColor,
                    size: 35,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
