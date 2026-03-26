import 'dart:ui';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  Future<void> _onTap(BuildContext context, int index) async {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;
    final selectedColor = Theme.of(context).colorScheme.primary;
    final unselectedColor = Theme.of(
      context,
    ).colorScheme.onSurface.withValues(alpha: 0.6);

    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.75),
              border: Border(
                top: BorderSide(
                  color: Colors.white.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) => _onTap(context, index),
              elevation: 0,
              backgroundColor: Colors.transparent,
              items: [
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      currentIndex == 0 ? selectedColor : unselectedColor,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      'assets/images/home/wallet.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  label: 'Carteira',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.qr_code_scanner,
                    color: currentIndex == 1 ? selectedColor : unselectedColor,
                    size: 24,
                  ),
                  label: 'Scan',
                ),
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      currentIndex == 2 ? selectedColor : unselectedColor,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      'assets/images/home/menu.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  label: 'Opções',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
