module HaskellImageProcessingBenchmark.UnmHip (
    Image,readImage) where

import Data.Image.Boxed (GrayImage)
import qualified Data.Image.Boxed as UnmHip (readImage)

type Image = GrayImage

readImage :: FilePath -> IO Image
readImage = UnmHip.readImage


