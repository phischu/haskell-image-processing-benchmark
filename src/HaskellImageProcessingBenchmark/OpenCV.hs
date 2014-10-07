module HaskellImageProcessingBenchmark.OpenCV (
    readPng) where


foreign import ccall "foo" foo :: Int -> IO Int

type Image =  ()

readPng :: FilePath -> IO Image
readPng _ = do
    foo 5 >>= print


