class TransfModel {
  String name;
  String bank;
  String imagePath;

  TransfModel({
    required this.name,
    required this.bank,
    required this.imagePath
  });
  
  static List<TransfModel> getTransfers(){
    List<TransfModel> transfers = [];

    transfers.add(
      TransfModel(
        name: 'Evelyn Smith',
        bank: 'AW BANK UNI 234-46589-000', 
        imagePath: 'assets/images/m.jpeg'
        )
    );

    transfers.add(
      TransfModel(
        name: 'Emily Atkinson',
        bank: 'AW BANK UNI 234-46589-000',  
        imagePath: 'assets/images/n.jpeg'
        )
    );
    transfers.add(
      TransfModel(
        name: 'Oliver Wilson',
        bank: 'AW BANK UNI 234-46589-000',  
        imagePath: 'assets/images/b.jpeg'
        )
    );
    transfers.add(
      TransfModel(
        name: 'Sophie Baker',
        bank: 'AW BANK UNI 234-46589-000',  
        imagePath: 'assets/images/q.png'
        )
    );
    transfers.add(
      TransfModel(
        name: 'Charlie William',
        bank: 'AW BANK UNI 234-46589-000',  
        imagePath: 'assets/images/r.jpeg'
        )
    );

     transfers.add(
      TransfModel(
        name: 'Evelyn Smith',
        bank: 'AW BANK UNI 234-46589-000', 
        imagePath: 'assets/images/m.jpeg'
        )
    );

    transfers.add(
      TransfModel(
        name: 'Emily Atkinson',
        bank: 'AW BANK UNI 234-46589-000',  
        imagePath: 'assets/images/n.jpeg'
        )
    );
    transfers.add(
      TransfModel(
        name: 'Oliver Wilson',
        bank: 'AW BANK UNI 234-46589-000',  
        imagePath: 'assets/images/b.jpeg'
        )
    );
    transfers.add(
      TransfModel(
        name: 'Sophie Baker',
        bank: 'AW BANK UNI 234-46589-000',  
        imagePath: 'assets/images/q.png'
        )
    );
    transfers.add(
      TransfModel(
        name: 'Charlie William',
        bank: 'AW BANK UNI 234-46589-000',  
        imagePath: 'assets/images/r.jpeg'
        )
    );


    return transfers;
  }
}