import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_assistant_ia/core/constants/app_colors.dart';
import 'package:mobile_assistant_ia/core/di/injection.dart';
import 'package:mobile_assistant_ia/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:mobile_assistant_ia/features/agenda/presentation/bloc/agenda_bloc.dart';

class AppShell extends StatefulWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  final List<String> _routes = ['/chat', '/agenda', '/profile'];

  void _onTabTapped(int index) {
    if (_currentIndex == index) return;
    setState(() => _currentIndex = index);
    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatBloc>(create: (_) => getIt<ChatBloc>()),
        BlocProvider<AgendaBloc>(create: (_) => getIt<AgendaBloc>()),
      ],
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar: _InovBottomNav(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
        ),
      ),
    );
  }
}

class _InovBottomNav extends StatelessWidget {
  const _InovBottomNav({
    required this.currentIndex,
    required this.onTap,
    this.chatBadgeCount = 3,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final int chatBadgeCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                index: 0,
                currentIndex: currentIndex,
                onTap: onTap,
                icon: Icons.chat_bubble_outline_rounded,
                activeIcon: Icons.chat_bubble_outline_rounded,
                label: 'Chat',
                // badge seulement si onglet inactif
                badgeCount: currentIndex != 0 ? chatBadgeCount : 0,
              ),
              _NavItem(
                index: 1,
                currentIndex: currentIndex,
                onTap: onTap,
                icon: Icons.calendar_today_outlined,
                activeIcon: Icons.calendar_today_rounded,
                label: 'Agenda',
              ),
              _NavItem(
                index: 2,
                currentIndex: currentIndex,
                onTap: onTap,
                icon: Icons.person_outline_rounded,
                activeIcon: Icons.person_outline_rounded,
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.index,
    required this.currentIndex,
    required this.onTap,
    required this.icon,
    required this.activeIcon,
    required this.label,
    this.badgeCount = 0,
  });

  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int badgeCount;

  bool get isActive => index == currentIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icône — fond noir pill + shadow bleue si actif
          Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                width: 48,
                height: 34,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.navActive : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: Icon(
                  isActive ? activeIcon : icon,
                  size: 22,
                  // icône active en bleu ciel, inactive en gris
                  color: isActive
                      ? const Color(0xFF60A5FA) // bleu ciel
                      : AppColors.navInactive,
                ),
              ),

              // Badge — uniquement si inactif
              if (badgeCount > 0)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        badgeCount > 9 ? '9+' : '$badgeCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 4),

          // Label
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive ? AppColors.navActive : AppColors.navInactive,
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}