import 'dart:async';

import 'package:tuikit_atomic_x/atomicx.dart';
import 'package:flutter/material.dart';
import 'package:tencent_calls_uikit/src/tui_call_kit_impl.dart';

import '../../core/common/call_colors.dart';
import '../../core/common/widget/slide_text_switcher.dart';

class _HintDisplayTracker {
  static String? _currentCallId;
  static bool _hadShowAcceptText = false;
  
  static bool shouldShowAcceptText(String callId) {
    if (_currentCallId != callId) {
      _currentCallId = callId;
      _hadShowAcceptText = false;
    }
    return !_hadShowAcceptText;
  }
  
  static void markAcceptTextShown(String callId) {
    if (_currentCallId == callId) {
      _hadShowAcceptText = true;
    }
  }
}

class HintWidget extends StatefulWidget {
  const HintWidget({super.key});

  @override
  State<StatefulWidget> createState() => _HintWidgetState();
}

class _HintWidgetState extends State<HintWidget> {
  final _acceptTextDisplayDuration = const Duration(seconds: 1);
  Timer? _acceptTextTimer;

  String _displayedText = '';
  Color _displayedColor = CallColors.colorG7;

  @override
  void initState() {
    super.initState();
    CallStore.shared.state.selfInfo.addListener(_onStateChanged);
    CallStore.shared.state.networkQualities.addListener(_onStateChanged);
    TUICallKitImpl.instance.pageRouter.endedHintState.addListener(_onStateChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolveAndUpdate();
  }

  @override
  void dispose() {
    CallStore.shared.state.selfInfo.removeListener(_onStateChanged);
    CallStore.shared.state.networkQualities.removeListener(_onStateChanged);
    TUICallKitImpl.instance.pageRouter.endedHintState.removeListener(_onStateChanged);
    _acceptTextTimer?.cancel();
    super.dispose();
  }

  void _onStateChanged() {
    _resolveAndUpdate();
  }

  void _resolveAndUpdate() {
    if (!mounted) return;
    final l10n = AtomicLocalizations.of(context);
    final ended = TUICallKitImpl.instance.pageRouter.endedHintState.value;
    final selfInfo = CallStore.shared.state.selfInfo.value;
    final networkQualities = CallStore.shared.state.networkQualities.value;

    final hintData = ended != null
        ? _HintData(ended.text, _getHintTextColor())
        : _resolveHintData(l10n, selfInfo, networkQualities);

    if (hintData.text != _displayedText || hintData.color != _displayedColor) {
      setState(() {
        _displayedText = hintData.text;
        _displayedColor = hintData.color;
      });
    }
  }

  _HintData _resolveHintData(AtomicLocalizations l10n,
      CallParticipantInfo selfInfo, Map<String, NetworkQuality> networkQualities) {
    final connectionText = _getConnectionHintText(selfInfo, l10n);
    if (connectionText != null) {
      return _HintData(connectionText, CallColors.colorG7);
    }

    final statusText = _getStatusHintText(selfInfo, l10n);
    if (statusText != null) {
      return _HintData(statusText, _getHintTextColor());
    }

    final networkText = _getNetworkQualityHintText(selfInfo, networkQualities, l10n);
    if (networkText.isNotEmpty) {
      return _HintData(networkText, _getHintTextColor());
    }

    return _HintData('', _getHintTextColor());
  }

  @override
  Widget build(BuildContext context) {
    if (_displayedText.isEmpty) {
      return const SizedBox.shrink();
    }

    return SlideTextSwitcher(
      text: _displayedText,
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.normal,
        color: _displayedColor,
      ),
    );
  }

  String? _getConnectionHintText(CallParticipantInfo selfInfo, AtomicLocalizations l10n) {
    final activeCall = CallStore.shared.state.activeCall.value;
    final callId = activeCall.callId;

    if (selfInfo.status != CallParticipantStatus.accept ||
        !_HintDisplayTracker.shouldShowAcceptText(callId)) {
      return null;
    }

    if (_acceptTextTimer?.isActive == true) {
      return l10n.callConnected;
    }

    _acceptTextTimer = Timer(_acceptTextDisplayDuration, () {
      if (mounted) {
        _HintDisplayTracker.markAcceptTextShown(callId);
        _resolveAndUpdate();
      }
    });

    return l10n.callConnected;
  }

  String? _getStatusHintText(CallParticipantInfo selfInfo, AtomicLocalizations l10n) {
    if (selfInfo.status != CallParticipantStatus.waiting) {
      return null;
    }

    final activeCall = CallStore.shared.state.activeCall.value;

    if (selfInfo.id == activeCall.inviterId) {
      return l10n.callWaitingForInvitationAcceptance;
    } else {
      return activeCall.mediaType == CallMediaType.audio
          ? l10n.callInvitedToAudioCall
          : l10n.callInvitedToVideoCall;
    }
  }

  String _getNetworkQualityHintText(
      CallParticipantInfo selfInfo,
      Map<String, NetworkQuality> networkQualities,
      AtomicLocalizations l10n,
      ) {
    final selfNetwork = networkQualities[selfInfo.id];
    if (selfNetwork != null && _isBadNetwork(selfNetwork)) {
      return l10n.callSelfNetworkLowQuality;
    }

    for (var entry in networkQualities.entries) {
      if (entry.key != selfInfo.id && _isBadNetwork(entry.value)) {
        return l10n.callOtherPartyNetworkLowQuality;
      }
    }

    return '';
  }

  bool _isBadNetwork(NetworkQuality? network) {
    return network == NetworkQuality.bad ||
        network == NetworkQuality.veryBad ||
        network == NetworkQuality.down;
  }

  Color _getHintTextColor() {
    if (CallStore.shared.state.activeCall.value.mediaType == CallMediaType.video) {
      return CallColors.colorWhite;
    }
    return CallColors.colorG7;
  }
}

class _HintData {
  final String text;
  final Color color;
  const _HintData(this.text, this.color);
}
