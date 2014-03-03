int width = 300;
int height = 300;
PulseInt backgroundColor = new PulseInt(0, 0, 255, 1);
PulseInt strokeColor = new PulseInt(200, 200, 220, 1);
PulseInt strokeWidth = new PulseInt(0, 0, 20, 0.2f);

class PulseInt {
	private float grey;
	private int min;
	private int max;
	private float increment;

	PulseInt(int start, int min, int max, float increment) {
		this.grey = (float)start;
		this.max = max;
		this.min = min;
		this.increment = increment;
	}

	int value() {
		return (int)grey;
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
	background(backgroundColor.value());

	strokeColor.pulse();
	stroke(strokeColor.value());

	strokeWidth.pulse();
	strokeWeight(strokeWidth.value());

	fill(120);
	rect(width/2, height/2, width, height);
	ellipse(width/2, 0, 150, 150);
}
