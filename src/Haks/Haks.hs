module Haks.Haks where

import BasicPrelude hiding (filter)
import Data.Text
import Data.Char
import Haks.Types

charCheck :: (Text -> Maybe b) -> Text -> b
charCheck = error ("charCheck undefined")

chineseTokenizer :: Text -> Maybe ChineseToken
chineseTokenizer tok = ChineseToken <$> fromBool isTok tok
  where
    isTok = tok == notAlphaNum && notJunk
    notJunk     = not (tok `elem` not_tokens)
    notAlphaNum = filter (not . isAlphaNum) tok
    

not_tokens :: [Text]
not_tokens = [ " ", "。", ".", "\n", "-", ",", "/", "(", "\\", "║", "=", ":"
             , "#", "_", "\r", "【", "】", ",", "》", "，", "　", "、", "："
             , "「", "」", "？", "！", "；", "『", "』", "）", "（", "．", "…"
             , "○", "]", "[", "*", "《", "+", "／", "〉", "〈", "◇"]

fromBool :: Bool -> a -> Maybe a
fromBool p = if p then Just else const Nothing

