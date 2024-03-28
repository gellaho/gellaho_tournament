# frozen_string_literal: true

class TournamentsController < ApplicationController
  http_basic_authenticate_with(
    name: ENV.fetch('BASIC_AUTH_USER', "test") || Rails.application.credentials[:basic_auth_user],
    password: ENV.fetch('BASIC_AUTH_PASSWORD', "test") || Rails.application.credentials[:basic_auth_password],
    except: %i[show index]
  )
  layout 'tournament', except: %i[new index]

  def index
    @tournaments = Tournament.all
  end

  def show
    tournament = Tournament.find(params[:id])

    if tournament.commentaries.any?
      render(:show, locals: { tournament: })
    else
      redirect_to(tournament_round_path(tournament, tournament.rounds.round_order.first))
    end
  end

  def new; end

  def create
    tournament = TournamentImporter.import(tournament_params[:attachment])

    if tournament
      redirect_to(tournament)
    else
      render(:new, error: 'Oops')
    end
  end

  private

  def tournament_params
    params.require(:tournament).permit(:attachment)
  end

  helper_method def round; end

  helper_method def tournament
    @tournament ||= Tournament.find(params[:id])
  end
end
