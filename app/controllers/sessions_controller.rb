class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    github = GithubRepo.new({name: "", html_url: ""})
    session[:token] = github.authenticate(ENV["GITHUB_CLIENT"], ENV["GITHUB_SECRET"], params[:code])
    session[:username] = github.username(session[:token])
    redirect_to '/'
  end
end