module Api
  module V0
    class BandsController < BaseApiController
      def index
        result = music_brainz_service.search_bands_by_location(
          location: location,
          founded_since: founded_since,
          limit: limit,
          offset: offset
        )

        if result[:error]
          render json: { error: result[:error] }, status: :bad_request
        else
          render json: result, status: :ok
        end
      end

      private

      def music_brainz_service
        @music_brainz_service ||= ::ThirdParty::MusicBrainzService.new
      end

      def location
        location = params[:location]
      end

      def founded_since
        (Time.current.year - 10).to_s
      end
    end
  end
end
