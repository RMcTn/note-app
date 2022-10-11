class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :entries

  def send_on_create_confirmation_instructions
    # Intentionally do nothing here!
  end

  def signed_in_within_last_24_hours?
    difference = current_sign_in_at - last_sign_in_at
    difference <= 1.day
  end
  
  def should_be_redirected_to_new_entry?
    not signed_in_within_last_24_hours? || sign_in_count == 1
  end
    

end
