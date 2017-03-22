class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :check_header
  before_action :validate_login
  before_action :validate_server

  private
  def check_header
    if ['POST','PUT','PATCH'].include? request.method
      if request.content_type != "application/json"
        head 406 and return
      end
    end
  end

  def validate_type
    if params['data'] && params['data']['type']
      if params['data']['type'] == params[:controller]
        return true
      end
    end
    head 409 and return
  end

  def validate_server
    #Rails.logger.debug request.domain.inspect
    head 403 and return unless request.domain.include? /localhost|herokuapp.com/
  end

  def validate_login
    token = request.headers["X-Api-Key"]
    return unless token
    user = User.find_by token: token
    return unless user
    @current_user = user
    if 15.minutes.ago < user.updated_at
      user.touch
      @current_user = user
    end
  end

  def validate_user
    head 403 and return unless @current_user
  end

  def render_error(resource, status)
    render json: resource, status: status, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer, meta: default_meta
  end

  def default_meta
    {
      licence: 'CC-0',
      authors: ['Saša'],
      logged_in: (@current_user ? true : false)
    }
  end

  def pagination_meta(object)
    {
      current_page: object.current_page,
      next_page: object.next_page,
      prev_page: object.previous_page,
      total_pages: object.total_pages,
      total_count: object.total_entries
    }
  end
end
