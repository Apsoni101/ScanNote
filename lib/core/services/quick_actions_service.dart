import 'package:quick_actions/quick_actions.dart';

class QuickActionsService {
  final QuickActions _quickActions = const QuickActions();

  void initialize({
    required final List<ShortcutItem> shortcutItems,
    required final void Function(String type) onAction,
  }) {
    _quickActions
      ..initialize(onAction)
      ..setShortcutItems(shortcutItems);
  }
}
