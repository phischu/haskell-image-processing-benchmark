module HaskellImageProcessingBenchmark.UnmHip (
    Image,readPgm,threshold) where

import Data.Image.Boxed (GrayImage,readImage,toBinaryImage)

type Image = GrayImage

readPgm :: FilePath -> IO Image
readPgm = readImage

threshold :: Image -> Image
threshold = toBinaryImage (<127)
