module HaskellImageProcessingBenchmark.UnmHip (
    Image,readPgm,threshold,mean) where

import Data.Image.Boxed (GrayImage,readImage,toBinaryImage)

import Data.Image.Convolution (convolveRows,convolveCols)

import Control.DeepSeq (force)
import Control.Exception (evaluate)

type Image = GrayImage

readPgm :: FilePath -> IO Image
readPgm filepath = do
    image <- readImage filepath
    evaluate (force image)

{-# INLINE threshold #-}
threshold :: Image -> Image
threshold = toBinaryImage (<127)

{-# INLINE mean #-}
mean :: Image -> Image
mean = fmap (/25) . convolveCols [1,1,1,1,1] . convolveRows [1,1,1,1,1]
