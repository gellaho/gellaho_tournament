# frozen_string_literal: true

# == Schema Information
#
# Table name: tournaments
#
#  id         :bigint           not null, primary key
#  category   :string
#  name       :string           not null
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tournament < ApplicationRecord
  has_many :rounds, class_name: 'Tournament::Round', dependent: :destroy
  has_many :entrants, class_name: 'Tournament::Entrant', dependent: :destroy
  has_many(
    :commentaries,
    class_name: 'Tournament::Commentary',
    as: :commentable,
    dependent: :destroy
  )

  after_validation :set_slug, only: %i[create update]

  def first_place
    rounds.order(:number).last.matches.last.winner
  end

  def second_place
    rounds.order(:number).last.matches.last.loser
  end

  def to_param
    "#{id}-#{slug}"
  end

  def to_json
    {
      id: id,
      category: category,
      name: name,
      slug: to_param
    }
  end

  private

  def set_slug
    self.slug = name.to_s.parameterize
  end
end
