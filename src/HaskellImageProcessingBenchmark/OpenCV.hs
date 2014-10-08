module HaskellImageProcessingBenchmark.OpenCV (
    readPng,threshold) where

import Foreign.C.String (CString,withCString)
import Foreign.Ptr (Ptr)

foreign import ccall "readPng" opencv_readPng :: CString -> IO Image

foreign import ccall "threshold" opencv_threshold :: Image -> IO Image

data IPLImage

type Image = Ptr IPLImage

readPng :: FilePath -> IO Image
readPng filepath = withCString filepath opencv_readPng

threshold :: Image -> IO Image
threshold = opencv_threshold
