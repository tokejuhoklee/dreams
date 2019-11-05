Wake[] awakeTimed;

float red;
float green;
float blue;

int s=1;

float walkLength[]=new float[171];
float sleepLength[]=new float[171];
float awakeTimes[]=new float[171];
float awakedTimes[]=new float[171];

float heights[]=new float[171];

float widthMap;
float heightMap;
float difference;
float test;
int innerRad = 150;
int lineWeight = 5;
int lineSpace = 18;
float rigth;
float left;
boolean go[] = new boolean[171];

String day[] = new String[0];
float steps[] = new float[0];
float dailyMove[] = new float[0];
float targetKm[] = new float[0];
float totalDistance[] = new float[0];
float toTarget[] = new float[171];
float sleepTime[] = new float[0];
float awake[] =new float[0];
int sleepTarget=9;
//float test1[] = new float[0];

void setup() {
  size(1850, 1000,P3D);//P3D
  frameRate(60);
  smooth(8);




  widthMap=width;
  heightMap=height;
  left=width/4;
  rigth=width/4*3;
  difference =widthMap/4*3-widthMap/4;
  translate(width/2, height/2);



  JSONArray json = loadJSONArray("oura.json");
  for (int i = 0; i < json.size(); i++) {
    JSONObject elements = json.getJSONObject(0);
    JSONArray activities = elements.getJSONArray("activity");
    for (int j = 0; j < activities.size(); j++) {
      JSONObject Activity = activities.getJSONObject(j);
      steps = append(steps, Activity.getFloat("steps"));
      // JSONObject toTargets = Activity.getJSONObject("to_target_km");
      toTarget=append(toTarget, Activity.getFloat("to_target_km"));
      dailyMove=append(dailyMove, Activity.getFloat("daily_movement"));
      targetKm=append(targetKm, Activity.getFloat("target_km"));
      targetKm[j]=targetKm[j]*1000;
      //println(targetKm[j]+"<-targetKm steps->"+steps[j]);
      day=append(day, Activity.getString("day_start"));
    }
    JSONArray sleep = elements.getJSONArray("sleep");
    //  JSONArray sleepJs = sleepJ.getJSONArray("sleep");
    for (int j = 0; j < sleep.size(); j++) {
      JSONObject Sleep = sleep.getJSONObject(j);
      sleepTime=append(sleepTime, Sleep.getFloat("duration"));
      awake=append(awake, Sleep.getFloat("awake"));
      println(sleepTime[j]/60/60);

    }
  }


  for (int i=0; i<day.length; i++) {
    String[]test=split(day[i], 'T');
    day[i]=test[0];
  }




  for (int i =0; i<171; i++) {
    heights[i]=height/2-75-(i*lineSpace/2);//højde
    
    walkLength[i] = map(dailyMove[i], 0, -25000, 0, TWO_PI);//bevægelse
    toTarget[i] = map(targetKm[i], 0, -25000, 0, TWO_PI);
    
    sleepLength[i] = map(sleepTime[i], 0, 86400, 0, TWO_PI);//søvn
    
    awakeTimes[i]=map(awake[i], 0, 86400, 0, TWO_PI);//vågen
    float awakeTime=map(awake[i], 0, 86400, 0, TWO_PI);
    awakedTimes[i]=awakeTime;

    float degrees= degrees(awakeTime);
    awakeTime=degrees/360*(PI*(innerRad+i*lineSpace));
    awakeTimes[i]=awakeTime;    
   // println(awakeTimes[5]);
  }
  awakeTimed=new Wake[171];
    for (int i = 0; i < 59; i++) {

    awakeTimed[i]=new Wake(left,awakeTimes[i],heights[i]);
  //  println(awakeTimed[9]);
  }
}


void draw() {
  surface.setTitle(int(frameRate) + " fps / " + frameCount + " frames" + mouseX + "MouseX");
  background(255, 245, 242);





  for (int i=0; i<s&&i<171; i++) {
    noFill();
    stroke(184, 106, 115, 150);
    strokeWeight(5);
    arc(width/4*3, height/2, innerRad+i*lineSpace, innerRad+i*lineSpace, walkLength[i]-HALF_PI, 0-HALF_PI );


    // TOTARGET    7,62km er 10000skridt

    stroke(153, 92, 99, 150);
    arc(width/4*3, height/2, innerRad+i*lineSpace, innerRad+i*lineSpace, toTarget[i]-HALF_PI, 0-HALF_PI);

    // sleep
    stroke(212, 19, 19, 150);
    arc(width/4, height/2, innerRad+i*lineSpace, innerRad+i*lineSpace, 0-HALF_PI, sleepLength[i]-HALF_PI);
 


    stroke(219, 180, 180);
    arc(width/4, height/2, innerRad+i*lineSpace, innerRad+i*lineSpace, 0-HALF_PI, awakedTimes[i]-HALF_PI);

//println(awakeTimes[5]);
    // Draw Labels
    noStroke();
    fill(0);
    textAlign(LEFT);
    textSize(11);
    text(day[i], width/4-170, height/2-(innerRad+i*lineSpace)/2+5);
    text((nf(sleepTime[i]/60/60, 0, 2)), width/4-60, height/2-(innerRad+i*lineSpace)/2+5);
    text((nf(awake[i]/60/60, 0, 2)), width/4-90, height/2-(innerRad+i*lineSpace)/2+5);

    text(day[i], width/4*3+10, height/2-(innerRad+i*lineSpace)/2+5);
    text(dailyMove[i], width/4*3+100, height/2-(innerRad+i*lineSpace)/2+5);
    stroke(0);
    line(width/4,height/2,width/4,height);
    line(width/4*3,height/2,width/4*3,height);
    
    
  }

  for (int i = 0; i < 50; i++) {
    
    stroke(212, 19, 19,150);
    awakeTimed[i].display();
    //println(left,awakeTimes[i],heights[i]);
  }
}
