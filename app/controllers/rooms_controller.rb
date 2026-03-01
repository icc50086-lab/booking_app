class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [ :search ]

  # 自分の施設一覧
  def index
    @rooms = current_user.rooms.order(created_at: :desc)
  end

  def search
    @rooms = Room.order(created_at: :desc)

    if params[:address].present? && [ "東京", "大阪", "京都", "札幌" ].include?(params[:address])
      @rooms = @rooms.where("address LIKE ?", "%#{params[:address]}%")
    end

    if params[:keyword].present?
      @rooms = @rooms.where("name LIKE ? OR detail LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end
  end

  def show
  @room = Room.find(params[:id])
  end

  def new
    @room = current_user.rooms.new
  end

  def create
    @room = current_user.rooms.new(room_params)
    if @room.save
      redirect_to rooms_path, notice: "施設を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :detail, :price, :address, :image)
  end
end
