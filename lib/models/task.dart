import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:rush/constants/colors.dart';

final String taskTable = "tasks";

class TaskFields {
  static final List<String> values = [title, icon, color, toDos];

  static final String title = "title";
  static final String icon = "icon";
  static final String color = "color";
  static final String toDos = "todos";
}

class Task extends Equatable {
  // final String id;
  final String title;
  final int icon;
  final String color;
  final List<dynamic>? toDos;
  Task({
    required this.title,
    required this.icon,
    required this.color,
    this.toDos,
    // required this.id
  });

  Task copyWith({
    String? id,
    String? title,
    int? icon,
    String? color,
    List<dynamic>? toDos,
  }) {
    return Task(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      toDos: toDos ?? this.toDos,
      // id: id ?? this.id,
    );
  }

// Converting tasks to json to send them to firebase server **OLDER
  Map<String, dynamic> toJson() => {
        'title': title, 'icon': icon, 'color': color, 'toDos': toDos,
        //  'id': id
      };

//  To get back our DATATYPE OF TASK from JSON TO TAST TYPE
  factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: json['title'],
        icon: json['icon'],
        color: json['color'],
        toDos: json['toDos'],
        // id: json['id']
      );

  @override
  // TODO: implement props
  List<Object?> get props => [title, icon, color];
  // this will compare different tasks according to their title icon and color

  //given by user if not (=>) after this says default one in const will be used  **OLDER WITHOUT ID
  //instance/variables are final and cant be changed so user will use this function to access them
  // Task copyWith({
  //   String? title,
  //   int? icon,
  //   String? color,
  //   List<dynamic>? toDos,
  // }) =>
  //     Task(
  //         title: title ?? this.title,
  //         icon: icon ?? this.icon,
  //         color: color ?? this.color,
  //         toDos: toDos ?? this.toDos);
}
