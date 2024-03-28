# frozen_string_literal: true

class Tournament
  class RoundsController < ApplicationController
    layout 'tournament'

    def show; end

    private

    helper_method def round
      @round ||= Round.find(params[:id])
    end

    helper_method def tournament
      @tournament ||= Tournament.find(params[:tournament_id])
    end
  end
end
