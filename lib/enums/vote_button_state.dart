enum VoteButtonState {
  unSelected(medalSrc: null),
  selectFirst(medalSrc: 'assets/medal_1st.png'),
  selectSecond(medalSrc: 'assets/medal_2nd.png'),
  selectThird(medalSrc: 'assets/medal_3rd.png'),
  isFirst(medalSrc: 'assets/medal_1st.png'),
  isSecond(medalSrc: 'assets/medal_2nd.png'),
  isThird(medalSrc: 'assets/medal_3rd.png');

  final String? medalSrc;

  const VoteButtonState({required this.medalSrc});
}

extension VoteButtonStateExtension on VoteButtonState {
  bool get isUnSelected => this == VoteButtonState.unSelected;

  bool get isSelecting => this == VoteButtonState.selectFirst
      || this == VoteButtonState.selectSecond
      || this == VoteButtonState.selectThird;

  bool get isSelected => this == VoteButtonState.isFirst
      || this == VoteButtonState.isSecond
      || this == VoteButtonState.isThird;

  VoteButtonState get confirmSelect {
    if(this == VoteButtonState.selectFirst) return VoteButtonState.isFirst;
    if(this == VoteButtonState.selectSecond) return VoteButtonState.isSecond;
    if(this == VoteButtonState.selectThird) {
      return VoteButtonState.isThird;
    } else {
      throw Exception('cast error for confirmSelect');
    }
  }
}