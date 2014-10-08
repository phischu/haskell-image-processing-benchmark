module HaskellImageProcessingBenchmark.Repa (
    Image,readPng,force,threshold) where

import Data.Array.Repa.IO.DevIL (readImage,runIL)
import qualified Data.Array.Repa.IO.DevIL as Repa (Image(Grey))
import Data.Array.Repa (Array,D,DIM2,delay,computeP)
import Data.Array.Repa.Repr.Unboxed (U)

import qualified Data.Array.Repa as Repa (map)

import Data.Word (Word8)

type Image = Array D DIM2 Word8

readPng :: FilePath -> IO Image
readPng filepath = runIL (do
   Repa.Grey image <- readImage filepath
   return (delay image))

force :: Image -> IO Image
force image = do
    forcedImage <- computeP image
    return (delay (forcedImage :: Array U DIM2 Word8))

threshold :: Image -> Image
threshold = Repa.map (\value -> if value > 127 then 255 else 0)
