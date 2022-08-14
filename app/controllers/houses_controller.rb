require 'open-uri'
require 'nokogiri'

# regex to match the html string containing the number
SUUMO_REGEX = {
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

SUUMO_HTML = {
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
    # get url
    @house = House.new(house_params)
    # use url to scrape values
    data = search(@house.house_url)
    # assign values to the house's attributes
    data.each_pair do |k, v|
      @house[k] = v
    end
    # save house or return error
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
    @house.destroy
    redirect_to houses_path, status: :see_other
  end

  private

  def set_house
    @house = House.find(params[:id])
  end

  def house_params
    params.require(:house).permit(
      :house_url, :name, :layout, :rent_fee, :mng_fee, :lease_deposit,
      :key_money, :guarantee_deposit, :floor_area, :station_distance_time, :built_year, :floor, :photo, :img_src
    )
  end

  def parse(url)
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)
    # future: have a function to check which domain
    domain = SUUMO_HTML
    scrape = {}
    # search values from HTML-inner_text
    domain.each_pair do |k, v|
      scrape[k] = html_doc.search(v).inner_text
    end
    # search values for no-HTML-inner_text
    scrape[:img_src] = html_doc.search(".property_view_object-img").first.first[1]
    return scrape
  end

  def turn_to_number(matches_hash)
    matches_hash.each_pair do |k, v|
      if v == '-'
        matches_hash[k] = 0
      elsif v.include? "万"
        matches_hash[k] = v.to_f * 10_000
      else
        matches_hash[k] = v.to_f
      end
    end
  end

  def reg(result)
    # filter the number with regex
    matches = {}
    SUUMO_REGEX.each_pair do |k, v|
      matches[k] = v.match(result[k])[1]
    end
    # turn string into number for numerical attributes
    turn_to_number(matches)
    # assign values for non-numerical attributes
    matches[:img_src] = result[:img_src]
    return matches
  end

  def search(url)
    result = parse(url)
    reg(result)
  end
end
