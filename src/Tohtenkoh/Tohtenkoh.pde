  import java.util.Arrays; 
  import java.util.Comparator;
  import java.util.Collections;

  private PImage imgHai;
  
  //Layout
  private static final int HAI_WIDTH = 48;
  private static final int HAI_HEIGHT = 72;
  private static final int HAI_NUM_MAX = (9+9+3+7)*4;
  
  private static final int KAWA_X = 480;
  private static final int KAWA_Y = 576;
  private static final int TEHAI_X = 240;
  private static final int TEHAI_Y = 862;
    
  ArrayList<Hai> defaultYama = new ArrayList<Hai>();
  ArrayList<Hai> shuffled = new ArrayList<Hai>();
  
  //Player
  private Player me = new Player("Me");
  private Player com1 = new Player("Com1");
  private Player com2 = new Player("Com2");
  
  Player players[] = {me, com1, com2};
  private int nowPlayer = 0;

  private int clickHai = -1;
  private int nowHaiNum = 0;
  

  //準備
  void setup(){
    //画像の準備
    imgHai = loadImage("../img/hai.png");
    //基本山作成 今後はコピーしてシャッフルして使用
    this.defaultYama = createYama();
    
    size(1280,960);
    background(255);
    game();
  }
  
  void draw(){
  }
  
  //ゲームの流れ
  void game(){
   
    shuffledYama();
    setTehai();
    Tsumo(players[nowPlayer % 3]);
  }
  
  //山を混ぜる
   void shuffledYama(){
    shuffled = new ArrayList<Hai>(defaultYama); 
    Collections.shuffle(shuffled);
    nowHaiNum = 0;
    
    //debagImg(this.defaultYama, 0, 0);
    //debagImg(this.shuffled, 13 * HAI_WIDTH, 0);
    
    System.out.printf("====shuffledYamaFinish====\n");
  }
  
  //山生成
  ArrayList<Hai> createYama(){
    int id = 0;
    ArrayList<Hai> yama = new ArrayList<Hai>();
    for(int y = 0; y < 4; y++){
      for(int x = 0; x < 9; x++){
        for(int k = 0; k < 4; k++){
          yama.add(new Hai(id, x, y));
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
    return yama;
  }
  
  //配牌
  void setTehai(){
    for(int i = 0; i < 13; i++){
      me.Tehai.add(shuffled.get(i));
      com1.Tehai.add(shuffled.get(i+13));
      com2.Tehai.add(shuffled.get(i+26));
      nowHaiNum += 3;
    }
    me.sortTehai();
    drawTehai(me);
    System.out.printf("====HaipaiFinish====\n");
  }
  
  //ツモして表示
  void Tsumo(Player player){
    clickHai = -1;
    
    //手牌分
    //TODO 回数
    player.Tehai.add(shuffled.get(nowHaiNum)); //<>//
    drawTsumo(player);
    System.out.printf("ツモ"+shuffled.get(nowHaiNum).id);
    System.out.printf("\n====TsumoFinish====\n");
  }
  
  //クリックされたら
  void mousePressed(){
    System.out.println("クリックされた");
    Choice();
  }

  //牌選択
  void Choice(){
    Player player = players[nowPlayer % 3];
    int x = mouseX;
    int y = mouseY;
    
    //TODO どうにかしたい条件式
    if((TEHAI_X) <= x && (x <= TEHAI_X + player.Tehai.size() * HAI_WIDTH)){
      if(TEHAI_Y <= y && y <= TEHAI_Y + HAI_HEIGHT){
        clickHai = (x - TEHAI_X) / HAI_WIDTH;
        Sute(player, clickHai);
      }
    }
  }
  
  void Sute(Player player, int suteHai){
    System.out.println(suteHai);
    player.Kawa.add(player.Tehai.get(suteHai));
    player.Tehai.remove(suteHai);
    drawKawa(player);
    
    player.sortTehai();
    drawTehai(player);
    nowHaiNum += 1;
    
    //TODO上がり処理
    
    //次の人
    //nowPlayer ++;
    Tsumo(players[nowPlayer % 3]);
     
  }
  
 