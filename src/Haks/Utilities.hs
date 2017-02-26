module Haks.Utilities where

import BasicPrelude

import Haks.Types

fromBool :: Bool -> a -> Maybe a
fromBool p = if p then Just else const Nothing
