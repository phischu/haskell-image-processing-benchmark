module HaskellImageProcessingBenchmark.OpenCV (
    readPng,threshold,mean) where

import Foreign.C.String (CString,withCString)
import Foreign.Ptr (Ptr,FunPtr)
import Foreign.ForeignPtr (ForeignPtr,newForeignPtr,withForeignPtr)

foreign import ccall "&finalizeImage" opencv_finalizeImage :: FunPtr (Ptr IPLImage -> IO ())

foreign import ccall "readPng" opencv_readPng :: CString -> IO (Ptr IPLImage)

foreign import ccall "threshold" opencv_threshold :: Ptr IPLImage -> IO (Ptr IPLImage)

foreign import ccall "mean" opencv_mean :: Ptr IPLImage -> IO (Ptr IPLImage)

data IPLImage

type Image = ForeignPtr IPLImage

addImageFinalizer :: Ptr IPLImage -> IO (ForeignPtr IPLImage)
addImageFinalizer = newForeignPtr opencv_finalizeImage

readPng :: FilePath -> IO Image
readPng filepath = do
    imagePtr <- withCString filepath opencv_readPng
    addImageFinalizer imagePtr

threshold :: Image -> IO Image
threshold = withImage opencv_threshold

mean :: Image -> IO Image
mean = withImage opencv_mean

withImage :: (Ptr IPLImage -> IO (Ptr IPLImage)) -> Image -> IO Image
withImage f image = withForeignPtr image (\imagePtr -> do
    f imagePtr >>= addImageFinalizer)
