import 'package:evently/event_details/edit_event_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/gen/assets.gen.dart';
import '../models/event_data_model.dart';
import '../utils/firebase_utils.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventDataModel event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF4F7FF),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xffFFFFFF),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_sharp,
                          color: Color(0xff0E3A99),
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Event details",
                      style: TextStyle(
                        color: Color(0xff1C1C1C),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditEventDetails(event: event),
                              ),
                            );
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xffFFFFFF),
                            ),
                            child: Assets.icons.edit.svg(width: 24, height: 24),
                          ),
                        ),
                        SizedBox(width: 8),
                        InkWell(
                          onTap: () async {
                            bool confirmed = await showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text("Delete Event"),
                                content: Text(
                                  "Are you sure you want to delete this event?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, false),
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, true),
                                    child: Text("Delete"),
                                  ),
                                ],
                              ),
                            );

                            if (confirmed) {
                              await FirebaseUtils.deleteEvent(event.eventId!);
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xffFFFFFF),
                            ),
                            child: Icon(Icons.delete, color: Color(0xffFF3232)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 195,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(
                        event.categoryImg,
                      ), // ممكن تغيّري حسب الصورة
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16),

                Text(
                  event.eventTitle,
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 76,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color(0xffFFFFFF),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xffF4F7FF),
                          ),
                          child: Icon(
                            Icons.calendar_month_outlined,
                            color: Color(0xff0E3A99),
                            size: 24,
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('d MMMM').format(event.eventDate),
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${event.eventDate.hour}:${event.eventDate.minute.toString().padLeft(2, '0')}",
                              style: TextStyle(
                                color: Color(0xffB9B9B9),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Description",
                  style: TextStyle(
                    color: Color(0xff1C1C1C),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color(0xffFFFFFF),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      event.eventDescription,
                      style: TextStyle(
                        color: Color(0xff1C1C1C),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
