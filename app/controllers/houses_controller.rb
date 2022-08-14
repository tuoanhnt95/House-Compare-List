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
    data.each_pair do |k, v|
      @house[k] = v
    end

    raise
    if @house.save
      redirect_to house_path(@house)
    else
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

  def destroy
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
      rent_fee: /(.+)円/,
      mng_fee: /([\d.-]+)/
      # lease_deposit:
      # key_money:
      # guarantee_deposit:
      # floor_area:
      # station_distance_time:
      # built_year:
      # floor:
    }

    matches = {}
    suumo.each_pair do |k, v|
      matches[k] = v.match(result[k])[1]
    end
    matches.each_pair do |k, v|
      if v == '-'
        matches[k] = 0
      elsif v.include? "万"
        matches[k] = v.to_f * 10_000
      else
        matches[k] = v.to_f
      end
    end
    matches[:img_src] = result[:img_src]
    return matches
  end

  def parse(url)
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)

    suumo = {
      # layout: "",
      rent_fee: ".property_view_note-emphasis",
      mng_fee: ".property_view_note-list:first-child span:nth-child(2)"
      # lease_deposit: ".property_view_note-list span",
      # key_money: ".property_view_note-list span",
      # guarantee_deposit: ".property_view_note-list span"
      # floor_area:
      # station_distance_time:
      # built_year:
      # floor:
    }
    domain = suumo
    scrape = {}
    domain.each_pair do |k, v|
      scrape[k] = html_doc.search(v).inner_text
    end
    scrape[:img_src] = html_doc.search(".property_view_thumbnail-img").first.first[1]
    return scrape
  end

  def search(url)
    result = parse(url)
    reg(result)
  end

  # html_doc.search(".standard-card-new__article-title").each do |element|()
  #   puts element.text.strip
  #   puts element.attribute("href").value
  # end
end
