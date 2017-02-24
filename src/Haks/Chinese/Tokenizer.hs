module Haks.Chinese.Tokenizer where

import BasicPrelude hiding (filter)
import Data.Text
import Data.Char

import Haks.Types
import Haks.Utilities

tokenizer :: Text -> Maybe (Token,Text)
tokenizer tok = (,) Chinese <$> fromBool isTok tok
  where
    isTok = tok == notAlphaNum && notJunk
    notJunk     = not (tok `elem` not_tokens)
    notAlphaNum = filter (isAlphaNum) tok

not_tokens :: [Text]
not_tokens = [ " ", "。", ".", "\n", "-", ",", "/", "(", "\\", "║", "=", ":"
             , "#", "_", "\r", "【", "】", ",", "》", "，", "　", "、", "："
             , "「", "」", "？", "！", "；", "『", "』", "）", "（", "．", "…"
             , "○", "]", "[", "*", "《", "+", "／", "〉", "〈", "◇"]

