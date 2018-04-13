class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user

  private

    def authenticate_user
      github = GithubRepo.new({name: "", html_url: ""})
      redirect_to github.authenticate_user(ENV['GITHUB_CLIENT']) if !logged_in?
    end

    def logged_in?
      !!session[:token]
    end
end
