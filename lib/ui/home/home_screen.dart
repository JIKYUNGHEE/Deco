import 'package:deco/ui/home/widgets/components/next_date_card.dart';
import 'package:deco/ui/home/widgets/sections/home_summary_section.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            HomeSummarySection(),
            SizedBox(height: 78,),
            NextDateCard(),
          ],
        ),
      ),
    );
  }
}
