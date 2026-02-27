class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [ :new, :confirm, :create ]

  def index
    @reservations = current_user.reservations
  end

  def new
    @reservation = Reservation.new
  end

  def confirm
  Rails.logger.debug "PARAMS reservation: #{params[:reservation].inspect}"

  @reservation = current_user.reservations.build(reservation_params)
  @reservation.room = @room

  if @reservation.valid?
    @nights = (@reservation.check_out - @reservation.check_in).to_i
    @total_price = @nights * @reservation.people * @room.price
    render :confirm
  else
    flash.now[:alert] = "入力内容を確認してください"
    render :new, status: :unprocessable_entity
  end
end

  def create
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.room = @room

    if @reservation.save
      redirect_to reservations_path, notice: "予約しました"
    else
  flash.now[:alert] = "入力内容を確認してください"
  render :new, status: :unprocessable_entity
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :people)
  end
end
