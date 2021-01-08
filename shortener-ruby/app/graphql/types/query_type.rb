module Types
  class QueryType < Types::BaseObject
    field :get_url, UrlType, null: false do
      argument :url_id, Integer, required: true
    end

    field :get_all_urls, [UrlType], null: true

    def get_url(url_id:)
      # add some error handling
      Url.find(url_id)
    end

    def get_all_urls
      Url.all
    end
  end
end
