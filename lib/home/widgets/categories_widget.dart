import 'package:evently/models/event_category_model.dart';
import 'package:flutter/cupertino.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,

    required this.eventDataModel,
    required this.isSelected,
  });

  final bool isSelected;
  final EventCategoryModel eventDataModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isSelected ? Color(0xff0E3A99) : Color(0xffFFFFFF),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                eventDataModel.icon,
                color: isSelected ?  Color(0xffFFFFFF) : Color(0xff0E3A99) ,
              ),
              SizedBox(width: 5),
              Text(
                eventDataModel.name,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isSelected ?  Color(0xffFFFFFF) : Color(0xff1C1C1C) ,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
