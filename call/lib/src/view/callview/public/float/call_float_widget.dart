import 'package:atomic_x_core/atomicxcore.dart';
import 'package:flutter/material.dart';

import 'package:tuikit_atomic_x/ai/ai_transcriber.dart';
import 'package:tencent_calls_uikit/src/manager/call_page_router.dart';
import 'package:tencent_calls_uikit/src/tui_call_kit_impl.dart';
import '../../core/common/call_colors.dart';
import '../../core/common/constants.dart';
import '../transcriber/ai_subtitle.dart';
import '../controls/single_call_controls_widget.dart';
import '../hint/hint_widget.dart';
import '../hint/timer_widget.dart';

class CallFloatWidget extends StatefulWidget {
  final CallCoreController controller;
  final bool enableAITranscriber;

  const CallFloatWidget({
    super.key,
    required this.controller,
    this.enableAITranscriber = false,
  });

  @override
  State<StatefulWidget> createState() => _CallFloatWidgetState();
}

class _CallFloatWidgetState extends State<CallFloatWidget> {
  final GlobalKey _controlsKey = GlobalKey();
  double _controlsHeight = 120;

  CallParticipantInfo _selfInfo = CallStore.shared.state.selfInfo.value;
  CallInfo _activeCall = CallStore.shared.state.activeCall.value;

  String _remoteAvatarURL = '';
  String _remoteDisplayName = '';

  @override
  void initState() {
    super.initState();
    CallStore.shared.state.selfInfo.addListener(_onSelfInfoChanged);
    CallStore.shared.state.activeCall.addListener(_onActiveCallChanged);
    CallStore.shared.state.allParticipants.addListener(_onAllParticipantsChanged);
    _updateRemoteUserInfo(CallStore.shared.state.allParticipants.value);
  }

  @override
  void dispose() {
    CallStore.shared.state.selfInfo.removeListener(_onSelfInfoChanged);
    CallStore.shared.state.activeCall.removeListener(_onActiveCallChanged);
    CallStore.shared.state.allParticipants.removeListener(_onAllParticipantsChanged);
    super.dispose();
  }

  void _onSelfInfoChanged() {
    final newValue = CallStore.shared.state.selfInfo.value;
    if (newValue.status == CallParticipantStatus.none) return;
    setState(() => _selfInfo = newValue);
  }

  void _onActiveCallChanged() {
    final newValue = CallStore.shared.state.activeCall.value;
    if (newValue.callId.isEmpty) return;
    setState(() => _activeCall = newValue);
  }

  void _onAllParticipantsChanged() {
    final participants = CallStore.shared.state.allParticipants.value;
    _updateRemoteUserInfo(participants);
  }

  void _updateRemoteUserInfo(List<CallParticipantInfo> participants) {
    for (var participant in participants) {
      if (participant.id != _selfInfo.id) {
        final avatarURL = participant.avatarURL;
        final displayName = _getUserDisplayName(participant);
        bool changed = false;
        if (avatarURL.isNotEmpty && avatarURL != _remoteAvatarURL) {
          _remoteAvatarURL = avatarURL;
          changed = true;
        }
        if (displayName.isNotEmpty && displayName != _remoteDisplayName) {
          _remoteDisplayName = displayName;
          changed = true;
        }
        if (changed) setState(() {});
        break;
      }
    }
  }

  void _measureControlsHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox = _controlsKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null && mounted) {
        final height = renderBox.size.height;
        if (height != _controlsHeight) {
          setState(() {
            _controlsHeight = height;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _measureControlsHeight();
    return Stack(
      children: [
        CallCoreView(
          controller: widget.controller,
          defaultAvatar: Constants.defaultAvatarImage,
        ),
        _buildUserInfoWidget(context, _selfInfo, _activeCall),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.55,
          left: 0,
          right: 0,
          child: const Center(child: HintWidget()),
        ),
        _buildAISubtitle(context, _selfInfo),
        _buildAITranscriberPanel(context, _selfInfo),
        Positioned(
          right: 0,
          left: 0,
          bottom: 40 + MediaQuery.of(context).padding.bottom,
          child: SingleCallControlsWidget(key: _controlsKey),
        ),
        _getTimerWidget(),
        _buildAITranscriberBtnWidget(_selfInfo),
      ],
    );
  }

  Widget _buildAISubtitle(BuildContext context, CallParticipantInfo self) {
    return ValueListenableBuilder<EndedHintState?>(
      valueListenable: TUICallKitImpl.instance.pageRouter.endedHintState,
      builder: (context, ended, _) {
        if (ended != null) return const SizedBox.shrink();
        return Positioned(
          left: 0,
          right: 0,
          bottom: 40 + _controlsHeight + 8 + MediaQuery.of(context).padding.bottom,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.9,
              maxHeight: MediaQuery.of(context).size.height * 0.3,
            ),
            child: AISubtitle(userId: self.id),
          ),
        );
      },
    );
  }

  Widget _buildAITranscriberPanel(BuildContext context, CallParticipantInfo self) {
    if (!widget.enableAITranscriber || self.status != CallParticipantStatus.accept) {
      return const SizedBox.shrink();
    }
    return ValueListenableBuilder<EndedHintState?>(
      valueListenable: TUICallKitImpl.instance.pageRouter.endedHintState,
      builder: (context, ended, _) {
        if (ended != null) return const SizedBox.shrink();
        return AITranscriberPanel(
          bottomOffset: _controlsHeight + 48 + MediaQuery.of(context).padding.bottom,
          animationDuration: Duration.zero,
        );
      },
    );
  }

  Widget _buildUserInfoWidget(
    BuildContext context,
    CallParticipantInfo self,
    CallInfo activeCall,
  ) {
    if (activeCall.mediaType != CallMediaType.video
        || self.status != CallParticipantStatus.waiting) {
      return Container();
    }
    return Positioned(
      top: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Image(
              image: NetworkImage(
                _remoteAvatarURL.isNotEmpty ? _remoteAvatarURL : Constants.defaultAvatar,
              ),
              fit: BoxFit.cover,
              errorBuilder: (ctx, err, stackTrace) => Image.asset(
                'call_assets/user_icon.png',
                package: 'tuikit_atomic_x',
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _remoteDisplayName,
            textScaler: TextScaler.noScaling,
            style: TextStyle(
              fontSize: 18,
              color: _getUserNameColor(activeCall),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTimerWidget() {
    return Positioned(
      top: 20,
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: const Center(
        child: TimerWidget(),
      ),
    );
  }

  String _getUserDisplayName(CallParticipantInfo info) {
    if (info.remark.isNotEmpty) {
      return info.remark;
    } else if (info.name.isNotEmpty) {
      return info.name;
    } else {
      return info.id;
    }
  }

  Color _getUserNameColor(CallInfo activeCall) {
    return activeCall.mediaType == CallMediaType.audio
        ? CallColors.colorG7
        : CallColors.colorWhite;
  }

  Widget _buildAITranscriberBtnWidget(CallParticipantInfo self) {
    if (self.status != CallParticipantStatus.accept || !widget.enableAITranscriber) {
      return const SizedBox();
    }
    return const Positioned(
      left: 52,
      top: 52,
      width: 40,
      height: 40,
      child: AITranscriberButton(),
    );
  }
}