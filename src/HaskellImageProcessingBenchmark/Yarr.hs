module HaskellImageProcessingBenchmark.Yarr (
    Image,readPng) where

import Data.Yarr (UArray,F,L,Dim2)
import Data.Yarr.IO.Image (readImage)
import qualified Data.Yarr.IO.Image as Yarr (Image(Grey))
import Data.Word (Word8)

type Image = UArray F L Dim2 Word8

readPng :: FilePath -> IO Image
readPng filepath = do
    Yarr.Grey image <- readImage filepath
    return image


