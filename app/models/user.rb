class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable, :rememberable, :trackable, :omniauthable, :database_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :remember_me, :name, :twitter_handle, :twitter_description, :twitter_description, :twitter_oauth, :website

  class << self
    def find_for_twitter_oauth(auth)
      user = User.find_by_twitter_oauth(auth.auth_token)

      if user
        user
      else
        User.create(
          name: auth["info"]["name"],
          twitter_handle: auth["info"]["nickname"],
          twitter_description: auth["info"]["description"],
          website: auth["info"]["website"],
          twitter_oauth: auth["credentials"]["token"]
        )
      end

    end

  end

end
