# frozen_string_literal: true

class CreateTournamentCommentaries < ActiveRecord::Migration[7.1]
  def change
    create_table(:tournament_commentaries) do |t|
      t.string(:text, null: false)
      t.belongs_to(:tournament_commentator, null: false, foreign_key: true)
      t.belongs_to(:commentable, polymorphic: true, null: false, index: true)

      t.timestamps
    end
  end
end
