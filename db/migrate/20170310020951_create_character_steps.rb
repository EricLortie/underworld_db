class CreateCharacterSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :character_steps do |t|

      t.string      :user_id
      t.string      :character_id
      t.string      :rulebook
      t.string      :category
      t.integer     :step
      t.text        :character
      t.string      :pc_class
      t.string      :vocation
      t.string      :occupation
      t.string      :race
      t.string      :skill
      t.integer     :skill_count
      t.integer     :frags_spent
      t.integer     :spell_spheres
      t.integer     :cp_spent

      t.timestamps
    end

    add_index(:character_steps, :id, :unique => true)

  end
end
