# frozen_string_literal: true

# == Schema Information
#
# Table name: tournament_commentaries
#
#  id                        :bigint           not null, primary key
#  commentable_type          :string           not null
#  text                      :string           not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  commentable_id            :bigint           not null
#  tournament_commentator_id :bigint           not null
#
# Indexes
#
#  index_tournament_commentaries_on_commentable                (commentable_type,commentable_id)
#  index_tournament_commentaries_on_tournament_commentator_id  (tournament_commentator_id)
#
# Foreign Keys
#
#  fk_rails_...  (tournament_commentator_id => tournament_commentators.id)
#
class Tournament
  class Commentary < ApplicationRecord
    belongs_to :commentable, polymorphic: true
    belongs_to :commentator, class_name: 'Tournament::Commentator', foreign_key: :tournament_commentator_id,
                             inverse_of: :commentaries
  end
end
