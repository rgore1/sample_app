module UsersHelper
# Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email)
    gravatar_url = "https://secure.gravatar.com/avatars/#{gravatar_id}.png"
    image tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
