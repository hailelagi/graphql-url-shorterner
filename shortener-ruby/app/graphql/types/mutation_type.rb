module Types
  class MutationType < Types::BaseObject
    field :create_url, mutation: Mutations::CreateUrl
  end
end
