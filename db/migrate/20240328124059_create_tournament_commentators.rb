# frozen_string_literal: true

class CreateTournamentCommentators < ActiveRecord::Migration[7.1]
  def change
    create_table(:tournament_commentators) do |t|
      t.string(:name, null: false, index: { unique: true })

      t.timestamps
    end
  end
end
