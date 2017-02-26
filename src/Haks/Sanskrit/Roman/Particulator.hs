{-# LANGUAGE ViewPatterns #-}
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

consonants :: [Char]
consonants = [ 'k','h','g','ṅ','c','j','ñ','ṭ','ḍ','ṇ','t','d','n','p','b','m'
             , 'y','r','l','v','ś','ṣ','s']

vowels :: [Char]
vowels = ['a','i','u','e','o','ā','ī','ū','ṛ','ṝ','ḷ','ḹ']

terminals :: [Char]
terminals =['ṁ','ṃ','ḥ']
