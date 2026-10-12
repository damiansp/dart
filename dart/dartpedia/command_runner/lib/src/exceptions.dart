class ArgumentException extends FormatException {
  /// The command that was parsed before discovering the exception
  ///
  /// This will be empty if the exception was on the root parser
  final String? command;
  /// Name of the arg that was being parsed when exception discovered
  final String? argumentName;

  ArgumentException(
    super.message,
    [this.command, this.argumentName, super.source, super.offset,]
  );

  @override
  String toString() { return 'ArgumentException $message'; }
}
