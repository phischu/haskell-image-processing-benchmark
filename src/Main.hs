module Main where

import Criterion (bgroup,bench,whnfIO)
import Criterion.Main (defaultMain)

import qualified Vision.Image.Grey as Friday (Grey)
import qualified Vision.Image.Storage as Friday (load)
import qualified Vision.Image.Type as Friday (convert)
import qualified Vision.Image.Filter as Friday (blur)

import qualified Data.Image.Boxed as UnmHip (GrayImage,readImage)
import qualified Data.Image.Convolution as UnmHip (convolve)

import qualified Data.Yarr as Yarr (UArray,F,L,Dim2)
import qualified Data.Yarr.IO.Image as Yarr (readImage,Image(Grey))
import qualified Data.Yarr.Convolution as Yarr (dConvolveShDim2WithStaticStencil)

import qualified Data.Array.Repa.IO.DevIL as Repa (readImage,Image(Grey),runIL)
import qualified Data.Array.Repa as Repa (Array,DIM2)
import qualified Data.Array.Repa.Repr.ForeignPtr as Repa (F)
import qualified Data.Array.Repa.Algorithms.Convolve as Repa (convolveOutP,outClamp)

import Data.Word (Word8)

type FridayImage = Friday.Grey

readFriday :: FilePath -> IO FridayImage
readFriday filepath = do
    Right image <- Friday.load Nothing filepath
    return (Friday.convert image)

type UnmHipImage = UnmHip.GrayImage

readUnmHip :: FilePath -> IO UnmHipImage
readUnmHip filepath = do
    image <- UnmHip.readImage filepath
    return (fmap (+0) image)

type YarrImage = Yarr.UArray Yarr.F Yarr.L Yarr.Dim2 Word8

readYarr :: FilePath -> IO YarrImage
readYarr filepath = do
    Yarr.Grey image <- Yarr.readImage filepath
    return image

type RepaImage = Repa.Array Repa.F Repa.DIM2 Word8

readRepa :: FilePath -> IO RepaImage
readRepa filepath = Repa.runIL (do
   Repa.Grey image <- Repa.readImage filepath
   return image)

main :: IO ()
main = defaultMain [
    bgroup "Image reading" [
        bench "Friday" (whnfIO (readFriday "koblenz.png")),
        bench "UnmHip" (whnfIO (readUnmHip "koblenz.pgm")),
        bench "Yarr"   (whnfIO (readYarr "koblenz.png")),
        bench "Repa"   (whnfIO (readRepa "koblenz.png"))]]



