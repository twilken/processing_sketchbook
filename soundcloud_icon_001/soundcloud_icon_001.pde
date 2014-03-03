int width = 300;
int height = 300;
PulseInt backgroundColor = new PulseInt(100, 0, 100, 0.1f);
PulseInt strokeColor = new PulseInt(200, 200, 220, 1.0f);
PulseInt strokeWidthSun = new PulseInt(0, 0, 10, 0.2f);
PulseInt strokeWidthOther = new PulseInt(0, 0, 100, 0.2f);

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
			grey = max - increment;
			increment *= -1;
		} else if (grey < min) {
			grey = min + increment;
			increment *= -1;
		}
	}
};

void setup() {
	size(width, height);
	background(0);
}

void drawSun() {
	stroke(205);
	strokeWidthSun.pulse();
	strokeWeight(strokeWidthSun.value());
	fill(220, 200, 60);
	ellipse(width/2, 0, 150, 150);
	fill(235, 170, 60);
	ellipse(width/2, 0, 120, 120);
	fill(255, 130, 60);
	ellipse(width/2, 0, 90, 90);
}

void drawHorizon() {
	fill(180, 130, 90);
	strokeWeight(0);
	rect(0, height/3, width, height);
}

void draw() {
	backgroundColor.pulse();
	background(230, 100, 250);

	strokeColor.pulse();
	stroke(strokeColor.value());

	strokeWidthOther.pulse();
	strokeWeight(strokeWidthOther.value());

	drawSun();
	drawHorizon();
}
