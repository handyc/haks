{-# LANGUAGE ViewPatterns #-}
module Haks.Tibetan.Uchen.Particulator where

import BasicPrelude hiding (empty,all,null)

import Data.Char
import Data.Text hiding (reverse,head)
import Data.Monoid
import Haks.Types 
import Haks.Utilities

preProcessor :: [Char] -> [Char]
preProcessor [] = []
preProcessor corpus@(x:xs) 
  | (x `elem` shad) || (x `elem` tsheg) = xs
  | otherwise                           = corpus

tokenizer :: Char -> Maybe (Token,Char)
tokenizer tok
  | isShad      = Just (TIBETAN_UCHEN TSheg, head tsheg)
  | isTsheg     = Just (TIBETAN_UCHEN TSheg, tok)
  | isAlphaNum' = Nothing
  | isGarbage   = Nothing -- FIXME, redundant with Latin1 in some cases
  | otherwise   = Just (TIBETAN_UCHEN StdChar_UC, tok)
  where
    isAlphaNum' = isLatin1 tok
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
  { pre_processor_hc = preProcessor
  , tokenizer_hc     = tokenizer
  , cleanup_hc       = oneTsheg
  , particlate_hc    = particulate
  }

oneTsheg :: [(Token,Char)] -> [(Token,Char)]
oneTsheg [] = []
oneTsheg (tsheg'@(TIBETAN_UCHEN TSheg,_):(TIBETAN_UCHEN TSheg,_):xs) = 
  tsheg':oneTsheg xs
oneTsheg (x:xs) = x:oneTsheg xs

not_token :: String
not_token = ['.','\n','-',',','/','(',')','\\','║','=',':' 
             ,'#','_','\r','【','】','[',']',',','》']

