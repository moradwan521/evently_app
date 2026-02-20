import 'package:evently/event_details/event_details_screen.dart';
import 'package:evently/models/event_data_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/gen/assets.gen.dart';
import '../../utils/firebase_utils.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({super.key, required this.dataModel});
  final EventDataModel dataModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 195,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xffFFFFFF),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetailsScreen(event: dataModel),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(dataModel.categoryImg),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 66,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffF4F7FF),
                  ),
                  child: Center(
                    child: Text(
                      DateFormat('dd MMM').format(dataModel.eventDate),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xff0E3A99),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffF4F7FF),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dataModel.eventTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xff1C1C1C),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            bool newFavorite = !dataModel.isFavorite;
                            await FirebaseUtils.updateEvent(
                              EventDataModel(
                                eventId: dataModel.eventId,
                                eventTitle: dataModel.eventTitle,
                                eventDescription: dataModel.eventDescription,
                                eventDate: dataModel.eventDate,
                                eventCategoryId: dataModel.eventCategoryId,
                                categoryImg: dataModel.categoryImg,
                                isFavorite: newFavorite,
                              ),
                            );

                            dataModel.isFavorite = newFavorite;
                            (context as Element).markNeedsBuild();
                          },
                          child: dataModel.isFavorite
                              ? Assets.icons.heartBlack.svg()
                              : Assets.icons.heart.svg(),
                        ),

                      ],
                    ),
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
