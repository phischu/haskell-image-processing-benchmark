module HaskellImageProcessingBenchmark.OpenCV (
    readPng) where

import Foreign.C.String (CString,withCString)
import Foreign.Ptr (Ptr)

foreign import ccall "readPng" opencv_readPng :: CString -> IO Image

data CvMat

type Image = Ptr CvMat

readPng :: FilePath -> IO Image
readPng filepath = withCString filepath opencv_readPng

