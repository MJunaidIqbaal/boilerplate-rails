# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :invitable

  enum role: %i[admin user]

  has_one_attached :image

  def self.search(query)
    if query.present?
      where("
        email ILIKE? OR first_name ILIKE? OR last_name ILIKE? OR phone_no ILIKE?", 
        "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%"
      ).limit(10)
    else
      all
    end
  end

  # Override devise notification system to send emails through queue backend
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
