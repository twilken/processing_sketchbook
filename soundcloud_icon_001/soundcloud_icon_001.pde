color backgroundColor = 160;
int width = 300;
int height = 300;


void setup() {
	size(300, 300);
	background(backgroundColor);
	noStroke();
}

void mousePressed() {
	backgroundColor = (backgroundColor + 200) % 255;
}

void draw() {
	background(backgroundColor);
	stroke(200);
	strokeWeight(40);
	fill(120);
	rect(0, 0, width/2, height/2);
	rect(width/2, height/2, width, height);
	ellipse(width/2, 0, 150, 150);
}
