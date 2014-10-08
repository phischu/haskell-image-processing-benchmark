module HaskellImageProcessingBenchmark.UnmHip (
    Image,readPgm,force,threshold,mean) where

import Data.Image.Boxed (GrayImage,readImage,toBinaryImage)
import Data.Image.Internal (maxIntensity)

import Data.Image.Convolution (convolveRows,convolveCols)

type Image = GrayImage

readPgm :: FilePath -> IO Image
readPgm = readImage

force :: Image -> IO Image
force image = do
    maxIntensity image `seq` return image

threshold :: Image -> Image
threshold = toBinaryImage (<127)

mean :: Image -> Image
mean = fmap (/25) . convolveCols [1,1,1,1,1] . convolveRows [1,1,1,1,1]
