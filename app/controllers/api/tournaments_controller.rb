# frozen_string_literal: true

class Api::TournamentsController < ApplicationController
  def index
    render json: Tournament.all.map(&:to_json)
  end
end
