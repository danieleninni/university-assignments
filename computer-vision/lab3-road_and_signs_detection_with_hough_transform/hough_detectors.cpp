/*
Hough Line & Circle Detector
@author Daniele Ninni
*/

#include <iostream>
#include <opencv2/opencv.hpp>

using namespace std;
using namespace cv;

/* WINDOWS NAME ----------------------------------------------------------------------------------- */
// Canny
const string canny_window_name = "Canny Edge Detector";

// HoughLines & HoughCircles
const string hough_window_name = "Hough Line & Circle Detector";
/* ------------------------------------------------------------------------------------------------ */

/* TRACKBARS NAME --------------------------------------------------------------------------------- */
// Canny
const string LowThreshold_trackbar_name = "T_l";
const string HighThreshold_trackbar_name = "T_h";
const string GaussianSmoothing_trackbar_name = "sigma";

// HoughLines
const string lines_AccumulatorThreshold_trackbar_name = "lines_AccTh";
const string MinTheta_trackbar_name = "minTheta";
const string MaxTheta_trackbar_name = "maxTheta";

// HoughCircles
const string CannyThreshold_trackbar_name = "circles_CannyTh";
const string circles_AccumulatorThreshold_trackbar_name = "circles_AccTh";
const string MinRadius_trackbar_name = "minRadius";
const string MaxRadius_trackbar_name = "maxRadius";
/* ------------------------------------------------------------------------------------------------ */

/* PARAMETERS RANGE ------------------------------------------------------------------------------- */
// Canny
const int canny_LowThreshold_min = 1;
const int canny_LowThreshold_max = 500;
const int canny_HighThreshold_min = canny_LowThreshold_min;
const int canny_HighThreshold_max = 3*canny_LowThreshold_max;
const int canny_GaussianSmoothing_min = 3;
const int canny_GaussianSmoothing_max = 7;

// HoughLines
const int lines_AccumulatorThreshold_min = 1;
const int lines_AccumulatorThreshold_max = 500;
const int lines_MinTheta_0_90_min = 0;
const int lines_MinTheta_0_90_max = 90;
const int lines_MaxTheta_0_90_min = lines_MinTheta_0_90_min;
const int lines_MaxTheta_0_90_max = 90;
const int lines_MinTheta_90_180_min = 90;
const int lines_MinTheta_90_180_max = 180;
const int lines_MaxTheta_90_180_min = lines_MinTheta_90_180_min;
const int lines_MaxTheta_90_180_max = 180;

// HoughCircles
const int circles_CannyThreshold_min = 1;
const int circles_CannyThreshold_max = 500;
const int circles_AccumulatorThreshold_min = 1;
const int circles_AccumulatorThreshold_max = 500;
const int circles_MinRadius_min = 1;
const int circles_MinRadius_max = 100;
const int circles_MaxRadius_min = circles_MinRadius_min;
const int circles_MaxRadius_max = 3*circles_MinRadius_max;
/* ------------------------------------------------------------------------------------------------ */

/* HOUGH LINE DETECTOR */
void hough_lines(
                const Mat& image_gray, const Mat& image_display,
                int canny_LowThreshold, int canny_HighThreshold, int canny_GaussianSmoothing,
                int lines_AccumulatorThreshold, int lines_MinTheta_0_90, int lines_MaxTheta_0_90, int lines_MinTheta_90_180, int lines_MaxTheta_90_180)
{
    // use Canny Edge Detector
    Mat edges;
    Canny(
        image_gray,              // input grayscale image
        edges,                   // output binary image: edge map
        canny_LowThreshold,      // low threshold for the hysteresis procedure
        canny_HighThreshold,     // high threshold for the hysteresis procedure
        canny_GaussianSmoothing, // aperture size for the Sobel operator
        true);                   // flag indicating the norm used to calculate the image gradient magnitude: false -> L1 norm, true -> L2 norm (more accurate)

    // show Canny result
    imshow(canny_window_name, edges);

    // use Hough Line Detector for angles in [0,90] (deg)
    vector<Vec2f> lines_0_90;
    HoughLines(
            edges,                            // input binary image: edge map (output of Canny Edge Detector)
            lines_0_90,                       // output vector of found lines: each line is represented by a 2-element vector (rho,theta)
            1,                                // distance resolution of the accumulator in pixels: cell size along rho
            CV_PI/180,                        // angle resolution of the accumulator in radians: cell size along theta
            lines_AccumulatorThreshold,       // accumulator threshold parameter: min # of points to locate a line
            0,                                // (for multi-scale Hough transform) divisor for the distance resolution rho
            0,                                // (for multi-scale Hough transform) divisor for the distance resolution theta
            (CV_PI/180)*lines_MinTheta_0_90,  // minimum angle to check for lines in radians
            (CV_PI/180)*lines_MaxTheta_0_90); // maximum angle to check for lines in radians

    // use Hough Line Detector for angles in [90,180] (deg)
    vector<Vec2f> lines_90_180;
    HoughLines(
            edges,                              // input binary image: edge map (output of Canny Edge Detector)
            lines_90_180,                       // output vector of found lines: each line is represented by a 2-element vector (rho,theta)
            1,                                  // distance resolution of the accumulator in pixels: cell size along rho
            CV_PI/180,                          // angle resolution of the accumulator in radians: cell size along theta
            lines_AccumulatorThreshold,         // accumulator threshold parameter: min # of points to locate a line
            0,                                  // (for multi-scale Hough transform) divisor for the distance resolution rho
            0,                                  // (for multi-scale Hough transform) divisor for the distance resolution theta
            (CV_PI/180)*lines_MinTheta_90_180,  // minimum angle to check for lines in radians
            (CV_PI/180)*lines_MaxTheta_90_180); // maximum angle to check for lines in radians

    // concatenate vectors containing found lines
    vector<Vec2f> lines;
    if (lines_0_90.size() > 0 && lines_90_180.size() > 0) hconcat(lines_0_90, lines_90_180, lines);
    else if (lines_0_90.size() > 0) lines = lines_0_90;
    else if (lines_90_180.size() > 0) lines = lines_90_180;

    // show HoughLines result
    for (size_t i = 0; i < lines.size(); i++) {
        float rho = lines[i][0], theta = lines[i][1];
        double ct = cos(theta), st = sin(theta);
        double x0 = ct*rho, y0 = st*rho;

        Point pt1(cvRound(x0 + 100000*(-st)), cvRound(y0 + 100000*ct));
        Point pt2(cvRound(x0 - 100000*(-st)), cvRound(y0 - 100000*ct));

        line(image_display, pt1, pt2, Scalar(0, 0, 255), 2, LINE_AA);
    }
    imshow(hough_window_name, image_display);
}

