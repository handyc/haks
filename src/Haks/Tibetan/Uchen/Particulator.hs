module Haks.Tibetan.Uchen.Particulator where

import BasicPrelude hiding (empty,all)

import Data.Char
import Data.Text
import Haks.Types
import Haks.Utilities




tokenizer :: Text -> Maybe (Token,Text)
tokenizer tok
  | isAlphaNum' = Nothing
  | isSpace'    = Nothing
  | isGarbage   = Nothing
  | isShad      = Just (TIBETAN_UCHEN Shad, tok)
  | isTsheg     = Just (TIBETAN_UCHEN TSheg, tok)
  | otherwise   = Just (TIBETAN_UCHEN StdChar_UC, tok)
  where
    isAlphaNum' = all isAlphaNum tok
    isSpace'    = all isSpace tok
    isShad      = tok `elem` shad
    isTsheg     = tok `elem` tsheg
    isGarbage   = tok `elem` not_token

shad :: [Text]
shad = ["།","༑"]

tsheg :: [Text]
tsheg = ["་","༌"]

not_token :: [Text]
not_token = ["།"
            ,"."
            ,"\n"
            ,"-"
            ,","
            ,"/"
            ,"("
            ,")"
            ,"\\"
            ,"║"
            ,"="
            ,":"
            ,"#"
            ,"_"
            ,"\n"
            ,"\r"
            ,"【"
            ,"】"
            ,"["
            ,"]"
            ,","
            ,"》"]
