{-# LANGUAGE ViewPatterns #-}
{-# LANGUAGE PatternGuards #-}

module Haks.Sanskrit.Roman.Particulator where

import BasicPrelude hiding (empty,all,null)

import Data.Char
import Data.Text hiding (reverse,head)
import Haks.Types

tokenizer :: Char -> Maybe (Token,Char)
tokenizer tok
  | isConsonant = Just (SANSKRIT_ROMAN SKTR_CONSONANT, tok)
  | isVowel     = Just (SANSKRIT_ROMAN SKTR_VOWEL, tok)
  | isDigit tok = Just (SANSKRIT_ROMAN SKTR_DIGIT, tok)
  | isTerminal  = Just (SANSKRIT_ROMAN SKTR_TERMINAL, tok)
  | otherwise   = Nothing
  where
    isConsonant = tok `elem` consonants
    isVowel     = tok `elem` vowels
    isTerminal  = tok `elem` terminals

particulate :: Text -> [Particle] -> [(Token,Char)] -> [Particle]
particulate (null -> True) particles [] = reverse particles
particulate newp@(null -> True) [] (((x,_):xs) -> x == SANSKRIT_ROMAN SKTR_VOWEL) = undefined
--  ((SANSKRIT_ROMAN SKTR_CONSONANT,tok):xs) = undefined
particulate newp@(null -> True) [] ((SANSKRIT_ROMAN SKTR_VOWEL,tok):xs) = undefined
particulate emptyp@(null -> True) [] (_:xs) = particulate emptyp [] xs

particulate particle particles ((SANSKRIT_ROMAN SKTR_TERMINAL,term):xs) = undefined

-- particulate particle particles 
consonants :: [Char]
consonants = [ 'k','h','g','ṅ','c','j','ñ','ṭ','ḍ','ṇ','t','d','n','p','b','m'
             , 'y','r','l','v','ś','ṣ','s']

vowels :: [Char]
vowels = ['a','i','u','e','o','ā','ī','ū','ṛ','ṝ','ḷ','ḹ']

terminals :: [Char]
terminals =['ṁ','ṃ','ḥ']
{-
find_begining :: [(Token,Char)] -> [(Token,Char)]
find_begining (x:xs) = case (fst x) of
  (SANSKRIT_ROMAN SKTR_CONSONANT) -> ((SANSKRIT_ROMAN SKTR_START, snd x):xs)
  (SANSKRIT_ROMAN SKTR_VOWEL)     -> ((SANSKRIT_ROMAN SKTR_START, snd x):xs)
  otherwise                       -> find_begining xs
-}
