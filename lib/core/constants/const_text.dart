class ConstText {
  String? title;
  String? subTitle;

  ConstText({this.title, this.subTitle});
}

final constContent = [
  ConstText(
    title:   "Title",
    subTitle: "Description",
  ),

];
final constTitle = ConstText(
  title: "Title",
  subTitle: "Description",
);

final constError = ConstText(
  title: "Error",
  subTitle: "An error occurred, please try again.",
);

final constSuccess = ConstText(
  title: "Success",
  subTitle: "Operation completed successfully.",
);

final constWarning = ConstText(
  title: "Warning",
  subTitle: "Please check your input and try again.",
);
