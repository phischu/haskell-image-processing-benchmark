module Main where

import Criterion (bgroup,bench,whnfIO,whnf,nf)
import Criterion.Main (defaultMain)

import qualified HaskellImageProcessingBenchmark.Friday as Friday (
    readPng,threshold,mean)
import qualified HaskellImageProcessingBenchmark.UnmHip as UnmHip (
    readPgm,threshold,mean)
import qualified HaskellImageProcessingBenchmark.Yarr as Yarr (
    readPng,force,threshold,mean)
import qualified HaskellImageProcessingBenchmark.Repa as Repa (
    readPng,force,threshold,mean)
import qualified HaskellImageProcessingBenchmark.OpenCV as OpenCV (
    readPng,threshold,mean)

main :: IO ()
main = do
    fridayImage <- Friday.readPng "koblenz.png"
    unmHipImage <- UnmHip.readPgm "koblenz.pgm"
    yarrImage   <- Yarr.readPng   "koblenz.png"
    repaImage   <- Repa.readPng   "koblenz.png"
    openCVImage <- OpenCV.readPng "koblenz.png"
    defaultMain [
        bgroup "readPng" [
            bench "Friday" (whnfIO (Friday.readPng "koblenz.png")),
            bench "Yarr"   (whnfIO (Yarr.readPng   "koblenz.png")),
            bench "Repa"   (whnfIO (Repa.readPng   "koblenz.png")),
            bench "OpenCV" (whnfIO (OpenCV.readPng "koblenz.png"))],
        bgroup "threshold" [
            bench "Friday" (whnf Friday.threshold fridayImage),
            bench "UnmHip" (nf UnmHip.threshold unmHipImage),
            bench "Yarr"   (whnfIO (Yarr.force   (Yarr.threshold   yarrImage))),
            bench "Repa"   (whnfIO (Repa.force   (Repa.threshold   repaImage))),
            bench "OpenCV" (whnfIO (OpenCV.threshold openCVImage))],
        bgroup "mean" [
            bench "Friday" (whnf Friday.mean fridayImage),
-- too slow            bench "UnmHip" (nf UnmHip.mean unmHipImage),
            bench "Yarr"   (whnfIO (Yarr.mean yarrImage)),
            bench "Repa"   (whnfIO (Repa.mean repaImage)),
            bench "OpenCV" (whnfIO (OpenCV.mean openCVImage))]]



