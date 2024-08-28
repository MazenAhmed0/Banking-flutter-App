class AppsModel {
  String iconPath;


  AppsModel({
    required this.iconPath
  });
  
  static List<AppsModel> getApps(){
    List<AppsModel> apps = [];

    apps.add(
      AppsModel(
        iconPath: 'assets/icons/pp(2).png'
        )
    );

    apps.add(
      AppsModel(
        iconPath: 'assets/icons/stripe(1).png'
        )
    );

    apps.add(
      AppsModel(
        iconPath: 'assets/icons/k(1).png'
        )
    );

      apps.add(
      AppsModel(
        iconPath: 'assets/icons/n23(1).png'
        )
    );

    return apps;
  }
}