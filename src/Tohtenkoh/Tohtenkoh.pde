  private static final int HAI_WIDTH = 48;
  private static final int HAI_HEIGHT = 72;
  private static final int HAI_NUM_MAX = (9+9+3+7)*4;
  
  ArrayList<Hai> defaultYama = new ArrayList<Hai>();
  ArrayList<Hai> shuffled = new ArrayList<Hai>();
  
  ArrayList<Hai> AKawa = new ArrayList<Hai>();
  ArrayList<Hai> BKawa = new ArrayList<Hai>();
  ArrayList<Hai> CKawa = new ArrayList<Hai>();
  ArrayList<Hai> DKawa = new ArrayList<Hai>();
  
  PImage imgHai;
  int Kawa_x = 480;
  int Kawa_y = 576;
  int Tehai_x = 240;
  int Tehai_y = 862; 
  
  void setup(){
    imgHai = loadImage("../img/hai.png");
    
    size(1280,960);
    background(255);
    createYama();
    initYama();
    
    rect(Kawa_x, Kawa_y,
        HAI_WIDTH * 6, HAI_HEIGHT * 3);
    rect(Tehai_x, Tehai_y,
        HAI_WIDTH * 15, HAI_HEIGHT * 1);
    
    game();
  }
  
  void game(){
    Player Me = new Player();
    for(int i = 0; i < 14; i++){
      Me.Tehai.add(shuffled.get(i));
    }
    
    drawTehai(Me);
  }
  
  void draw(){
    
  }
  
  class Player{
    ArrayList<Hai> Tehai = new ArrayList<Hai>();
    ArrayList<Hai> Kawa = new ArrayList<Hai>();
    ArrayList<Hai> Naki = new ArrayList<Hai>();
    
    int point;
    String state;
    
    Player(){
    }
  }
    
  
  class Hai{
    int id;
    PVector pos;
    PVector group;
    PImage img;
    
    Hai(int id, int x, int y){
      this.id = id;
      this.img = imgHai.get(x * HAI_WIDTH, y * HAI_HEIGHT, HAI_WIDTH, HAI_HEIGHT);
      group = new PVector(x, y);
    }
  }
  
  
  void drawHai(Hai hai, float x, float y){
    image(hai.img, x , y );
  }
    
  class Layout{
    void changeShimoHai(){
      pushMatrix();
        translate(width/2, height/2);
        rotate((PI / 2) * 3);
    }
  
    void chageToiHai(float x, float y){
      pushMatrix();
        translate(width/2, height/2);
        rotate((PI / 2) * 2);    
    }
  
    void chageKamiHai(float x, float y){
      pushMatrix();
        translate(width/2, height/2);
        rotate((PI / 2) * 1);
     }
    
    void Reset(){
      popMatrix();
    }
  }
  
  void initYama(){
    this.defaultYama = createYama();
    //debagImg(this.defaultYama, 0, 0);
    
    this.shuffled = shuffleYama(this.defaultYama);
    //debagImg(this.shuffled, 13 * HAI_WIDTH, 0);
  }
  
  ArrayList<Hai> createYama(){
    int id = 0;
    ArrayList<Hai> Yama = new ArrayList<Hai>();
    for(int y = 0; y < 4; y++){
      for(int x = 0; x < 9; x++){
        for(int k = 0; k < 4; k++){
          Yama.add(new Hai(id, x, y));
          id++;
          System.out.printf(x+","+y+"\n" );        
        }
        if(y == 2){
           x += 3;  //1m 5m 9m stepup
        }
        if(y == 3){
           if(x >= 6){
             break;
           }
        }
      }
    }
    System.out.printf("====createYamaFinish====\n");
    
    return Yama;
  }
  
  ArrayList<Hai> shuffleYama(ArrayList<Hai> Yama){
    ArrayList<Hai> targetYama = new ArrayList(Yama);
    ArrayList<Hai> shuffledYama = new ArrayList<Hai>();
    
    for(int i = HAI_NUM_MAX; i > 0; --i) {  
      int rnd = (int)random(i);
      shuffledYama.add(targetYama.get(rnd));
      targetYama.remove(rnd);
    }
    System.out.printf("====shuffleYamaFinish====\n");
    return shuffledYama;
  }
  
  void drawTehai(Player player){
    
    for(int i = 0;  i < player.Tehai.size(); i++){
      drawHai(player.Tehai.get(i), (i * HAI_WIDTH) + Tehai_x, Tehai_y);
    }
    
  }
  
  void debagImg(ArrayList<Hai> yama, int x, int y){
    for(int i = 0; i < 12; i++){
      for(int j = 0; j < 10; j++){
        if(i+j*12 >= HAI_NUM_MAX){
          break;
        }
        drawHai(yama.get(i+j*12), (i * HAI_WIDTH) + x, (j * HAI_HEIGHT) + y);    
      }
    }
  }
  