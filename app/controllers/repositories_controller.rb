class RepositoriesController < ApplicationController
  def index
    github = GithubRepo.new({name: "", html_url: ""})
    @repos_array = github.repositories(session[:token])
  end

  def create
    github = GithubRepo.new({name: "", html_url: ""})
    github.create_repository(session[:token], params[:name])
    redirect_to '/'
  end
end
