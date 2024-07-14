class RecipeModel {
  late String appLabel;
  late String appImgUrl;
  late String appUrl;
  late double appCalories;

  RecipeModel(
      {this.appLabel = "",
      this.appCalories = 0.000,
      this.appImgUrl = "",
      this.appUrl = ""});
  factory RecipeModel.fromMap(Map recipe) {
    return RecipeModel(
        appLabel: recipe["label"],
        appCalories: recipe["calories"],
        appImgUrl: recipe["image"],
        appUrl: recipe["url"]);
  }
}
