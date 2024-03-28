# frozen_string_literal: true

class CreateTournamentMatches < ActiveRecord::Migration[7.1]
  def change
    create_table(:tournament_matches) do |t|
      t.belongs_to(:winner, null: false, foreign_key: { to_table: 'tournament_entrants' })
      t.belongs_to(:tournament_round, null: false, foreign_key: true)

      t.timestamps
    end
  end
end
