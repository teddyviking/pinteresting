class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  respond_to :html

  def index
    @pins = Pin.all.order("created_at DESC")
  end

  def show
  end

  def new
    @pin = current_user.pins.build
  end

  def edit
  end

  def create
    @pin = current_user.pins.build(pin_params)
    @pin.save
  end

  def update
    @pin.update(pin_params)
  end

  def destroy
    @pin.destroy
  end

  private
    def set_pin
      @pin = Pin.find(params[:id])
    end
    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Not authorized to edit this pin" if @pin.nil?
    end
    def pin_params
      params.require(:pin).permit(:description, :image)
    end
end
