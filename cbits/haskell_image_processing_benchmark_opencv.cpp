#include <opencv2/highgui/highgui.hpp>
#include <opencv2/opencv.hpp>

using namespace cv;

extern "C" cv::Mat foo(){
    return imread( "../koblenz.png", 0 );
}

