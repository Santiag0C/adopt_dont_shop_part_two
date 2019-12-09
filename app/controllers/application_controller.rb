class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :favorites, :keys_to_i

  def favorites
    @favorites ||= Favorite.new(session[:favorites])
  end

  # def keys_to_i(contents)
  #   pet_id_int = []
  #   contents.each do |pet_id, quantity|
  #     pet_id_int.push(pet_id.to_i)
  #   end
  #   pet_id_int
  # end
end
