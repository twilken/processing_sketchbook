void setup() {
	PImage img = loadImage("loewe.jpg");
	size(img.width, img.height);
	image(img, 0, 0);
	convertToGray(img);
	// filter(GRAY);
	drawHistogram(img);
}

void convertToGray(PImage img) {
	for (int x = 0; x < img.width; x++) {
		for (int y = 0; y < img.height; y++) {
			color c1 = get(x, y);
			float red = red(c1);
			float green = green(c1);
			float blue = blue(c1);
			int grey = (int)(red + green + blue) / 3;
			color c2 = color(grey, grey, grey);
			set(x, y, c2);
		}
	}
}

void drawHistogram(PImage img) {
	color barColor = color(30);
	int barPosX = 0;
	int barWidth = 2;
	int[] hist = new int[256];
	for (int x = 0; x < img.width; x++) {
		for (int y = 0; y < img.width; y++) {
			color c = get(x, y);
			int grey = (int)red(c);
			hist[grey]++;
		}
	}
	noStroke();
	fill(barColor);
	rectMode(CORNERS);
	for (int i = 0; i < hist.length; i++) {
		// rect(barPosX, height - (hist[i]), barWidth, height);
		int rectX = barPosX;
		int rectY = height;
		int rectWidth = barPosX + barWidth;
		int rectHeight = hist[i] / 10;
		rect(rectX, rectY, rectWidth, rectHeight);
		barPosX += barWidth;
	}
}
