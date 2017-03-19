class CharacterStepSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :character_id, :rulebook, :category, :user_id, :step, :character, :pc_class, :vocation, :occupation, :race, :skill, :skill_count, :frags_spent, :spell_spheres, :cp_spent

  belongs_to :user
  link(:self) { post_url(object) }
end
