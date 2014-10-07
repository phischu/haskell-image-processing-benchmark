#include <opencv/cv.h>
#include <opencv/highgui.h>

CvMat* readPng(char * filepath){
    return cvLoadImageM(filepath,0);
}

