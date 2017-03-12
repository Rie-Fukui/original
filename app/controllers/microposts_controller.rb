class MicropostsController < ApplicationController
  before_action :logged_in_user
  before_action :set_micropost, only: [:show, :answer]
  before_action :finished_game, only: [:answer]
  
  def show
    @answer = current_user.answers.build(micropost_id: @micropost.id)
    @answers = Answer.where(micropost_id: @micropost.id).order(created_at: :desc)
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
  
  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
  
  def answer
    @answer = current_user.answers.build(micropost_id: @micropost.id)
    @answer.text = params[:answer][:text]
    if @answer.text == @answer.micropost.word && @answer.save
      @micropost.update(finish: true)
      @micropost.user.answers.create!(micropost_id: @micropost.id,
                                    text: "#{@answer.user.name}さん正解！！")
      flash[:danger] = "!!congratulations(*ﾟ▽ﾟ)ﾉ!!"
      p "##########################"
      p @micropost
      redirect_to @micropost
    elsif @answer.save
      flash[:success] = "Nooooo!!"
      redirect_to @micropost
    else
      @answer = current_user.answers.build(micropost_id: @micropost.id)
      @answers = Answer.where(micropost_id: @micropost.id).order(created_at: :desc)
      render 'show'
    end
  end
  
  private
  def micropost_params
    params.require(:micropost).permit(:content, :title, :word)
  end

  def finished_game
    redirect_to @micropost if @micropost.finish == true
  end
  
  def set_micropost
    @micropost = Micropost.find(params[:id])
  end
end