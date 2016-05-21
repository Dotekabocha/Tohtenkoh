  
  class Player{
    ArrayList<Hai> Tehai = new ArrayList<Hai>();
    ArrayList<Hai> Kawa = new ArrayList<Hai>();
    ArrayList<Hai> Naki = new ArrayList<Hai>();
        
    int point;
    String name;
    String state;
    
    Player(String name){
      this.name = name;
    }
    
    
    void sortTehai(){
      ArrayList tehai = this.Tehai;
      ArrayList<Hai> target = new ArrayList<Hai>(tehai);
      ArrayList<Hai> sorted = new ArrayList<Hai>();
      
      for(int i = 0; i < tehai.size(); i++){
        float min = 999;
        int min_num = 0;
        
        for(int j = 0; j < tehai.size() - i; j++){
          Hai hai = target.get(j);
          int id = hai.getId();
  
          if(id < min){
            min = id;
            min_num = j;
          }
        }
       sorted.add(target.get(min_num));
       target.remove(min_num);
      }
      System.out.println("====sortTehaiFinish====");
      
      for(Hai hai: sorted){
        System.out.printf("%d,",hai.id);
      }
      System.out.println();
      this.Tehai = sorted;
    }
  }