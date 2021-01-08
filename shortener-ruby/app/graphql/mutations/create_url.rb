require 'uri'
require 'digest/sha2'

module Mutations
  class CreateUrl < BaseMutation
    argument :original_link, String, required: true

    type Types::UrlType

    def resolve(original_link:)
      raw_link = URI::parse(original_link)

      link = raw_link.scheme ? original_link : "https://#{original_link}"
      short_link = gen_link_hash(link)

      url = Url.create!(originalLink: link, shortLink: short_link)
      url if url.present?
    rescue ActiveRecord::RecordInvalid, URI::InvalidURIError => e
      GraphQL::ExecutionError.new("Invalid due to : #{e}")
    end

    private

    def gen_link_hash(link)
      # slightly simpler implementation of the hash.
      url_hash = Digest::SHA2.new << link
      url_hash.to_s[0...6]
    end
  end
end
