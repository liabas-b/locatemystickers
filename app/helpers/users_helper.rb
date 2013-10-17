module UsersHelper
	
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50 }, addclass = '')
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar #{addclass}")
  end

  def increment_compteur(user)
  	user.compteur += 1
  	user.save
  end

  def has_adress?(user)
    !(user.adress.nil? || user.zip_code.nil? || user.country.nil? || user.adress.empty? || user.zip_code.empty? || user.country.empty?)
  end

  def has_phone?(user)
    !(user.phone.nil? || user.phone.empty?)
  end

  def adress_for(user)
    unless has_adress?(user)
      if user == current_user
        link_to "You can fill your postal adress here.", edit_user_path(user)
      else
        content_tag(:span, "This user has not filled his complete adress yet.", class: 'text-warning')
      end
    else
      "Lives at: " + user.adress + ", " + user.zip_code + " " + user.country + "."
    end
  end

  def phone_for(user)
    unless has_phone?(user)
      if user == current_user
        link_to "You can fill your phone number here.", edit_user_path(user)
      else
        content_tag(:span, "This user has not filled his phone number yet.", class: 'text-warning')
      end
    else
      "Phone: " + user.phone + "."
    end
  end

  # Web Service

  def parse_user_from_parsed_json
    user = User.new(@parsed_json)
    user.id = @parsed_json['id']
    return user
  end
end
