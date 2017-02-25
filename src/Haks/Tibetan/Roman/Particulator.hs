{-# LANGUAGE ViewPatterns #-}
module Haks.Tibetan.Roman.Particulator where

import BasicPrelude hiding (filter,all,null,empty)

import Data.Text hiding (reverse)
import Data.Char hiding (Space)

import Haks.Types
import Haks.Utilities


tokenizer :: Text -> Maybe (Token, Text)
tokenizer tok 
  | isAlpha' = Just (TIBETAN_ROMAN, tok)
  | tok == "\'" = Just (TIBETAN_ROMAN, tok)
  | isSpace'    = Just (Space,tok)
  | otherwise   = Nothing
  where
    isTok = isAlpha' || isSpace'
    isAlpha' = all isAlpha tok
    isSpace'    = all isSpace tok

oneSpace :: [(Token,Text)] -> [(Token,Text)]
oneSpace []                       = []
oneSpace ((Space,_):(Space,y):xs) = (Space,y):oneSpace xs
oneSpace (x:xs)                   = x:oneSpace xs

particulate :: Text -> [Particle] -> [(Token,Text)] -> [Particle]
particulate (null -> True) particles [] = reverse particles
particulate particle particles ((Space,_):xs) = 
  (particle:particles) ++ (particulate empty [] xs)
particulate particle particles ((_,char):xs) = particulate (particle `append` char) particles xs
particulate _ _ [] = []

tibetan_r :: ParticleConfig
tibetan_r = ParticleConfig
  { tokenizer_hc = tokenizer
  , particlate_hc = particulate
  }
test :: [Text]
test = ["@","1","B"," ","*",","," ",",","'","D","U","L"," ","'","D","Z","I","N"," ","C","H","E","N"," ","P","O"," ","G","N","A","S"," ","B","R","T","A","N"," ","N","Y","E"," ","B","A","R"," ","'","K","H","O","R",","," ",","]
