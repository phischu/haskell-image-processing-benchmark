module HaskellImageProcessingBenchmark.Yarr (
    Image,readImage) where


import Data.Yarr (UArray,F,L,Dim2)
import qualified Data.Yarr.IO.Image as Yarr (Image(Grey),readImage)
import Data.Word (Word8)

type Image = UArray F L Dim2 Word8

readImage :: FilePath -> IO Image
readImage filepath = do
    Yarr.Grey image <- Yarr.readImage filepath
    return image


