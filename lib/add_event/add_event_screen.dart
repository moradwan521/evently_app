import 'package:evently/home/home_screen.dart';
import 'package:evently/models/event_data_model.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/gen/assets.gen.dart';
import '../home/widgets/categories_widget.dart';
import '../models/event_category_model.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  List<EventCategoryModel> categories = [
    EventCategoryModel(
      id: "sport",
      name: "Sport",
      image: Assets.images.sport.path,
      icon: Icons.directions_bike_rounded,
    ),
    EventCategoryModel(
      id: "birthday",
      name: "Birthday",
      image: Assets.images.birthday.path,
      icon: Icons.cake_outlined,
    ),
    EventCategoryModel(
      id: "book_club",
      name: "Book Club",
      image: Assets.images.bookClub.path,
      icon: Icons.chrome_reader_mode_rounded,
    ),
    EventCategoryModel(
      id: "meeting",
      name: "Meeting",
      image: Assets.images.meeting.path,
      icon: Icons.meeting_room_outlined,
    ),
  ];

  int currentIndex = 0;
  DateTime? selectedDate;

  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF4F7FF),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
                key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(builder: (context) => HomeScreen()),
                          );
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
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Add event",
                          style: TextStyle(
                            color: Color(0xff1C1C1C),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
                        image: AssetImage(categories[currentIndex].image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  DefaultTabController(
                    length: categories.length,
                    child: TabBar(
                      onTap: (index) {
                        currentIndex = index;
                        setState(() {});
                      },
                      isScrollable: true,
                      dividerColor: Color(0xffF4F7FF),
                      indicator: BoxDecoration(),
                      tabAlignment: TabAlignment.start,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                      tabs: categories.map((data) {
                        return CategoriesWidget(
                          isSelected: currentIndex == categories.indexOf(data),
                          eventDataModel: data,
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Title",
                    style: TextStyle(
                      color: Color(0xff1C1C1C),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter event title";
                      }
                      if (value.length < 3) {
                        return "Title must be at least 3 characters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Event Title",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  Text(
                    "Description",
                    style: TextStyle(
                      color: Color(0xff1C1C1C),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: descController,
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter event description";
                      }
                      if (value.length < 10) {
                        return "Description must be at least 10 characters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Event Description....",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: Color(0xff0E3A99),
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Event Date",
                        style: TextStyle(
                          color: Color(0xff1C1C1C),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          date();
                        },
                        child: Text(
                          selectedDate != null
                              ? (DateFormat('dd.MMM.yyyy').format(selectedDate!))
                              : "Choose date",
                          style: TextStyle(
                            color: Color(0xff0E3A99),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xff0E3A99),
                            decorationThickness: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (selectedDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please choose a date")),
                          );
                          return;
                        }
                        EventDataModel data = EventDataModel(eventTitle: titleController.text,
                            eventDescription:descController.text ,
                            eventDate:selectedDate!,
                            eventCategoryId: categories[currentIndex].id,
                            categoryImg: categories[currentIndex].image);
                        FirebaseUtils.addEvent(data);
                      }

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff0E3A99),
                      minimumSize: Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      "Add event",
                      style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void date() async {
    var currentDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    selectedDate = currentDate;
    setState((){});
  }
}
