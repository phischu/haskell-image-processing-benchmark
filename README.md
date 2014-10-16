haskell-image-processing-benchmark
==================================

Let's benchmark different image processing libraries for Haskell

Installation:

    git clone https://github.com/jcollard/unm-hip
    git clone https://github.com/phischu/haskell-image-processing-benchmark
    cd haskell-image-processing-benchmark
    cabal sandbox init
    cabal sandbox add-source ../unm-hip
    cabal install
    .cabal-sandbox/bin/haskell-image-processing-benchmark
