import 'package:flutter/material.dart';

IconData getIconForScene(String sceneName) {
  final name = sceneName.toUpperCase();
  if (name.contains('CAM') || name.contains('PERSON')) {
    return Icons.person;
  }
  if (name.contains('GAME') || name.contains('PLAY') || name.contains('DESKTOP') || name.contains('SCREEN')) {
    return Icons.desktop_windows;
  }
  if (name.contains('CHAT') || name.contains('INTERMISSION') || name.contains('TALK')) {
    return Icons.chat;
  }
  if (name.contains('GUEST') || name.contains('GROUP') || name.contains('SPLIT') || name.contains('COLLAB')) {
    return Icons.group;
  }
  if (name.contains('BRB') || name.contains('RIGHT') || name.contains('BACK') || name.contains('OFF') || name.contains('PAUSE')) {
    return Icons.videocam_off;
  }
  if (name.contains('SOON') || name.contains('START') || name.contains('GRID') || name.contains('INTRO')) {
    return Icons.grid_view;
  }
  if (name.contains('END') || name.contains('OUTRO')) {
    return Icons.power_settings_new;
  }
  if (name.contains('STREAM')) {
    return Icons.desktop_mac;
  }
  if (name.contains('IPAD')) {
    return Icons.tablet_mac;
  }
  if (name.contains('IDE')) {
    return Icons.screen_search_desktop;
  }
  if (name.contains('APPLICATION')) {
    return Icons.apps;
  }
  // Fallback
  return Icons.layers;
}
