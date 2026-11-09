--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}

import Data.Monoid (mappend)
import Hakyll

--------------------------------------------------------------------------------
config :: Configuration
config =
    defaultConfiguration
        { destinationDirectory = "docs"
        }

main :: IO ()
main = hakyllWith config $ do
    match "css/*" $ do
        route idRoute
        compile compressCssCompiler

    match "fonts/*" $ do
        route idRoute
        compile copyFileCompiler

    match "files/*" $ do
        route idRoute
        compile copyFileCompiler

    match "CNAME" $ do
        route idRoute
        compile copyFileCompiler

    (match . fromList) ["index.md", "research.md"] $ do
        route $ setExtension "html"
        compile $
            pandocCompiler
                >>= loadAndApplyTemplate "templates/default.html" defaultContext
                >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler
