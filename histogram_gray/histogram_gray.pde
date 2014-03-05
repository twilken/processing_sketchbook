final int WINDOW_WIDTH = 768;
final int WINDOW_HEIGHT = 700;
final int IMAGE_AREA_WIDTH = WINDOW_WIDTH;
final int IMAGE_AREA_HEIGHT = WINDOW_HEIGHT / 2;
final int HISTOGRAM_WIDTH = WINDOW_WIDTH;
final int HISTOGRAM_HEIGHT = WINDOW_HEIGHT - IMAGE_AREA_HEIGHT;

void setup() {
	size(WINDOW_WIDTH, WINDOW_HEIGHT);
	PImage img = loadImage("loewe.jpg");
	resizeImageToFitArea(img, IMAGE_AREA_WIDTH, IMAGE_AREA_HEIGHT);
	image(img, 0, 0);
	convertToGray(img);
	// drawHistogram(img);
}

void resizeImageToFitArea(PImage img, int width, int height) {
	float widthRatio = float(width) / float(img.width);
	float heightRatio = float(height) / float(img.height);
	float resizeFactor = (widthRatio < heightRatio) ? widthRatio : heightRatio;
	int newWidth = (int)(img.width * resizeFactor);
	int newHeight = (int)(img.height * resizeFactor);
	img.resize(newWidth, newHeight);
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
	int barWidth = 3;
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
		int rectX = barPosX;
		int rectY = height;
		int rectWidth = barPosX + barWidth;
		int rectHeight = hist[i] / 10;
		rect(rectX, rectY, rectWidth, rectHeight);
		barPosX += barWidth;
	}
}
