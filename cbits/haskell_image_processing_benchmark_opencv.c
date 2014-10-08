#include <opencv/cv.h>
#include <opencv/highgui.h>

IplImage* readPng(char * filepath){
    return cvLoadImage(filepath,0);
}

IplImage* threshold(IplImage* image){

    IplImage* output = cvCreateImage(cvGetSize(image),IPL_DEPTH_8U,1);
    cvThreshold(image,output,127,255,CV_THRESH_BINARY);
    return output;
}

