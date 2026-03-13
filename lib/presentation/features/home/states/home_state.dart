class HomeState {
  final bool isLoading;
  final String? errorMessage;

  HomeState({
    required this.isLoading,
    this.errorMessage,
  });

  factory HomeState.initial() {
    return HomeState(
      isLoading: false,
      errorMessage: null,
    );
  }

  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
