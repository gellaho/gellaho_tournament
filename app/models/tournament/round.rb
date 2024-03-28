# frozen_string_literal: true

# == Schema Information
#
# Table name: tournament_rounds
#
#  id            :bigint           not null, primary key
#  name          :string           not null
#  number        :integer          not null
#  slug          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  tournament_id :bigint           not null
#
# Indexes
#
#  index_tournament_rounds_on_tournament_id  (tournament_id)
#
# Foreign Keys
#
#  fk_rails_...  (tournament_id => tournaments.id)
#
class Tournament
  class Round < ApplicationRecord
    belongs_to :tournament

    has_many(
      :matches,
      class_name: 'Tournament::Match',
      foreign_key: :tournament_round_id,
      inverse_of: :round,
      dependent: :destroy
    )
    has_many :entrants, through: :matches

    scope :round_order, -> { order(number: :asc) }

    validates :name, presence: true
    validates :number, presence: true

    after_validation :set_slug, only: %i[create update]

    def to_param
      "#{id}-#{slug}"
    end

    def next
      tournament.rounds.find_by(number: number + 1)
    end

    def previous
      tournament.rounds.find_by(number: number - 1)
    end

    def last?
      tournament.rounds.round_order.last.id == id
    end

    private

    def set_slug
      self.slug = name.to_s.parameterize
    end
  end
end
