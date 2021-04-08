# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook google_oauth2 linkedin]

  has_many :providers

  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info'] && user.email.blank?
  #       user.email = data['email']
  #     end
  #   end
  # end

  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first
    if user.present?
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.image = auth.info.image
      user.save
      add_provider(user, auth)
    else
      user = create(email: auth.info.email)
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.image = auth.info.image
      user.save
      add_provider(user, auth)
    end
  end

  def self.add_provider(user, auth)
    user.providers.find_or_create_by(provider_name: auth.provider, provider_uid: auth.uid)
  end
end
