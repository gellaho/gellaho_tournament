# frozen_string_literal: true

class CreateTournamentEntrants < ActiveRecord::Migration[7.1]
  def change
    create_table(:tournament_entrants) do |t|
      t.string(:name, null: false)
      t.string(:creator)
      t.belongs_to(:tournament, null: false, foreign_key: true)

      t.timestamps
    end
  end
end
