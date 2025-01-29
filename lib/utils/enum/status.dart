enum Status {
  inProgress('in_progress'),
  done('done'),
  failed('failed'),
  undefined('_');

  final String value;

  const Status(this.value);

  static Status fromValue(String value) => switch (value) {
        'in_progress' => Status.inProgress,
        'done' => Status.done,
        'failed' => Status.failed,
        String() => Status.undefined,
      };
}
