class Api::V1::CountriesController < ApplicationController
  before_action :set_country, only: [:show, :update, :destroy, :create]

  def index
    @countries = Country.all
    render json: @countries, status: :ok
  end

  def show
    render json: @country, status: :ok
  end

  def update
    if @country.update(country_params)
      render json: @country
    else
      render json: @country.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @country.destroy
    render json: { message: 'Country deleted Successfully' }, status: :no_content
  end

  private
  def set_country
    begin
      @country = Country.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Country not found' }, status: :not_found
    end
  end

  def country_params
    params.require(:country).permit(:name, :code, :continent)
  end
end