/* HOUGH CIRCLE DETECTOR */
void hough_circles(
                const Mat& image_gray, const Mat& image_display,
                int circles_CannyThreshold, int circles_AccumulatorThreshold, int circles_MinRadius, int circles_MaxRadius)
{
    // use Hough Circle Detector
    vector<Vec3f> circles;
    HoughCircles(
                image_gray,                   // input grayscale image
                circles,                      // output vector of found circles: each circle is represented by a 3-element vector (x,y,radius)
                HOUGH_GRADIENT,               // detection method
                1,                            // ratio [image resolution / accumulator resolution]
                image_gray.rows/double(32),   // min distance between the centers of the detected circles
                circles_CannyThreshold,       // higher threshold of the two passed to the Canny Edge Detector (the lower one is twice smaller)
                circles_AccumulatorThreshold, // accumulator threshold for the circle centers at the detection stage
                circles_MinRadius,            // minimum circle radius
                circles_MaxRadius);           // maximum circle radius

    // show HoughCircles result
    for (size_t i = 0; i < circles.size(); i++) {
        int radius = cvRound(circles[i][2]);

        Point center(cvRound(circles[i][0]), cvRound(circles[i][1]));

        circle(image_display, center, radius, Scalar(0, 255, 0), FILLED, LINE_AA);
    }
    imshow(hough_window_name, image_display);
}

