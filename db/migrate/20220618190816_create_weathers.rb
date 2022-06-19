# frozen_string_literal: true

class CreateWeathers < ActiveRecord::Migration[7.0]
  def change
    create_table :weathers do |t|
      t.json :current
      t.references :city, null: false, foreign_key: true
      t.json :historical

      t.timestamps
    end
  end
end
