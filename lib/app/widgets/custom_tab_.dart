import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skycraft/app/constants/theme_data.dart';

class CustomTabBar extends StatefulWidget {
  final List<String> icons;
  const CustomTabBar(
      {super.key, required this.onTabChange, required this.icons});

  final Function(int tabIndex) onTabChange;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int _selectedTab = 0;

  void onTabPress(int index) {
    if (_selectedTab != index) {
      setState(() {
        _selectedTab = index;
      });
      widget.onTabChange(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60,
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 8),
        padding: const EdgeInsets.all(1),
        constraints: const BoxConstraints(maxWidth: 768),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(colors: [
            Colors.white.withOpacity(0.5),
            Colors.white.withOpacity(0)
          ]),
        ),
        child: Container(
          // Clip to avoid the tab touch outside the border radius area
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: kPrimaryColor.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 20),
              )
            ],
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                  widget.icons.length,
                  (index) => GestureDetector(
                        onTap: () => onTabPress(index),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.transparent,
                          child: Image.asset(
                            widget.icons[index],
                            width: 24,
                            height: 24,
                            color: _selectedTab == index
                                ? kBackgroundColor
                                : kBackgroundColor.withOpacity(0.6),
                          ),
                        ),
                      ))),
        ),
      ),
    );
  }
}
