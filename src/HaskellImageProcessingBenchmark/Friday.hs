module HaskellImageProcessingBenchmark.Friday (
    Image,readPng,threshold,mean) where

import Vision.Image.Grey (Grey,GreyPixel)
import Vision.Image.Storage (load)
import Vision.Image.Type (convert)

import qualified Vision.Image.Threshold as Friday (threshold)
import Vision.Image.Threshold (ThresholdType(BinaryThreshold))

import Vision.Image.Filter (apply,blur,SeparableFilter)
import Data.Int (Int16)

type Image = Grey

readPng :: FilePath -> IO Image
readPng filepath = do
    Right image <- load Nothing filepath
    return (convert image)

{-# INLINE threshold #-}
threshold :: Image -> Image
threshold = Friday.threshold (>127) (BinaryThreshold 0 255)

{-# INLINE mean #-}
mean :: Image -> Image
mean image = apply (blur 2 :: SeparableFilter GreyPixel Int16 GreyPixel) image
