# frozen_string_literal: true

# == Schema Information
#
# Table name: tournament_commentators
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tournament_commentators_on_name  (name) UNIQUE
#
class Tournament
  class Commentator < ApplicationRecord
    has_many(
      :commentaries,
      class_name: 'Tournament::Commentary',
      foreign_key: :tournament_commentator_id,
      inverse_of: :commentator,
      dependent: :restrict_with_exception
    )

    has_one_attached :image

    validates :name, presence: true, uniqueness: true
  end
end
