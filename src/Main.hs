module Main where

import Criterion (bgroup,bench,whnfIO)
import Criterion.Main (defaultMain)

import qualified HaskellImageProcessingBenchmark.Friday as Friday (
    readImage)
import qualified HaskellImageProcessingBenchmark.UnmHip as UnmHip (
    readImage)
import qualified HaskellImageProcessingBenchmark.Yarr as Yarr (
    readImage)
import qualified HaskellImageProcessingBenchmark.Repa as Repa (
    readImage)

main :: IO ()
main = defaultMain [
    bgroup "Image reading" [
        bench "Friday" (whnfIO (Friday.readImage "koblenz.png")),
        bench "UnmHip" (whnfIO (UnmHip.readImage "koblenz.pgm")),
        bench "Yarr"   (whnfIO (Yarr.readImage "koblenz.png")),
        bench "Repa"   (whnfIO (Repa.readImage "koblenz.png"))]]



