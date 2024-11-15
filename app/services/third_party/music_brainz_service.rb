# app/services/third_party/music_brainz_service.rb
module ThirdParty
  class MusicBrainzService
    include HTTParty
    MUSICBRAINZ_API_URL = 'https://musicbrainz.org/ws/2'.freeze
    USER_AGENT = 'BandFinder/1.0 (me@example.com)'.freeze

    def initialize
      @user_agent = USER_AGENT
    end

    def search_bands_by_location(location:, founded_since:, limit: 50, offset: 0)
      query = "area:#{location} AND begin:[#{founded_since} TO *]"
      make_request('artist', query: query, limit: limit, offset: offset)
    end

    private

    # Generic method to make API requests
    def make_request(endpoint, params = {})
      response = HTTParty.get("#{MUSICBRAINZ_API_URL}/#{endpoint}", {
        query: params.merge(fmt: 'json'), # Always return JSON
        headers: {
          'User-Agent' => @user_agent
        }
      })

      parse_response(response)
    end

    # Parses API response and handles errors
    def parse_response(response)
      if response.success?
        response.parsed_response
      else
        { error: response['error'] || 'Unable to fetch data from MusicBrainz' }
      end
    end
  end
end
