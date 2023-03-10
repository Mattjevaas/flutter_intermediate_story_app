class StoryRequestModel {
  final int? page;
  final int? size;
  final int location = 0;

  const StoryRequestModel({
    this.page,
    this.size,
  });

  Map<String, dynamic> toJson() => {
        'page': page,
        'size': size,
      };
}
