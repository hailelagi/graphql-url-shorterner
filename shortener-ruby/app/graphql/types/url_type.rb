module Types
  class UrlType < Types::BaseObject
    field :id, ID, null: false
    field :shortLink, String, null: false
    field :originalLink, String, null: false
  end
end
