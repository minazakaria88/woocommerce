import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class ListTileMoreScreenWidget extends StatelessWidget {
  const ListTileMoreScreenWidget({
    super.key, required this.title, required this.onTap, required this.icon,
  });
  final String title;
  final Function onTap;
  final IconData icon ;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ListTile(
        onTap: () {
          onTap();
        },
        leading:  Icon(icon, color: AppColors.primaryColor),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios,
            color: AppColors.orange),
      ),
    );
  }
}