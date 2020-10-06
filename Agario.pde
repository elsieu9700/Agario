//files
var data_load = [];
var data_save = [];
//Entity
var en = [];
//Player
var player_size = 20;
var player_x = 0;
var player_y = 0;
//General
var gameover = false;
var pause = true;
var menu = 1;
var score = 0;
var highscore = 0;
//Data
var mousePress = false;
//Gameplay
var joystick = false;
var mouse = true;
var goTo = false;
function setup() {
  createCanvas(windowWidth,windowHeight);
  ellipseMode(CENTER);
  rectMode(CENTER);
  textAlign(CENTER,CENTER);
 
  for(var i=0; i<0; i++) {
	en[i] = new Entity();
  }
}
function draw() {
  background(0);
 
  //Add
  if(frameCount%5 === 0 && !gameover && !pause) {
	en.push(new Entity());
  }
 
  //Score
  if(frameCount%250==0 && !gameover && !pause) {
	score++;
  }
 
  if(!pause && !gameover) {
	fill(255);
	textSize(20);
	textAlign(LEFT,CENTER);
	text(score,20,80);
  }
 
  //Entity
  for(var i=0; i<en.length; i++) {
	if(en[i].life < 1) {
  	en.splice(i,1);
	}
	if(en.length>80) {
  	en.splice(0,1);
	}
	
	en[i].display();
	
	if(!gameover && !pause) {
  	en[i].update();
	}
  }
 
  //Gameplay
  if(!gameover && !pause) {
	if(mouse) {
	 player_x = mouseX;
	 player_y = mouseY;
	}
	else if(goTo) {
  	 player_x += (mouseX-player_x) * 0.05;
	 player_y += (mouseY-player_y) * 0.05;
	}
	else if(joystick) {
  	var player_direction = []
  	
  	player_direction = Joystick(width/2,height/2);
  	
  	player_x += clamp(player_direction[0],0,width);
  	player_y += clamp(player_direction[1],0,height);
  	
  	print(player_x + " | " + player_y);
	}
  }
  if(!pause && !goTo && !joystick) {
	mouse = true;
  }
 
  //Player
  fill(255);
  noStroke();
  ellipse(player_x,player_y,player_size,player_size);
  //ellipse(player_x,player_y,clamp(player_size,0,200),clamp(player_size,0,200));
 
 
  //GameOver Scean
  if(gameover) {
	fill(0,200);
	rect(width/2,height/2,width,height);
	
	textAlign(CENTER,CENTER);
	fill(255);
	textSize(50);
	text("Game Over",width/2,height/2-50);
	
	if(score < highscore) {
  	textSize(30);
	text("your score : "+score,width/2,height/2);
	text("your Highscore : "+highscore,width/2,height/2+50);
	}
	else {
  	highscore = score;
  	
  	textSize(30);
  	text("new Highscore : "+highscore+" !",width/2,height/2);
	}
	
	textSize(20);
	text("Visit Stephcraft.net for more games",width/2,height/2+200);
  }
 
  //Pause menu
  else if(pause && menu==-1) {
	fill(0,200);
	rect(width/2,height/2,width,height);
	
	textAlign(CENTER,CENTER);
	fill(255);
	textSize(50);
	text("Paused",width/2,height/2);
  }
 
  //Main menu
  else if(pause && menu==1) {
	fill(0,200);
	rect(width/2,height/2,width,height);
	
	textAlign(CENTER,CENTER);
	fill(255);
	textSize(50);
	text("Agario is here !",width/2,height/2-200);
	
	press("Play",width/2,height/2,0,false);
	press("Options",width/2,height/2+80,2,true);
	
	noStroke();
	fill(255);
	textSize(20);
	textAlign(LEFT,CENTER);
	text("M --------------- main menu\nSPACE BAR - pause",width/2-100,height/2+150);
  }
 
  //Option menu
  else if(pause && menu==2) {
	fill(0,200);
	rect(width/2,height/2,width,height);
	
	textAlign(CENTER,CENTER);
	fill(255);
	textSize(50);
	text("Options",width/2,height/2-200);
	
	textSize(20);
	text("Mode:",width/2,height/2-100);
	
	textAlign(LEFT,CENTER);
	
	text("Joystick",width/2-50,height/2);
	
	if(bool(width/2+100,height/2,joystick)) {
  	joystick = true;
  	mouse = false;
  	goTo = false;
	}
	else {
  	joystick = false;
	}
	
	
	text("Mouse",width/2-50,height/2+50);
	
	if(bool(width/2+100,height/2+50,mouse)) {
  	joystick = false;
  	mouse = true;
  	goTo = false;
	}
	else {
  	mouse = false;
	}
	
	text("Go to",width/2-50,height/2+100);
	
	if(bool(width/2+100,height/2+100,goTo)) {
  	joystick = false;
  	mouse = false;
  	goTo = true;
	}
	else {
  	goTo = false;
	}
	
	//Back
	press("back",width/2,height/2+200,1,true);
  }
 
}
function mousePressed() {
  if(gameover) {
	score = 0;
	player_size=20;
	en = [];
	gameover = false;
  }
  if(pause && (menu==-1 || menu==0)) {
	pause = false;
  }
 
  mousePress=true;
}
function mouseReleased() {
  mousePress=false;
}
function keyPressed() {
  if(key==' ' && !gameover && (menu==-1 || menu==0)) {
	if(pause) {
  	menu = 0;
  	pause = false;
	}
	else if(!pause) {
  	menu = -1;
  	pause = true
	}
  }
 
  if(key=='M') {
   pause = true;
	menu = 1;
	
	//RESTART
	score = 0;
	player_size=20;
	en = [];
  }
}
/* ### HELP ###
 * i cant save local files with : saveStrings()
 * maybe there is a way, but didint found how :/
 *
 * called in Entity > update > if
 * ############
 */
