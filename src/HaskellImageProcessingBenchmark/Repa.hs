{-# LANGUAGE TypeOperators #-}
module HaskellImageProcessingBenchmark.Repa (
    Image,readPng,force,threshold,mean) where

import Data.Array.Repa.IO.DevIL (readImage,runIL)
import qualified Data.Array.Repa.IO.DevIL as Repa (Image(Grey))
import Data.Array.Repa (Array,D,DIM2,delay,computeP,Z(Z),(:.)((:.)),deepSeqArray)
import Data.Array.Repa.Repr.Unboxed (U,fromListUnboxed)

import qualified Data.Array.Repa as Repa (map)

import Data.Array.Repa.Algorithms.Convolve (convolveOutP,outClamp)

import Data.Word (Word8)

type Image = Array D DIM2 Word8

readPng :: FilePath -> IO Image
readPng filepath = runIL (do
   Repa.Grey image <- readImage filepath
   return (delay image))

force :: Image -> IO (Array U DIM2 Word8)
force image = do
    forcedImage <- computeP image
    forcedImage `deepSeqArray` return forcedImage

threshold :: Image -> Image
threshold = Repa.map (\value -> if value > 127 then 255 else 0)

mean :: Image -> IO Image
mean image = do
    intImage <- computeP (Repa.map fromIntegral image)
    rowConvolvedImage <- convolveOutP outClamp rowMeanStencil intImage
    convolvedImage <- convolveOutP outClamp colMeanStencil rowConvolvedImage
    grayImage <- computeP (Repa.map (fromIntegral . (`div` 25)) convolvedImage)
    return (delay (grayImage :: Array U DIM2 Word8))

rowMeanStencil :: Array U DIM2 Int
rowMeanStencil = fromListUnboxed (Z:.1:.5) [1,1,1,1,1]

colMeanStencil :: Array U DIM2 Int
colMeanStencil = fromListUnboxed (Z:.5:.1) [1,1,1,1,1]
