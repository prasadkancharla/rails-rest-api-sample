module V1
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
      @users = User.paginate(:page => params[:page] ||= 1, :per_page => params[:per_page] ||= 10).order('name ASC')

      json_response(@users)
    end

    # GET /users/:id
    def show
      json_response(@user)
    end

    # PUT /users/:id
    def update
      unless current_user.id == @user.id
        redirect_to(@user, notice: "You cannot edit this user") and return
      end

      @user.update(user_edit_params)
      head :no_content
    end

    # DELETE /users/:id
    def destroy
      unless current_user.id == @user.id
        redirect_to(@user, notice: "You cannot delete this user") and return
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

    def user_edit_params
      # whitelist params
      params.permit(:name)
    end

    def set_user
      @user = User.find(params[:id])
    end

  end
end