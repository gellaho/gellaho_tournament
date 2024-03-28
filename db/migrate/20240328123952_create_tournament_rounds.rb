# frozen_string_literal: true

class CreateTournamentRounds < ActiveRecord::Migration[7.1]
  def change
    create_table(:tournament_rounds) do |t|
      t.integer(:number, null: false)
      t.belongs_to(:tournament, null: false, foreign_key: true)
      t.string(:name, null: false)
      t.string(:slug, null: false)

      t.timestamps
    end
  end
end
