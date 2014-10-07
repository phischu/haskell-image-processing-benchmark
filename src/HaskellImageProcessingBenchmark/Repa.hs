module HaskellImageProcessingBenchmark.Repa (
    Image,readImage) where

import qualified Data.Array.Repa.IO.DevIL as Repa (readImage,Image(Grey),runIL)
import qualified Data.Array.Repa as Repa (Array,DIM2)
import qualified Data.Array.Repa.Repr.ForeignPtr as Repa (F)

import Data.Word (Word8)


type Image = Repa.Array Repa.F Repa.DIM2 Word8

readImage :: FilePath -> IO Image
readImage filepath = Repa.runIL (do
   Repa.Grey image <- Repa.readImage filepath
   return image)


