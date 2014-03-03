int width = 300;
int height = 300;
PulseInt backgroundColor = new PulseInt(0, 0, 255, 1);
PulseInt strokeColor = new PulseInt(200, 200, 220, 1);
PulseInt strokeWidth = new PulseInt(10, 1, 40, 1);

class PulseInt {
	int grey;
	int min;
	int max;
	int increment;

	PulseInt(int start, int min, int max, int increment) {
		this.grey = start;
		this.max = max;
		this.min = min;
		this.increment = increment;
	}

	void pulse() {
		grey += increment;
		if (grey > max) {
			grey = max;
			increment *= -1;
		} else if (grey < min) {
			grey = min;
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
	strokeColor.pulse();
	stroke(strokeColor.grey);
	strokeWidth.pulse();
	strokeWeight(strokeWidth.grey);
	fill(120);
	rect(0, 0, width/2, height/2);
	rect(width/2, height/2, width, height);
	ellipse(width/2, 0, 150, 150);
}
