{-# LANGUAGE QuasiQuotes #-}
module HaskellImageProcessingBenchmark.Yarr (
    Image,readPng,force,threshold,mean) where

import Data.Yarr (UArray,D,F,L,Dim2,delay)
import Data.Yarr.IO.Image (readImage)
import qualified Data.Yarr.IO.Image as Yarr (Image(Grey))
import Data.Word (Word8)

import Data.Yarr.Eval (dComputeP)
import Data.Yarr.Flow (dmap)

import Data.Yarr.Convolution (dConvolveLinearDim2WithStaticStencil,dim2St)

type Image = UArray D L Dim2 Word8

readPng :: FilePath -> IO Image
readPng filepath = do
    Yarr.Grey image <- readImage filepath
    return (delay image)

force :: Image -> IO (UArray F L Dim2 Word8)
force = dComputeP

threshold :: Image -> Image
threshold = dmap (\value -> if value > 127 then 255 else 0)

mean :: Image -> IO Image
mean image = do
    convolvedImage <- dComputeP (dConvolveLinearDim2WithStaticStencil meanStencil image)
    return (delay (convolvedImage :: UArray F L Dim2 Word8))

meanStencil = [dim2St| 1 1 1 1 1
                       1 1 1 1 1
                       1 1 1 1 1
                       1 1 1 1 1
                       1 1 1 1 1|]
