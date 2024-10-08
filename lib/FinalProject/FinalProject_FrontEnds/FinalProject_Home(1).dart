import 'package:flutter/material.dart';
import 'package:second_application/Component/Project_DesignComponent.dart';
import 'package:second_application/Component/Project_HomeComponent.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navigation(showAddBoolBTN: true).AppBarWidget(context),
      drawer: navigation(showAddBoolBTN: true).drawerWidget(context),
      body: ProjectHomeComponent(),
    );
  }
}
