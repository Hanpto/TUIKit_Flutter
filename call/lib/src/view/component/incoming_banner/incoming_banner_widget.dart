import 'package:flutter/material.dart';
import 'package:atomic_x_core/atomicxcore.dart';
import 'package:tencent_calls_uikit/src/manager/call_manager.dart';
import 'package:tencent_calls_uikit/src/manager/call_page_router.dart';
import 'package:tencent_calls_uikit/src/tui_call_kit_impl.dart';
import 'package:tuikit_atomic_x/base_component/localizations/atomic_localizations.dart';

class IncomingBannerWidget extends StatefulWidget {
  final VoidCallback? onShowCalling;
  final VoidCallback? onCloseAll;

  const IncomingBannerWidget({Key? key, this.onShowCalling, this.onCloseAll}) : super(key: key);

  @override
  State<IncomingBannerWidget> createState() => _IncomingBannerWidgetState();
}

class _IncomingBannerWidgetState extends State<IncomingBannerWidget> {
  CallInfo _activeCall = CallStore.shared.state.activeCall.value;

  String _inviterAvatarURL = '';
  String _inviterName = '';

  @override
  void initState() {
    super.initState();
    CallStore.shared.state.activeCall.addListener(_onActiveCallChanged);
    CallStore.shared.state.allParticipants.addListener(_onAllParticipantsChanged);
    _updateInviterInfo(CallStore.shared.state.allParticipants.value);
  }

  @override
  void dispose() {
    CallStore.shared.state.activeCall.removeListener(_onActiveCallChanged);
    CallStore.shared.state.allParticipants.removeListener(_onAllParticipantsChanged);
    super.dispose();
  }

  void _onActiveCallChanged() {
    final newValue = CallStore.shared.state.activeCall.value;
    if (newValue.callId.isEmpty) return;
    setState(() => _activeCall = newValue);
  }

  void _onAllParticipantsChanged() {
    _updateInviterInfo(CallStore.shared.state.allParticipants.value);
  }

  void _updateInviterInfo(List<CallParticipantInfo> participants) {
    final inviterId = CallStore.shared.state.activeCall.value.inviterId;
    for (var participant in participants) {
      if (participant.id == inviterId) {
        final name = participant.remark.isNotEmpty
            ? participant.remark
            : participant.name.isNotEmpty
                ? participant.name
                : participant.id;
        final avatar = participant.avatarURL;
        bool changed = false;
        if (name.isNotEmpty && name != _inviterName) {
          _inviterName = name;
          changed = true;
        }
        if (avatar.isNotEmpty && avatar != _inviterAvatarURL) {
          _inviterAvatarURL = avatar;
          changed = true;
        }
        if (changed) setState(() {});
        break;
      }
    }
  }

  Future<void> _onAccept() async {
    await CallManager.instance.accept();
    widget.onShowCalling?.call();
  }

  Future<void> _onReject() async {
    await CallManager.instance.reject();
    widget.onCloseAll?.call();
  }
  
  void _onTapBanner() {
    widget.onShowCalling?.call();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<EndedHintState?>(
      valueListenable: TUICallKitImpl.instance.pageRouter.endedHintState,
      builder: (context, ended, _) {
        if (ended == null && _activeCall.callId.isEmpty) {
          return const SizedBox.shrink();
        }
        return _buildBannerContent(context, ended);
      },
    );
  }

  Widget _buildBannerContent(BuildContext context, EndedHintState? ended) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: ended == null ? _onTapBanner : null,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(35, 38, 45, 1),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _getInviterAvatarWidget(),
              const SizedBox(width: 12),
              _getInviterInfoWidget(ended),
              const SizedBox(width: 12),
              if (ended == null) _getActionButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getInviterAvatarWidget() {
    return Container(
      width: 50,
      height: 50,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xFFEFEFEF),
      ),
      child: _inviterAvatarURL.isNotEmpty
          ? Image(
              image: NetworkImage(_inviterAvatarURL),
              fit: BoxFit.cover,
              errorBuilder: (ctx, err, stack) => Image.asset(
                'assets/images/user_icon.png',
                package: 'tencent_calls_uikit',
              ),
            )
          : Image.asset(
              'assets/images/user_icon.png',
              package: 'tencent_calls_uikit',
            ),
    );
  }

  Widget _getInviterInfoWidget(EndedHintState? ended) {
    var invitationInfo = '';
    if (ended != null) {
      invitationInfo = ended.text;
    } else {
      final l10n = AtomicLocalizations.of(context);
      if (_activeCall.inviteeIds.length >= 2) {
        invitationInfo = l10n.callInvitedToGroupCall;
      } else if (_activeCall.mediaType == CallMediaType.audio) {
        invitationInfo = l10n.callInvitedToAudioCall;
      } else if (_activeCall.mediaType == CallMediaType.video) {
        invitationInfo = l10n.callInvitedToVideoCall;
      }
    }

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _inviterName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            invitationInfo,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getActionButtonWidget() {
    return Row(
      children: [
        GestureDetector(
          onTap: _onReject,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
            ),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/hangup.png',
              package: 'tencent_calls_uikit',
              width: 36,
              height: 36,
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: _onAccept,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
            ),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/dialing.png',
              package: 'tencent_calls_uikit',
              width: 36,
              height: 36,
            ),
          ),
        ),
      ],
    );
  }
}
