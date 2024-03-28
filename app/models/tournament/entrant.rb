# frozen_string_literal: true

# == Schema Information
#
# Table name: tournament_entrants
#
#  id            :bigint           not null, primary key
#  creator       :string
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  tournament_id :bigint           not null
#
# Indexes
#
#  index_tournament_entrants_on_tournament_id  (tournament_id)
#
# Foreign Keys
#
#  fk_rails_...  (tournament_id => tournaments.id)
#
class Tournament
  class Entrant < ApplicationRecord
    belongs_to :tournament

    has_many(
      :match_entrants,
      class_name: 'Tournament::MatchEntrant',
      foreign_key: :tournament_entrant_id,
      inverse_of: :entrant,
      dependent: :destroy
    )
    has_many :matches, class_name: 'Tournament::Match', through: :match_entrants
    has_many :rounds, through: :matches

    validates :name, presence: true

    has_one_attached :image

    def won?(match)
      match.winner_id == id
    end
  end
end
