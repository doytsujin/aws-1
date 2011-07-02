{-# LANGUAGE RecordWildCards, TypeFamilies, FlexibleInstances, MultiParamTypeClasses, OverloadedStrings #-}
module Aws.SimpleDb.Commands.DeleteDomain
where

import           Aws.Response
import           Aws.Signature
import           Aws.SimpleDb.Info
import           Aws.SimpleDb.Metadata
import           Aws.SimpleDb.Query
import           Aws.SimpleDb.Response
import           Aws.Transaction
import qualified Data.ByteString.UTF8  as BU
import qualified Data.Text             as T
import qualified Data.Text.Encoding    as T

data DeleteDomain
    = DeleteDomain {
        ddDomainName :: T.Text
      }
    deriving (Show)

data DeleteDomainResponse
    = DeleteDomainResponse
    deriving (Show)
             
deleteDomain :: T.Text -> DeleteDomain
deleteDomain name = DeleteDomain { ddDomainName = name }
             
instance SignQuery DeleteDomain where
    type Info DeleteDomain = SdbInfo
    signQuery DeleteDomain{..} = sdbSignQuery [("Action", "DeleteDomain"), ("DomainName", T.encodeUtf8 ddDomainName)]

instance ResponseIteratee DeleteDomainResponse where
    type ResponseMetadata DeleteDomainResponse = SdbMetadata
    responseIteratee = sdbResponseIteratee $ sdbCheckResponseType DeleteDomainResponse "DeleteDomainResponse"

instance Transaction DeleteDomain DeleteDomainResponse
