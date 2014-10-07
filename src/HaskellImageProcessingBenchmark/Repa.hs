module HaskellImageProcessingBenchmark.Repa (
    Image,readPng) where

import Data.Array.Repa.IO.DevIL (readImage,runIL)
import qualified Data.Array.Repa.IO.DevIL as Repa (Image(Grey))
import qualified Data.Array.Repa as Repa (Array,DIM2)
import qualified Data.Array.Repa.Repr.ForeignPtr as Repa (F)

import Data.Word (Word8)

type Image = Repa.Array Repa.F Repa.DIM2 Word8

readPng :: FilePath -> IO Image
readPng filepath = runIL (do
   Repa.Grey image <- readImage filepath
   return image)


