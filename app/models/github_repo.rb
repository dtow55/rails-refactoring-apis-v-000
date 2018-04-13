class GithubRepo

  attr_reader :name, :url

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

  def initialize(hash)
    @name = hash["name"]
    @url = hash["html_url"]
  end

end