import 'package:flutter/material.dart';

class BottomNavigationView extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const BottomNavigationView(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  BottomNavigationBarItem bottomNavigationBarItem(
      String iconOff, String iconOn, String label) {
    return BottomNavigationBarItem(
      icon: SizedBox(
        width: 25,
        height: 25,
        child: Image.asset(iconOff),
      ),
      activeIcon: SizedBox(
        width: 25,
        height: 25,
        child: Image.asset(iconOn),
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    // final loadingProvider =
    //     Provider.of<LoadingProvider>(context, listen: false);

    void handleItemTap(int index) {
      onItemTapped(index);
      // loadingProvider.toggleLoading();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        final fontSize = screenWidth * 0.03;

        return BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: handleItemTap,
          selectedLabelStyle: TextStyle(fontSize: fontSize),
          unselectedLabelStyle: TextStyle(fontSize: fontSize),
          items: [
            bottomNavigationBarItem('assets/images/ic_tab_home_off.png',
                'assets/images/ic_tab_home_on.png', 'Home'),
            bottomNavigationBarItem('assets/images/ic_tab_history_off.png',
                'assets/images/ic_tab_history_on.png', 'Order History'),
            bottomNavigationBarItem('assets/images/ic_tab_inbox_off.png',
                'assets/images/ic_tab_inbox_on.png', 'Inbox'),
            bottomNavigationBarItem('assets/images/ic_tab_favourites_off.png',
                'assets/images/ic_tab_favourites_on.png', 'Favorites'),
            bottomNavigationBarItem('assets/images/ic_tab_profile_off.png',
                'assets/images/ic_tab_profile_on.png', 'Profile'),
          ],
        );
      },
    );
  }
}
