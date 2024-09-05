class TransModel {
  String name;
  String date;
  String money;

  TransModel({
    required this.name,
    required this.date,
    required this.money,
  });
  
  static List<TransModel> getTrans(){
    List<TransModel> trans = [];

    trans.add(
      TransModel(
        name: 'Shoping',
        date: 'Tue 12.05.2021', 
        money: "29.90"
        )
    );

    trans.add(
      TransModel(
        name: 'Movie Ticket',
        date: 'Mon 11.05.2021', 
        money: "9.50"
        )
    );
        trans.add(
      TransModel(
        name: 'Amazon',
        date: 'Mon 11.05.2021', 
        money: "19.30"
        )
    );
        trans.add(
      TransModel(
        name: 'Udemy',
        date: 'Sun 10.05.2021', 
        money: "39.99"
        )
    );
        trans.add(
      TransModel(
        name: 'Coursera',
        date: 'Sun 10.05.2021', 
        money: "49.99"
        )
    );

        trans.add(
      TransModel(
        name: 'Shoping',
        date: 'Tue 12.05.2021', 
        money: "29.90"
        )
    );

    trans.add(
      TransModel(
        name: 'Movie Ticket',
        date: 'Mon 11.05.2021', 
        money: "9.50"
        )
    );
        trans.add(
      TransModel(
        name: 'Amazon',
        date: 'Mon 11.05.2021', 
        money: "19.30"
        )
    );
        trans.add(
      TransModel(
        name: 'Udemy',
        date: 'Sun 10.05.2021', 
        money: "39.99"
        )
    );
        trans.add(
      TransModel(
        name: 'Coursera',
        date: 'Sun 10.05.2021', 
        money: "49.99"
        )
    );

        trans.add(
      TransModel(
        name: 'Shoping',
        date: 'Tue 12.05.2021', 
        money: "29.90"
        )
    );

    trans.add(
      TransModel(
        name: 'Movie Ticket',
        date: 'Mon 11.05.2021', 
        money: "9.50"
        )
    );
        trans.add(
      TransModel(
        name: 'Amazon',
        date: 'Mon 11.05.2021', 
        money: "19.30"
        )
    );
        trans.add(
      TransModel(
        name: 'Udemy',
        date: 'Sun 10.05.2021', 
        money: "39.99"
        )
    );
        trans.add(
      TransModel(
        name: 'Coursera',
        date: 'Sun 10.05.2021', 
        money: "49.99"
        )
    );

    return trans;
  }
}