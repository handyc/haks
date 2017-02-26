module Haks.Chinese.Particulator where

import BasicPrelude hiding (empty,all)

import Data.Char
import Data.Text
import Haks.Types
import Haks.Utilities

particlate :: Text -> [Particle] -> [(Token,Char)] -> [Particle]
particlate _ _ []            = []
particlate _ _ ((_,char):xs) = (pack $ char : []):(particlate empty [] xs)

tokenizer :: Char -> Maybe (Token,Char)
tokenizer tok = (,) Chinese <$> fromBool isTok tok
  where
    isTok       = notAlphaNum && notJunk && notSpace
    notJunk     = not (tok `elem` not_tokens)
    notSpace    = not (isSpace tok)
    notAlphaNum = isAlphaNum tok

chinese_config :: ParticleConfig
chinese_config = ParticleConfig 
  { pre_processor_hc = id
  , tokenizer_hc     = tokenizer
  , cleanup_hc       = id
  , particlate_hc    = particlate
  }

not_tokens = [ ' ', '。', '.', '\n', '-', ',', '/', '(', '\\', '║', '=', ':'
             , '#', '_', '\r', '【', '】', ',', '》', '，', '　', '、', '：'
             , '「', '」', '？', '！', '；', '『', '』', '）', '（', '．', '…'
             , '○', ']', '[', '*', '《', '+', '／', '〉', '〈', '◇']

test :: [Char]
test = '夫':'宗':'極':'絕':'於':'稱':'謂':'賢':'聖':'以':'之':'沖':'默':'玄':'旨':'非':'言':'不':'傳' : []
