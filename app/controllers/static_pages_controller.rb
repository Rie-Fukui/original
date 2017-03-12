class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @microposts = Micropost.all.order(created_at: :desc)
    end
  end
end