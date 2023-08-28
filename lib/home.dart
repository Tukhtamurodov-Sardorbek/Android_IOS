import 'package:call_platform_specific_code/components/home_widget.dart';
import 'package:call_platform_specific_code/components/message.dart';
import 'package:call_platform_specific_code/components/toast.dart';
import 'package:call_platform_specific_code/constants.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Call Platform Specific Code'),
      ),
      body: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: NativeToast()),
          SliverToBoxAdapter(child: MessageButtonView()),
          SliverToBoxAdapter(child: HomeWidgetButtonView()),
        ],
      ),
    );
  }
}
