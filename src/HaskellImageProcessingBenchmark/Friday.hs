module HaskellImageProcessingBenchmark.Friday (
    Image,readPng,threshold,mean) where

import Vision.Image.Grey (Grey,GreyPixel)
import Vision.Image.Storage (load)
import Vision.Image.Type (convert)

import qualified Vision.Image.Threshold as Friday (threshold)
import Vision.Image.Threshold (ThresholdType(BinaryThreshold))

import Vision.Image.Filter (apply,blur,SeparableFilter)

type Image = Grey

readPng :: FilePath -> IO Image
readPng filepath = do
    Right image <- load Nothing filepath
    return (convert image)

threshold :: Image -> Image
threshold = Friday.threshold (>127) (BinaryThreshold 0 255)

mean :: Image -> Image
mean = apply (blur 2 :: SeparableFilter GreyPixel GreyPixel GreyPixel)
