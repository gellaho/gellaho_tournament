# frozen_string_literal: true

# == Schema Information
#
# Table name: tournament_match_entrants
#
#  id                    :bigint           not null, primary key
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  tournament_entrant_id :bigint           not null
#  tournament_match_id   :bigint           not null
#
# Indexes
#
#  index_tournament_match_entrants_on_tournament_entrant_id  (tournament_entrant_id)
#  index_tournament_match_entrants_on_tournament_match_id    (tournament_match_id)
#
# Foreign Keys
#
#  fk_rails_...  (tournament_entrant_id => tournament_entrants.id)
#  fk_rails_...  (tournament_match_id => tournament_matches.id)
#
class Tournament
  class MatchEntrant < ApplicationRecord
    belongs_to :match, class_name: 'Tournament::Match', foreign_key: :tournament_match_id, inverse_of: :match_entrants
    belongs_to(
      :entrant, class_name: 'Tournament::Entrant', foreign_key: :tournament_entrant_id, inverse_of: :match_entrants
    )
  end
end