/* MAIN */
int main(int argc, char** argv)
{
    // read input image
    Mat image;
    string image_name("image.png"); // default input image name
    if (argc > 1) {
        image_name = argv[1];
    }
    image = imread(image_name, IMREAD_COLOR);
    if (image.empty()) { // if input image cannot be read: print indications of how to run this program
        std::cerr << "\nInvalid input image!\n";
        std::cout << "Usage: " << argv[0] << " <path_to_input_image>\n";
        return -1;
    }

    // convert color space (RGB -> grayscale)
    Mat image_gray;
    cvtColor(image, image_gray, COLOR_RGB2GRAY);

    /* PARAMETERS DECLARATION & INITIALIZATION -------------------------------------------------------- */
    // Canny
    int canny_LowThreshold = canny_LowThreshold_max/4;
    int canny_HighThreshold = canny_HighThreshold_max/4;
    int canny_GaussianSmoothing = canny_GaussianSmoothing_min;

    // HoughLines
    int lines_AccumulatorThreshold = lines_AccumulatorThreshold_max/4;
    int lines_MinTheta_0_90 = lines_MinTheta_0_90_min;
    int lines_MaxTheta_0_90 = lines_MaxTheta_0_90_max;
    int lines_MinTheta_90_180 = lines_MinTheta_90_180_min;
    int lines_MaxTheta_90_180 = lines_MaxTheta_90_180_max;

    // HoughCircles
    int circles_CannyThreshold = circles_CannyThreshold_max/4;
    int circles_AccumulatorThreshold = circles_AccumulatorThreshold_max/4;
    int circles_MinRadius = circles_MinRadius_max/4;
    int circles_MaxRadius = circles_MaxRadius_max/4;
    /* ------------------------------------------------------------------------------------------------ */

    /* WINDOWS CREATION ------------------------------------------------------------------------------- */
    // Canny
    namedWindow(canny_window_name, WINDOW_NORMAL);

    // HoughLines & HoughCircles
    namedWindow(hough_window_name, WINDOW_NORMAL);
    /* ------------------------------------------------------------------------------------------------ */

    /* TRACKBARS CREATION ----------------------------------------------------------------------------- */
    // Canny
    createTrackbar(LowThreshold_trackbar_name,      canny_window_name, &canny_LowThreshold,      canny_LowThreshold_max);
    createTrackbar(HighThreshold_trackbar_name,     canny_window_name, &canny_HighThreshold,     canny_HighThreshold_max);
    createTrackbar(GaussianSmoothing_trackbar_name, canny_window_name, &canny_GaussianSmoothing, canny_GaussianSmoothing_max);

    // HoughLines
    createTrackbar(lines_AccumulatorThreshold_trackbar_name, hough_window_name, &lines_AccumulatorThreshold, lines_AccumulatorThreshold_max);
    createTrackbar(MinTheta_trackbar_name+"0_90",            hough_window_name, &lines_MinTheta_0_90,        lines_MinTheta_0_90_max);
    createTrackbar(MaxTheta_trackbar_name+"0_90",            hough_window_name, &lines_MaxTheta_0_90,        lines_MaxTheta_0_90_max);
    createTrackbar(MinTheta_trackbar_name+"90_180",          hough_window_name, &lines_MinTheta_90_180,      lines_MinTheta_90_180_max);
    createTrackbar(MaxTheta_trackbar_name+"90_180",          hough_window_name, &lines_MaxTheta_90_180,      lines_MaxTheta_90_180_max);

    // HoughCircles
    createTrackbar(CannyThreshold_trackbar_name,               hough_window_name, &circles_CannyThreshold,       circles_CannyThreshold_max);
    createTrackbar(circles_AccumulatorThreshold_trackbar_name, hough_window_name, &circles_AccumulatorThreshold, circles_AccumulatorThreshold_max);
    createTrackbar(MinRadius_trackbar_name,                    hough_window_name, &circles_MinRadius,            circles_MinRadius_max);
    createTrackbar(MaxRadius_trackbar_name,                    hough_window_name, &circles_MaxRadius,            circles_MaxRadius_max);
    /* ------------------------------------------------------------------------------------------------ */

    /* LOOP TO DISPLAY & REFRESH OUTPUT IMAGE UNTIL USER PRESSES "q" OR "Q" */
    char key = 0;
    while (key != 'q' && key != 'Q') {
        /* PARAMETERS CHECK ------------------------------------------------------------------------------- */
        // Canny
        canny_LowThreshold = max(canny_LowThreshold, canny_LowThreshold_min);
        canny_HighThreshold = max(canny_HighThreshold, canny_HighThreshold_min);
        canny_GaussianSmoothing = max(canny_GaussianSmoothing, canny_GaussianSmoothing_min);
        if (canny_GaussianSmoothing % 2 == 0) canny_GaussianSmoothing -= 1; // 'canny_GaussianSmoothing' must be odd

        // HoughLines
        lines_AccumulatorThreshold = max(lines_AccumulatorThreshold, lines_AccumulatorThreshold_min);
        lines_MinTheta_0_90 = max(min(lines_MinTheta_0_90, lines_MaxTheta_0_90), lines_MinTheta_0_90_min);
        lines_MaxTheta_0_90 = max(max(lines_MinTheta_0_90, lines_MaxTheta_0_90), lines_MaxTheta_0_90_min);
        lines_MinTheta_90_180 = max(min(lines_MinTheta_90_180, lines_MaxTheta_90_180), lines_MinTheta_90_180_min);
        lines_MaxTheta_90_180 = max(max(lines_MinTheta_90_180, lines_MaxTheta_90_180), lines_MaxTheta_90_180_min);

        // HoughCircles
        circles_CannyThreshold = max(circles_CannyThreshold, circles_CannyThreshold_min);
        circles_AccumulatorThreshold = max(circles_AccumulatorThreshold, circles_AccumulatorThreshold_min);
        circles_MinRadius = max(circles_MinRadius, circles_MinRadius_min);
        circles_MaxRadius = max(circles_MaxRadius, circles_MaxRadius_min);
        /* ------------------------------------------------------------------------------------------------ */

        // run detectors
        Mat image_display = image.clone();
        hough_lines(image_gray, image_display, canny_LowThreshold, canny_HighThreshold, canny_GaussianSmoothing, lines_AccumulatorThreshold, lines_MinTheta_0_90, lines_MaxTheta_0_90, lines_MinTheta_90_180, lines_MaxTheta_90_180);
        hough_circles(image_gray, image_display, circles_CannyThreshold, circles_AccumulatorThreshold, circles_MinRadius, circles_MaxRadius);

        // save output image to file
        imwrite("output_"+image_name, image_display);

        // get user key
        key = (char)waitKey(10);
    }
    return 0;
}