module HaskellImageProcessingBenchmark.UnmHip (
    Image,readPgm) where

import Data.Image.Boxed (GrayImage,readImage)

type Image = GrayImage

readPgm :: FilePath -> IO Image
readPgm = readImage


