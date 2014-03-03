int width = 300;
int height = 300;
PulseColor backgroundColor = new PulseColor(0, 0, 255, 1);

class PulseColor {
	int grey;
	int min;
	int max;
	int increment;

	PulseColor(int grey, int min, int max, int increment) {
		this.grey = grey;
		this.max = max;
		this.min = min;
		this.increment = increment;
	}

	void pulse() {
		grey += increment;
		if (grey > 255) {
			grey = 255;
			increment *= -1;
		} else if (grey < 0) {
			grey = 0;
			increment *= -1;
		}
	}
};

void setup() {
	size(width, height);
	background(0);
}


void draw() {
	backgroundColor.pulse();
	background(backgroundColor.grey);
	stroke(200);
	strokeWeight(40);
	fill(120);
	rect(0, 0, width/2, height/2);
	rect(width/2, height/2, width, height);
	ellipse(width/2, 0, 150, 150);
}
