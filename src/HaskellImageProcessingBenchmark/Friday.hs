module HaskellImageProcessingBenchmark.Friday (
    Image,readPng,threshold) where

import Vision.Image.Grey (Grey)
import Vision.Image.Storage (load)
import Vision.Image.Type (convert)

import qualified Vision.Image.Threshold as Friday (threshold)
import Vision.Image.Threshold (ThresholdType(BinaryThreshold))

type Image = Grey

readPng :: FilePath -> IO Image
readPng filepath = do
    Right image <- load Nothing filepath
    return (convert image)

threshold :: Image -> Image
threshold = Friday.threshold (>127) (BinaryThreshold 0 255)
