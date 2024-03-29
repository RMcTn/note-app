class ApplicationController < ActionController::Base
  include Pagy::Backend

  def after_sign_in_path_for(resource)
    if current_user.should_be_redirected_to_new_entry?
      new_entry_path
    else
      root_path
    end
  end

end
