class CharacterStep < ApplicationRecord

  belongs_to :user

  validates_presence_of :step, :character

end
