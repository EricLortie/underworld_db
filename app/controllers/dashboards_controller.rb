class DashboardsController < ApplicationController

  def index
    @character_steps = CharacterStep.all
  end

end
