import 'package:flutter/material.dart';
import '../add_event/add_event_screen.dart';
import '../home/widgets/event_widget.dart';
import '../models/event_data_model.dart';
import '../utils/firebase_utils.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
            Padding( padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(),),

                StreamBuilder(
                  stream: FirebaseUtils.getStreamFavoriteData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    List<EventDataModel> dataList = snapshot.data!.docs.map((
                      element,
                    ) {
                      return element.data();
                    }).toList();
                    return dataList.isEmpty
                        ? Center(child: Text("No Data Found"))
                        : Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return EventWidget(dataModel: dataList[index]);
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 16),
                              itemCount: dataList.length,
                            ),
                          );
                  },
                ),
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
