import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoe_store/features/home_page/home_page_footer.dart';
import 'package:shoe_store/features/home_page/home_page_header.dart';
import 'package:shoe_store/shared/extensions/build_context_extension.dart';
const appBarHeight = 60.0;
class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      backgroundColor: context.colors.shoebackground,
        body: const CustomScrollView(
          
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: appBarHeight,
                automaticallyImplyLeading: false,
                title: HomePageHeader(),
              ),
              SliverToBoxAdapter(
                child: HomePageFooter(),
              )
            ]));
  }
}
