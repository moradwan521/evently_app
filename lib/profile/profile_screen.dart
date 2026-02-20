import 'package:flutter/material.dart';

import '../add_event/add_event_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,

      decoration: BoxDecoration(color: Color(0xffF4F7FF)),
      child: Stack(
       alignment: Alignment.bottomRight,
        children: [
          Positioned(
            bottom: 16,
            right: 16,
            child:  ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEventScreen()),);
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
