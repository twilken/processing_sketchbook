// Represents an immutable point in 2D space.
class Point {
	final int X;
	final int Y;

	Point(int x, int y) {
		this.X = x;
		this.Y = y;
	}
};

// Setup the scene. This function is called at startup.
void setup() {
	final int WINDOW_WIDTH = 768;
	final int WINDOW_HEIGHT = 700;

	final int IMAGE_AREA_WIDTH = WINDOW_WIDTH;
	final int IMAGE_AREA_HEIGHT = WINDOW_HEIGHT / 2;

	final int HISTOGRAM_WIDTH = WINDOW_WIDTH;
	final int HISTOGRAM_HEIGHT = WINDOW_HEIGHT - IMAGE_AREA_HEIGHT;
	final Point HISTOGRAM_DIMENSIONS = new Point(HISTOGRAM_WIDTH, HISTOGRAM_HEIGHT);
	final Point HISTOGRAM_ORIGIN = new Point(0, IMAGE_AREA_HEIGHT);

	size(WINDOW_WIDTH, WINDOW_HEIGHT);
	PImage img = loadImage("bridge.jpg");
	convertToGray(img);
	int[] hist = histogram(img);
	float[] normal = normalizeHistogram(hist);

	// Draw image and histogram
	background(250);
	resizeImageToFitArea(img, IMAGE_AREA_WIDTH, IMAGE_AREA_HEIGHT);
	image(img, 0, 0);
	drawNormalizedHistogram(normal, HISTOGRAM_ORIGIN, HISTOGRAM_DIMENSIONS);
}

// Resize img without stretching to fit width and height.
void resizeImageToFitArea(PImage img, int width, int height) {
	float widthRatio = float(width) / float(img.width);
	float heightRatio = float(height) / float(img.height);
	float resizeFactor = (widthRatio < heightRatio) ? widthRatio : heightRatio;
	int newWidth = (int)(img.width * resizeFactor);
	int newHeight = (int)(img.height * resizeFactor);
	img.resize(newWidth, newHeight);
}

// Convert img to a gray scale image.
void convertToGray(PImage img) {
	for (int x = 0; x < img.width; x++) {
		for (int y = 0; y < img.height; y++) {
			color oldColor = img.get(x, y);
			float red = red(oldColor);
			float green = green(oldColor);
			float blue = blue(oldColor);
			int gray = (int)(red + green + blue) / 3;
			color newColor = color(gray);
			img.set(x, y, newColor);
		}
	}
}

// Return a gray scale histogram of img.
int[] histogram(PImage img) {
	int[] hist = new int[256];
	for (int x = 0; x < img.width; x++) {
		for (int y = 0; y < img.height; y++) {
			color c = img.get(x, y);
			int gray = (int)red(c); // Red, green and blue are the same (gray image)
			hist[gray]++;
		}
	}
	return hist;
}

// Return the normalized version of hist. Values will be between 0 and 1.
float[] normalizeHistogram(int[] hist) {
	float[] normal = new float[hist.length];
	int maxGray = 0;
	for (int i = 0; i < hist.length; i++) {
		int gray = hist[i];
		if (gray > maxGray) {
			maxGray = gray;
		}
	}
	for (int i = 0; i < hist.length; i++) {
		normal[i] = float(hist[i]) / float(maxGray);
	}
	return normal;
}

// Draw the normalized histogram normal to origin (upper left corner of histogram).
// Width and height of the histogram come from the dimensions parameter.
void drawNormalizedHistogram(float[] normal, Point origin, Point dimensions) {
	int barWidth = (int)dimensions.X / 256;
	int posX = (int)origin.X;
	int posY = (int)origin.Y + (int)dimensions.Y;
	rectMode(CORNERS);
	noStroke();
	fill(60);
	for (int i = 0; i < normal.length; i++) {
		rect(posX, posY, posX + barWidth, posY - (normal[i] * dimensions.Y));
		posX += barWidth;
	}
}