# frozen_string_literal: true

class CreateTournaments < ActiveRecord::Migration[7.1]
  def change
    create_table(:tournaments) do |t|
      t.string(:name, null: false)
      t.string(:slug, null: false)
      t.string(:category, null: false)

      t.timestamps
    end
  end
end
