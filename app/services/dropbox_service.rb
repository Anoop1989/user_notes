require 'oauth2'

class DropboxService
  attr_accessor :app_auth_token

  def initialize user
    @app_key = DROPBOX_APP_KEY
    @app_secret = DROPBOX_APP_SECRET
    @app_auth_url = nil
    @app_auth_token = user.dropbox_auth_token
  end

  def generate_auth_url
    @app_auth_url = authenticator.authorize_url
  end

  def generate_access_token
    @app_access_token = authenticator.get_token(@app_auth_token).token
  end

  def authenticator
    DropboxApi::Authenticator.new(@app_key, @app_secret)
  end

  def back_up_notes notes
    begin
      generate_access_token
      client = DropboxApi::Client.new(@app_access_token)
      client.list_folder "/notes"
    rescue DropboxApi::Errors::NotFoundError => err
      client.create_folder "/notes"
    rescue OAuth2::Error
      raise "User oAuth failure: Invalid access"
    end
    client.upload "/notes/#{Time.now.strftime('%Y%m%d%H%M%S')}.json", notes.to_json
  end
end