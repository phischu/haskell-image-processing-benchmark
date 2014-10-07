module Main where

import Criterion (bgroup,bench,whnfIO)
import Criterion.Main (defaultMain)

import qualified HaskellImageProcessingBenchmark.Friday as Friday (
    readPng)
import qualified HaskellImageProcessingBenchmark.UnmHip as UnmHip (
    readPgm)
import qualified HaskellImageProcessingBenchmark.Yarr as Yarr (
    readPng)
import qualified HaskellImageProcessingBenchmark.Repa as Repa (
    readPng)
import qualified HaskellImageProcessingBenchmark.OpenCV as OpenCV (
    readPng)

main :: IO ()
main = defaultMain [
    bgroup "readPng" [
        bench "Friday" (whnfIO (Friday.readPng "koblenz.png")),
        bench "Yarr"   (whnfIO (Yarr.readPng "koblenz.png")),
        bench "Repa"   (whnfIO (Repa.readPng "koblenz.png")),
        bench "OpenCV" (whnfIO (OpenCV.readPng "koblenz.png"))],
    bgroup "readPgm" [
        bench "UnmHip" (whnfIO (UnmHip.readPgm "koblenz.pgm"))]]



