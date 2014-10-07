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

main :: IO ()
main = defaultMain [
    bgroup "read png" [
        bench "Friday" (whnfIO (Friday.readPng "koblenz.png")),
        bench "Yarr"   (whnfIO (Yarr.readPng "koblenz.png")),
        bench "Repa"   (whnfIO (Repa.readPng "koblenz.png"))],
    bgroup "read pgm" [
        bench "UnmHip" (whnfIO (UnmHip.readPgm "koblenz.pgm"))]]



