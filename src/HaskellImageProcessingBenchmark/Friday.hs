module HaskellImageProcessingBenchmark.Friday (
    Image,readPng) where

import Vision.Image.Grey (Grey)
import Vision.Image.Storage (load)
import Vision.Image.Type (convert)

type Image = Grey

readPng :: FilePath -> IO Image
readPng filepath = do
    Right image <- load Nothing filepath
    return (convert image)