function data() {
  if(score > highscore) {
	highscore = score;
  }
 
  data_save[0] = ""+highscore;
 
  saveStrings(data_save,"data.txt");
 
  data_load = loadStrings("data.txt");
 
  highscore = int(data_load[0]);
}
//#######################################################################################################################################//
//                                                                                                                                   	//
//                                                        	Entity                                                                 	//
//                                                                                                                                   	//
//#######################################################################################################################################//

var entity = {
  x : 0,
  y : 0,
 
  size : 50,
 
  r : 100,
  g : 100,
  b : 255,
 
  position : 0,
 
  directionX : 1,
  directionY : 1,
 
  life : 10,
 
  display : function() {},
  update : function() {}
 
};
function Entity() {
 
  this.position = int(random(0,4));
 
  this.size = random(player_size/2,player_size+5+score);
 
  if(this.position===0) {
	this.x = random(0,width);
	this.y = 0-this.size/2;
  }
  if(this.position==1) {
	this.x = 0-this.size/2;
	this.y = random(0,height);
  }
  if(this.position==2) {
	this.x = width+this.size/2;
	this.y = random(0,height);
  }
  if(this.position==3) {
	this.x = random(0,width);
	this.y = height+this.size/2;
  }
 
 
  this.r = random(256);
  this.g = random(256);
  this.b = random(256);
 
  // (-PI,PI) ~ (-3,3)
  this.directionX = random(-PI,PI);
  this.directionY = random(-PI,PI);
 
  this.display = function() {
	fill(this.r,this.g,this.b);
	ellipse(this.x,this.y,this.size,this.size);
	
  }
 
  this.update = function() {
	this.x+=this.directionX;
	this.y+=this.directionY;
	
	this.life--;
	
	//Check if inside player
	if(dist(this.x,this.y,player_x,player_y) < this.size/2 + player_size/2) {
  	if(this.size > player_size) {
    	gameover = true;
    	/* data(); */
  	}
  	else {
    	player_size+=3;
    	score+=3;
    	this.life = 0;
  	}
	}
  }
 
}
//#######################################################################################################################################//
//                                                                                                                                   	//
//                                                          	GUI                                                                  	//
//                                                                                                                                   	//
//#######################################################################################################################################//
function press(title,x,y,page,doPause) {
 
  strokeWeight(2);
  stroke(255);
  textSize(20);
  textAlign(CENTER,CENTER);
  if(mouseX > x-300/2 && mouseX < x+300/2 && mouseY > y-40/2 && mouseY < y+40/2) {
	fill(255);
	rect(x,y,300,40);
	fill(0);
	text(title,x,y);
	
  	if(mousePress) {
	 menu = page;
	 pause = doPause;
   }
  }
  else {
	fill(0);
	rect(x,y,300,40);
	fill(255);
	text(title,x,y);
  }
}
function bool(x,y,variable) {
 
  var chosen;
 
 
  if(variable) {
	if(mouseX > x-20-10 && mouseX < x-20+10 && mouseY > y-10 && mouseY < y+10 && mousePress) {
	 chosen = false;
   }
   else {
	 chosen = true;
   }
	
	fill(50,255,50);
   rect(x,y,65,25,20);
	
   fill(255);
   ellipse(x+20,y,20,20);
  }
  else {
	if(mouseX > x+20-10 && mouseX < x+20+10 && mouseY > y-10 && mouseY < y+10 && mousePress) {
	 chosen = true;
   }
   else {
	 chosen = false;
   }
	
	fill(255,0,0);
   rect(x,y,65,25,20);
	
   fill(255);
   ellipse(x-20,y,20,20);
  }
 
  return chosen;
}
function Joystick(x,y) {
  var mouse_x = clamp(mouseX,x-50,x+50);
  var mouse_y = clamp(mouseY,y-50,y+50);
 
  var data = [];
 
  if(dist(x,y,mouseX,mouseY) > 50) {
	mouse_x = mouse_x;
	mouse_y = mouse_y;
  }
 
  data[0] = map(x-mouse_x,0,width,-1,1);
  data[1] = map(y-mouse_y,0,height,-1,1);
 
  fill(255,200);
  ellipse(x,y,100,100);
 
  fill(50,200);
  ellipse(mouse_x,mouse_y,50,50);
 
  //ANGLE
  //return atan2(y - mouse_y,x - mouse_x);
 
  //DIRECTION
  return data;
}
function clamp(number,min,max) {
  var result = number;
 
  if(number>max) {
	result = max;
  }
 
  if(number<min) {
	result = min;
  }
 
  return result;
}

