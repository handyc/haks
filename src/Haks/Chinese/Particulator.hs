module Haks.Chinese.Particulator where

import BasicPrelude hiding (empty,all)

import Data.Char
import Data.Text
import Haks.Types
import Haks.Utilities

particlate :: Text -> [Particle] -> [(Token,Text)] -> [Particle]
particlate _ _ []            = []
particlate _ _ ((_,char):xs) = char:(particlate empty [] xs)

tokenizer :: Text -> Maybe (Token,Text)
tokenizer tok = (,) Chinese <$> fromBool isTok tok
  where
    isTok       = notAlphaNum && notJunk
    notJunk     = not (tok `elem` not_tokens)
    notAlphaNum = all (isAlphaNum) tok


chinese_config :: ParticleConfig
chinese_config = ParticleConfig 
  { tokenizer_hc  = tokenizer
  , particlate_hc   = particlate
  }

not_tokens :: [Text]
not_tokens = [ " ", "。", ".", "\n", "-", ",", "/", "(", "\\", "║", "=", ":"
             , "#", "_", "\r", "【", "】", ",", "》", "，", "　", "、", "："
             , "「", "」", "？", "！", "；", "『", "』", "）", "（", "．", "…"
             , "○", "]", "[", "*", "《", "+", "／", "〉", "〈", "◇"]

test :: [Text]
test = "夫":"宗":"極":"絕":"於":"稱":"謂":"賢":"聖":"以":"之":"沖":"默":"玄":"旨":"非":"言":"不":"傳" : []
