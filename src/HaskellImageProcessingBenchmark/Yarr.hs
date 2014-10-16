{-# LANGUAGE QuasiQuotes #-}
module HaskellImageProcessingBenchmark.Yarr (
    Image,readPng,force,threshold,mean) where

import Data.Yarr (UArray,D,F,L,Dim2,delay)
import Data.Yarr.IO.Image (readImage)
import qualified Data.Yarr.IO.Image as Yarr (Image(Grey))
import Data.Word (Word8)

import Data.Yarr.Eval (dComputeP)
import Data.Yarr.Flow (dmap)

import Data.Yarr.Convolution (dConvolveLinearDim2WithStaticStencil,dim2St,Dim2Stencil,CV,CVL)
import Data.Yarr.Utils.FixedVector (N1,N5)

type Image = UArray D L Dim2 Word8

readPng :: FilePath -> IO Image
readPng filepath = do
    Yarr.Grey image <- readImage filepath
    return (delay image)

{-# INLINE force #-}
force :: Image -> IO (UArray F L Dim2 Word8)
force = dComputeP

{-# INLINE threshold #-}
threshold :: Image -> Image
threshold = dmap (\value -> if value > 127 then 255 else 0)

{-# INLINE mean #-}
mean :: Image -> IO Image
mean image = do

    let rowConvolvedImage = dConvolveLinearDim2WithStaticStencil
            rowMeanStencil (dmap fromIntegral image)
                :: UArray CV CVL Dim2 Int

    rowConvolvedComputedImage <- dComputeP rowConvolvedImage
        :: IO (UArray F L Dim2 Int)

    let convolvedImage = dConvolveLinearDim2WithStaticStencil
            colMeanStencil rowConvolvedComputedImage
                :: UArray CV CVL Dim2 Int

    convolvedComputedImage <- dComputeP (dmap (fromIntegral . (`div` 25)) convolvedImage)
        :: IO (UArray F L Dim2 Word8)

    return (delay convolvedComputedImage)

{-# INLINE rowMeanStencil #-}
rowMeanStencil :: Dim2Stencil N5 N1 Int (Int -> Int -> IO Int) Int
rowMeanStencil = [dim2St| 1 1 1 1 1 |]

{-# INLINE colMeanStencil #-}
colMeanStencil :: Dim2Stencil N1 N5 Int (Int -> Int -> IO Int) Int
colMeanStencil = [dim2St| 1
                          1
                          1
                          1
                          1 |]
