module Haks.Chinese.Tokenizer where

import BasicPrelude hiding (filter)
import Data.Text
import Data.Char

import Haks.Types
import Haks.Chinese.Types
import Haks.Utilities

chineseTokenizer :: Text -> Maybe (Token,Text)
chineseTokenizer tok = (,) Chinese <$> fromBool isTok tok
  where
    isTok = tok == notAlphaNum && notJunk
    notJunk     = not (tok `elem` not_tokens)
    notAlphaNum = filter (not . isAlphaNum) tok

not_tokens :: [Text]
not_tokens = [ " ", "。", ".", "\n", "-", ",", "/", "(", "\\", "║", "=", ":"
             , "#", "_", "\r", "【", "】", ",", "》", "，", "　", "、", "："
             , "「", "」", "？", "！", "；", "『", "』", "）", "（", "．", "…"
             , "○", "]", "[", "*", "《", "+", "／", "〉", "〈", "◇"]

