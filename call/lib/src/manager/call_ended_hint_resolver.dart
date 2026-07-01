import 'package:tuikit_atomic_x/atomicx.dart';

class CallEndedHintResolver {
  static String? resolveText(
    CallEndReason reason,
    AtomicLocalizations l10n,
  ) {
    switch (reason) {
      case CallEndReason.hangup:
        return l10n.callOtherPartyHungUp;
      case CallEndReason.reject:
        return l10n.callOtherPartyDeclinedCallRequest;
      case CallEndReason.noResponse:
        return l10n.callOtherPartyNoResponse;
      case CallEndReason.canceled:
        return l10n.callOtherPartyCanceled;
      default:
        return null;
    }
  }
}
