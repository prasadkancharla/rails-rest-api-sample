class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :authorize_request, only: :create

  # POST /signup
  # return authenticated token upon signup
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.username, user.password).call
    response = {message: Message.account_created, auth_token: auth_token}
    json_response(response, :created)
  end

  # GET /users
  def index
    @users = User.select("id, name, username, created_at, updated_at").paginate(:page => params[:page] ||= 1, :per_page => params[:per_page] ||= 10).order('name ASC')

    json_response(@users)
  end

  # GET /users/:id
  def show
    json_response(@user)
  end

  # PUT /users/:id
  def update
    @user = User.find(params[:id])

    unless current_user.id == @user.id
      json_response({message: "You cannot edit this user"})
      return
    end

    if params.has_key?(:name)
        @user.name = params[:name]
    end
    if params.has_key?(:username)
        @user.username = params[:username]
    end
    if params.has_key?(:password)
      @user.password = params[:password]
    end

    @user.save!

    head :no_content
  end

  # DELETE /users/:id
  def destroy
    unless current_user.id == @user.id
      json_response({message: "You cannot delete this user"})
      return
    end

    @user.destroy
    head :no_content
  end

  private

  def user_params
    params.permit(
        :name,
        :username,
        :password,
        :password_confirmation
    )
  end


  def set_user
    @user = User.select("id, name, username, created_at, updated_at").find(params[:id])
  end

end
