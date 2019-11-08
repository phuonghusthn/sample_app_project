module UsersHelper
  def gravatar_for user, size: Settings.size
    gravatar_id = Digest::MD5.hexdigest user.email.downcase
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def curent_user_active_relationships
    current_user.active_relationships.build
  end

  def find_user_unfollow
    current_user.active_relationships.find_by followed_id: @user.id
  end
end
