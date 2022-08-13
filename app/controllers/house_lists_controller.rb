class HouseListsController < ApplicationController
  before_action :set_house_list, only: %i[show edit update destroy]

  def index
    @house_lists = HouseList.all
  end

  def show
  end

  def new
    @house_list = HouseList.new
  end

  def create
    @house_list = HouseList.new(house_list_params)
    if @house_list.save
      redirect_to house_list_path(@house_list)
    else
      render house_lists_path, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @house_list.update(house_list_params)
    if @house_list.save
      redirect_to house_list_path(@house_list)
    else
      render house_lists_path, status: :unprocessable_entity
    end
  end

  private

  def set_house_list
    @house_list = HouseList.find(params[:id])
  end

  def house_list_params
    params.require(:house_list).permit(:name, :total_price, :floor_area, :station_distance_time, :built_year, :floor, :photo)
  end
end
