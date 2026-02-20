import 'package:evently/add_event/add_event_screen.dart';
import 'package:evently/home/widgets/categories_widget.dart';
import 'package:evently/home/widgets/event_widget.dart';
import 'package:evently/models/event_category_model.dart';
import 'package:evently/models/event_data_model.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:flutter/material.dart';
import '../core/gen/assets.gen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xffF4F7FF)),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Welcome Back ✨",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xff686868),
                  ),
                ),
                Text(
                  "Mohamed Gaber",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Color(0xff1C1C1C),
                  ),
                ),
                SizedBox(height: 24),

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
                    labelPadding: EdgeInsets.symmetric(horizontal: 8),
                    tabs: categories.map((data) {
                      return CategoriesWidget(
                        isSelected: currentIndex == categories.indexOf(data),
                        eventDataModel: data,
                      );
                    }).toList(),
                  ),
                ),
                 StreamBuilder(stream: FirebaseUtils.getStreamData(categories[currentIndex].id), builder:(context,snapshot){

                   if(snapshot.hasError){
                     return Text(snapshot.error.toString());
                   }
                   if(snapshot.connectionState == ConnectionState.waiting){
                     return Center(child: CircularProgressIndicator(),);
                   }
                   List <EventDataModel> dataList = snapshot.data!.docs.map((element){
                    return element.data();
                   }).toList();
                   return dataList.isEmpty ?
                   Center(child: Text("No Data Found"),)
                       :Expanded(
                     child: ListView.separated(
                       itemBuilder: (context, index) {
                         return EventWidget(dataModel: dataList[index],);
                       },
                       separatorBuilder: (context, index) => SizedBox(height: 16),
                       itemCount: dataList.length,
                     ),
                   );
                 })
              ],
            ),
          ),

          Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEventScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff0E3A99),
                minimumSize: Size(50, 50),
                shape: CircleBorder(),
              ),
              child: Icon(Icons.add, color: Color(0xffFFFFFF)),
            ),
          ),
        ],
      ),
    );
  }
}
