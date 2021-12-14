extension StringNullOrEmpty on String {
  bool get isNullOrEmpty => this.isEmpty ?? true;
}
