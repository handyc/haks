module Haks.Utilities where

import BasicPrelude

import Haks.Types

fromBool :: Bool -> a -> Maybe a
fromBool p = if p then Just else const Nothing

oneSpace :: [(Token,Text)] -> [(Token,Text)]
oneSpace []                       = []
oneSpace ((Space,_):(Space,y):xs) = (Space,y):oneSpace xs
oneSpace (x:xs)                   = x:oneSpace xs

