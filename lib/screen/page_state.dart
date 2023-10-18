/// 화면 상태
enum PageState {
  /// 시작
  start,
  /// 전화번호 입력
  enterPhoneNumber,
  /// 인증번호 입력
  enterVerificationCode,
  /// voteId 표시
  showingVoteId,
  /// 인증 실패
  failIdentification,

  /// 투표
  vote,
  /// 내 선택지 확인
  confirmVote,

  /// 유저 선택지 전송 및 결과 확인
  requestVote,

  /// 내 선택지를 보여줌 (이미 투표한 유저인 경우)
  myVote,

  /// 투표 전체 결과를 보여줌 (투표 마감인 경우)
  voteResult,
}