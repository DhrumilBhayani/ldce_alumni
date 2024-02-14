class LState {
  final int id;
  final String name;

  LState({required this.id, required this.name});
   @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LState && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}