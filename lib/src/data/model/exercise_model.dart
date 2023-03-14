import 'package:equatable/equatable.dart';

class Exercises extends Equatable {
  final String? title;
  final int? prelude;
  final int? duration;
  final int? index;
  final int? startTime;
  const Exercises({
    required this.title,
    required this.prelude,
    required this.duration,
    this.index,
    this.startTime,
  });

  factory Exercises.fromJson(
      Map<String, dynamic> json, int index, int startTime) {
    return Exercises(
      title: json['title'],
      prelude: json['prelude'],
      duration: json['duration'],
      startTime: startTime,
      index: index,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'prelude': prelude,
      'duration': duration,
    };
  }

  Exercises copyWith({
    String? title,
    int? prelude,
    int? duration,
    int? index,
    int? startTime,
  }) =>
      Exercises(
        title: title ?? this.title,
        prelude: prelude ?? this.prelude,
        duration: duration ?? this.duration,
        index: index ?? this.index,
        startTime: startTime ?? this.startTime,
      );
  @override
  List<Object?> get props => [title, prelude, duration, index, startTime];
}
