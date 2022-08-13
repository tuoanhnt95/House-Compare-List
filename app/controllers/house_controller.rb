class HouseController < ApplicationController
  before_action :set_house, only: %i[show edit update destroy]

  def index
    @houses = House.all
  end

  def show
  end

  def new
    @house = House.new
  end

  def create
    @house = House.new(house_params)
    if @house.save
      redirect_to house_path(@house)
    else
      render houses_path, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @house.update(house_params)
    if @house.save
      redirect_to house_path(@house)
    else
      render houses_path, status: :unprocessable_entity
    end
  end

  private

  def set_house
    @house = House.find(params[:id])
  end

  def house_params
    params.require(:house).permit(:name, :total_price, :floor_area, :station_distance_time, :built_year, :floor, :photo)
  end
end
