{-# LANGUAGE ViewPatterns #-}
module Haks.Tibetan.Uchen.Particulator where

import BasicPrelude hiding (empty,all,null)

import Data.Char
import Data.Text hiding (reverse,head)
import Data.Monoid
import Haks.Types 
import Haks.Utilities

tokenizer :: Char -> Maybe (Token,Char)
tokenizer tok
  | isShad      = Just (TIBETAN_UCHEN TSheg, head tsheg)
  | isTsheg     = Just (TIBETAN_UCHEN TSheg, tok)
  | isAlphaNum' = Nothing
  | isSpace'    = Nothing
  | isGarbage   = Nothing
  | otherwise   = Just (TIBETAN_UCHEN StdChar_UC, tok)
  where
    isAlphaNum' = (not . isAlphaNum) tok
    isSpace'    = isSpace tok
    isShad      = tok `elem` shad
    isTsheg     = tok `elem` tsheg
    isGarbage   = tok `elem` not_token

particulate :: Text -> [Particle] -> [(Token,Char)] -> [Particle]
particulate (null -> True) particles [] = reverse particles
particulate particle particles ((TIBETAN_UCHEN TSheg,tsheg'):xs) =
  (syllable_marker:particles) <> (particulate empty [] xs)
  where
    syllable_marker = particle <> (pack $ tsheg' : [])
particulate particle particles ((TIBETAN_UCHEN StdChar_UC,char):xs) =
  particulate (particle `append` (pack $ char : [])) particles xs
particulate _ _ _ = []
  
shad :: String
shad = ['།','༑']

tsheg :: String
tsheg = ['་','༌']

tibetan_u :: ParticleConfig
tibetan_u = ParticleConfig
  { tokenizer_hc = tokenizer
  , particlate_hc = particulate
  }

not_token :: String
not_token = ['.','\n','-',',','/','(',')','\\','║','=',':' 
             ,'#','_','\r','【','】','[',']',',','》']

