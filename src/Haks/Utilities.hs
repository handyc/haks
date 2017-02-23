module Haks.Utilities where

import BasicPrelude

fromBool :: Bool -> a -> Maybe a
fromBool p = if p then Just else const Nothing
