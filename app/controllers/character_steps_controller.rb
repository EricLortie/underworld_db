class CharacterStepsController < ApplicationController
  before_action :set_character_step, only: [:show, :update, :destroy]
  before_action :validate_user, only: [:create, :update, :destroy]
  #before_action :validate_type, only: [:create, :update]
  skip_before_action :verify_authenticity_token

  def index
    character_steps = CharacterStep.all
    if params[:filter]
      character_steps = character_steps.where(["category = ?", params[:filter]])
    end
    if params['sort']
      f = params['sort'].split(',').first
      field = f[0] == '-' ? f[1..-1] : f
      order = f[0] == '-' ? 'DESC' : 'ASC'
      if character_step.new.has_attribute?(field)
        character_steps = character_steps.order("#{field} #{order}")
      end
    end
    character_steps = character_steps.page(params[:page] ? params[:page][:number] : 1)
    render json: character_steps, meta: pagination_meta(character_steps).merge(default_meta), include: ['user']
  end

  def show
    render json: @character_step, meta: default_meta
  end

  def create

    character_step = CharacterStep.new()
    character_step[:step] = params['character_step']['step']
    character_step[:character] = params['character_step']['character']
    character_step[:user_id] = @current_user.id
    character_step[:rulebook] = params['character_step']['rulebook']
    character_step[:category] = params['character_step']['category']
    character_step[:character_id] = params['character_step']['character_id']
    character_step[:pc_class] = params['character_step']['class']
    character_step[:vocation] = params['character_step']['vocation']
    character_step[:occupation] = params['character_step']['occupation']
    character_step[:race] = params['character_step']['race']
    character_step[:frags_spent] = params['character_step']['frags_spent']
    character_step[:skill] = params['character_step']['skill']
    character_step[:skill_count] = params['character_step']['skill_count']
    character_step[:spell_spheres] = params['character_step']['spell_spheres']
    character_step[:cp_spent] = params['character_step']['cp_spent']
    if character_step.save
      render json: character_step, status: :created, meta: default_meta
    else
      Rails.logger.debug character_step.errors.full_messages
      render_error(character_step, :unprocessable_entity)
    end
  end

  def update
    if @character_step.update_attributes(character_step_params['character_step'])
      render json: @character_step, status: :ok, meta: default_meta
    else
      render_error(@character_step, :unprocessable_entity)
    end
  end

  def destroy
    @character_step.destroy
    head 204
  end

  private
  def set_character_step
    begin
      @character_step = CharacterStep.find params[:id]
    rescue ActiveRecord::RecordNotFound
      character_step = CharacterStep.new
      character_step.errors.add(:id, "Wrong ID provided")
      render_error(character_step, 404) and return
    end
  end

  def character_step_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
