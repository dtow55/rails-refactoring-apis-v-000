class GithubRepo

  attr_reader :name, :url

  def authenticate_user(client_id)
    url = "https://github.com/login/oauth/authorize?client_id=#{client_id}&scope=repo"
    url
  end

  def authenticate(client_id, github_secret, code)
    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: client_id, client_secret: github_secret, code: code}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    access_hash["access_token"]
  end

  def username(session_token)
    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session_token}", 'Accept' => 'application/json'}

    user_json = JSON.parse(user_response.body)
    user_json["login"]
  end

  def repositories(session_token)
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session_token}", 'Accept' => 'application/json'}
    JSON.parse(response.body)
  end

  def create_repository(session_token, repo_name)
    response = Faraday.post "https://api.github.com/user/repos", {name: repo_name}.to_json, {'Authorization' => "token #{session_token}", 'Accept' => 'application/json'}
  end

  def initialize(hash)
    @name = hash["name"]
    @url = hash["html_url"]
  end

end