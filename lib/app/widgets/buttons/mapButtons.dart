import 'package:flutter/material.dart';
import 'package:skycraft/app/constants/theme_data.dart';

class MapTabView extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final List<String> tabs;
  const MapTabView({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          tabs.length,
          (index) => InkWell(
            onTap: () {
              onItemTapped(index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: selectedIndex == index ? kPrimaryColor : null,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  color: selectedIndex == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
