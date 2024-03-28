# frozen_string_literal: true

# == Schema Information
#
# Table name: tournament_matches
#
#  id                  :bigint           not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  tournament_round_id :bigint           not null
#  winner_id           :bigint           not null
#
# Indexes
#
#  index_tournament_matches_on_tournament_round_id  (tournament_round_id)
#  index_tournament_matches_on_winner_id            (winner_id)
#
# Foreign Keys
#
#  fk_rails_...  (tournament_round_id => tournament_rounds.id)
#  fk_rails_...  (winner_id => tournament_entrants.id)
#

class Tournament
  class Match < ApplicationRecord
    belongs_to :winner, class_name: 'Tournament::Entrant'
    belongs_to :round, class_name: 'Tournament::Round', foreign_key: :tournament_round_id, inverse_of: :matches

    has_many(
      :commentaries,
      class_name: 'Tournament::Commentary',
      as: :commentable,
      dependent: :destroy
    )
    has_many(
      :match_entrants,
      class_name: 'Tournament::MatchEntrant',
      foreign_key: :tournament_match_id,
      inverse_of: :match,
      dependent: :destroy
    )
    has_many :entrants, through: :match_entrants

    def loser
      entrants.where.not(id: winner_id).first
    end
  end
end
