module HaskellImageProcessingBenchmark.Friday where

import qualified Vision.Image.Grey as Friday (Grey)
import qualified Vision.Image.Storage as Friday (load)
import qualified Vision.Image.Type as Friday (convert)

type Image = Friday.Grey

readImage :: FilePath -> IO Image
readImage filepath = do
    Right image <- Friday.load Nothing filepath
    return (Friday.convert image)


