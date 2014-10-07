module Main where

import Criterion (bgroup,bench,whnfIO,whnf)
import Criterion.Main (defaultMain)

import qualified HaskellImageProcessingBenchmark.Friday as Friday (
    readPng,threshold)
import qualified HaskellImageProcessingBenchmark.UnmHip as UnmHip (
    readPgm,threshold)
import qualified HaskellImageProcessingBenchmark.Yarr as Yarr (
    readPng)
import qualified HaskellImageProcessingBenchmark.Repa as Repa (
    readPng)
import qualified HaskellImageProcessingBenchmark.OpenCV as OpenCV (
    readPng)

main :: IO ()
main = do
    fridayImage <- Friday.readPng "koblenz.png"
    unmHipImage <- UnmHip.readPgm "koblenz.pgm"
    defaultMain [
        bgroup "readPng" [
            bench "Friday" (whnfIO (Friday.readPng "koblenz.png")),
            bench "Yarr"   (whnfIO (Yarr.readPng "koblenz.png")),
            bench "Repa"   (whnfIO (Repa.readPng "koblenz.png")),
            bench "OpenCV" (whnfIO (OpenCV.readPng "koblenz.png"))],
        bgroup "readPgm" [
            bench "UnmHip" (whnfIO (UnmHip.readPgm "koblenz.pgm"))],
        bgroup "threshold" [
            bench "Friday" (whnf Friday.threshold fridayImage),
            bench "UnmHip" (whnf UnmHip.threshold unmHipImage)]]



