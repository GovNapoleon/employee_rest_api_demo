class Api::V1::EmployeesController < ApplicationController
  def index
    @employees = Employee.includes(:department, :country)
    render json: @employees, status: :ok
  end
end
