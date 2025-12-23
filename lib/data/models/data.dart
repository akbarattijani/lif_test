class Data {
    final int? id;
    final String uid;
    final String title;
    final String description;
    bool isCompleted;

    Data({
        this.id,
        required this.uid,
        required this.title,
        required this.description,
        this.isCompleted = false,
    });

    Data copyWith({
        int? id,
        String? uid,
        String? title,
        String? description,
        bool? isCompleted,
    }) {
        return Data(
            id: id ?? this.id,
            uid: uid ?? this.uid,
            title: title ?? this.title,
            description: description ?? this.description,
            isCompleted: isCompleted ?? this.isCompleted,
        );
    }

    Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'title': title,
        'description': description,
        'isCompleted': isCompleted ? 1 : 0,
    };

    static Data fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        uid: json['uid'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        isCompleted: json['isCompleted'] == 1,
    );
}