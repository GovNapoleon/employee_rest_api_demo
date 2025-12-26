class Api::V1::EmployeesController < ApplicationController

  before_action :set_employee, only: [:show, :update, :destroy]
  def index
    @employees = Employee.includes(:department, :country)
    render json: @employees, status: :ok
  end

  def show
    render json: @employee, status: :ok
  end

  def update
    if @employee.update(employees_params)
      render json: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  def destroy

  end

  private
  def set_employee
    begin
      @employee = Employee.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Employee not found' }, status: :not_found
    end
  end

  def employees_params
    params.require(:employee).permit(
      :firtname, :lastname,
      :haspassport,
      :salary,
      :birthdate,
      :hiredate,
      :gender,
      :notes,
      :email,
      :phone,
      :country_id,
      :department_id
    )
  end
end
