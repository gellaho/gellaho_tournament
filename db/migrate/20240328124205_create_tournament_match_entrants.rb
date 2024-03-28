# frozen_string_literal: true

class CreateTournamentMatchEntrants < ActiveRecord::Migration[7.1]
  def change
    create_table(:tournament_match_entrants) do |t|
      t.references(:tournament_match, null: false, foreign_key: true)
      t.references(:tournament_entrant, null: false, foreign_key: true)

      t.timestamps
    end
  end
end
