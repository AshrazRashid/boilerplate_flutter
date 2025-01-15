import 'package:upgrader/upgrader.dart';

class UpgraderCustomMessages extends UpgraderMessages {
  /// Override the message function to provide custom language localization.
  @override
  String message(UpgraderMessage messageKey) {
    switch (messageKey) {
      case UpgraderMessage.body:
        return 'Please update the app for better experience. We have launched a new & improved version.';
      case UpgraderMessage.buttonTitleIgnore:
        return 'Ignore';
      case UpgraderMessage.buttonTitleLater:
        return 'Later';
      case UpgraderMessage.buttonTitleUpdate:
        return 'Update';
      case UpgraderMessage.prompt:
        return '';
      case UpgraderMessage.releaseNotes:
        return 'Release Notes';
      case UpgraderMessage.title:
        return 'Update Available';
      default:
        return super.message(messageKey) ?? "";
    }
  }
}
