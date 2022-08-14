require 'open-uri'
require 'nokogiri'

class HousesController < ApplicationController
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
    data = search(@house.house_url)
    @house.rent_fee = data[:rent_fee]
    raise
    if @house.save
      redirect_to house_path(@house)
    else
      raise
      render :new, status: :unprocessable_entity
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
    params.require(:house).permit(
      :house_url, :name, :total_price, :floor_area, :station_distance_time, :built_year, :floor, :photo
    )
  end

  def reg(result)
    # create a hash to store the element: regex
    # return a hash with the result of reg match
    suumo = {
      # layout:
      rent_fee: /(.+)万円/,
      # mng_fee: //,
      # lease_deposit:
      # key_money:
      # guarantee_deposit:
      # floor_area:
      # station_distance_time:
      # built_year:
      # floor:
    }
    {
      rent_fee: (suumo[:rent_fee]).match(result)[1].to_f * 10_000
    }
  end

  def parse(url)
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)

    suumo = {
      rent_fee: ".property_view_note-emphasis"
    }
    html_doc.search(suumo[:rent_fee]).inner_text
  end

  def search(url)
    result = parse(url)
    reg(result)
  end
end
