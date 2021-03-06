class EntriesController < ApplicationController
  before_action :logged_in_user
  before_action :set_live
  before_action :future_live

  def new
    @song = @live.songs.build
    @song.playings.build
  end

  def create
    @song = @live.songs.build(song_params)
    return unless @song.save
    if @song.send_entry(current_user)
      flash[:success] = '曲の申請メールを送信しました'
    else
      flash[:danger] = 'メールの送信に失敗しました'
    end
    redirect_to @song.live
  end

  private

  def set_live
    @live = Live.find(params[:live_id])
  end

  def future_live
    redirect_to root_url unless @live.future?
  end

  def song_params
    params.require(:song).permit(:name, :artist, :status, :notes, playings_attributes: %i[id user_id inst])
  end
end
