{-# LANGUAGE ViewPatterns #-}
module Haks.Tibetan.Uchen.Particulator where

import BasicPrelude hiding (empty,all,null)

import Data.Char
import Data.Monoid
import Data.Text hiding (head,reverse)
import Haks.Types 
import Haks.Utilities

tokenizer :: Text -> Maybe (Token,Text)
tokenizer tok
  | isAlphaNum' = Nothing
  | isSpace'    = Nothing
  | isGarbage   = Nothing
  | isShad      = Just (TIBETAN_UCHEN TSheg, head tsheg)
  | isTsheg     = Just (TIBETAN_UCHEN TSheg, tok)
  | otherwise   = Just (TIBETAN_UCHEN StdChar_UC, tok)
  where
    isAlphaNum' = all isAlphaNum tok
    isSpace'    = all isSpace tok
    isShad      = tok `elem` shad
    isTsheg     = tok `elem` tsheg
    isGarbage   = tok `elem` not_token

particulate :: Text -> [Particle] -> [(Token,Text)] -> [Particle]
particulate (null -> True) particles [] = reverse particles
particulate particle particles ((TIBETAN_UCHEN TSheg,tsheg):xs) =
  (syllable_marker:particles) <> (particulate empty [] xs)
  where
    syllable_marker = particle <> tsheg
particulate particle particles ((TIBETAN_UCHEN StdChar_UC,char):xs) =
  particulate (particle `append` char) particles xs
particulate _ _ _ = []
  


shad :: [Text]
shad = ["།","༑"]

tsheg :: [Text]
tsheg = ["་","༌"]

not_token :: [Text]
not_token = [ "།",".","\n","-",",","/","(",")","\\","║","=",":" 
             ,"#","_","\r","【","】","[","]",",","》"]
