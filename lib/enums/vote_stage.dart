enum VoteStage {
  first(description: 'Select your First Player!'),
  second(description: 'Select your Second Player!'),
  third(description: 'Select your Third Player!');

  final String description;

  const VoteStage({
    required this.description,
  });
}

extension VoteStageExtension on VoteStage {
  VoteStage get next => this == VoteStage.first
      ? VoteStage.second : VoteStage.third;
}