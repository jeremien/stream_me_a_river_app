import processing.video.*;

Movie[] videos;

int dataSize;

JSONArray datas;
JSONObject setting;

color back;

PFont mainFont;

Boolean full;

public void settings() {
  fullScreen();
}

void setup() {
 
  datas = loadJSONArray("data.json");
  setting = loadJSONObject("setting.json");  
  
  String c = setting.getString("background");
  back = unhex(c);
  
  String f = setting.getString("font");
  int fsize = setting.getInt("fontsize");
  mainFont = createFont(f, fsize);
  
  dataSize = datas.size();
  videos = new Movie[dataSize];

  int index = 0;

  for (int i = 0; i < dataSize; i++) {
   
    JSONObject data = datas.getJSONObject(i);
    
    String path = data.getString("path");
    
    videos[index++] = new Movie(this, path);
   
  }
}

void setTitle(int x, int y, String title) {
  fill(0);
  textAlign(LEFT, CENTER);
  textFont(mainFont);
  text(title, x, y);
}

void setInfo (int x, int y, int w, int h, String title) {
  stroke(0);
  noFill();
  rect(x, y, w - 5, h - 5);
  fill(0);
  textAlign(LEFT, TOP);
  text(title, x + 10, y + 10);
}

void draw() {
  background(back);
  
  String mainTitle = setting.getString("title");
  int xTitle = setting.getInt("x");
  int yTitle = setting.getInt("y");
  setTitle(xTitle, yTitle, mainTitle);
  
  for (int i = 0; i < dataSize; i++) {
   
    JSONObject data = datas.getJSONObject(i);
    
    String title = data.getString("title");
    int x = data.getInt("x");
    int y = data.getInt("y");
    int w = data.getInt("width");
    int h = data.getInt("height");
    int k1 = data.getInt("start");
    int k2 = data.getInt("stop");
    char start = char(k1);
    char stop = char(k2);
    
    setInfo(x, y, w, h, title);

    image(videos[i], x, y, w, h);
    
    println(videos[i].time());
    
    if (keyPressed) {
        if (key == start) {
          videos[i].play();
        }
        if (key == stop) {
          videos[i].pause();
        }
    }
  }
  
}

void movieEvent(Movie m) {
  m.read();
}
