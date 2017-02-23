module Haks.Haks where

import BasicPrelude
import Haks.Types

charCheck :: (Text -> b) -> Text -> b
charCheck = error ("charCheck undefined")

chineseTokenizer :: Text -> Maybe ChineseToken
chineseTokenizer tok = ChineseToken <$> fromBool isTok tok
  where
    isTok = not (tok `elem` not_tokens)

not_tokens :: [Text]
not_tokens = [ " ", "。", ".", "\n", "-", ",", "/", "(", "\\", "║", "=", ":"
             , "#", "_", "\r", "【", "】", ",", "》", "，", "　", "、", "："
             , "「", "」", "？", "！", "；", "『", "』", "）", "（", "．", "…"
             , "○", "]", "[", "*", "《", "+", "／", "〉", "〈", "◇"]

fromBool :: Bool -> a -> Maybe a
fromBool p = if p then Just else const Nothing

