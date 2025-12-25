require "test_helper"

class Api::V1::EmployeesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_employees_url
    assert_response :success
  end

  test "should return json response" do
    get api_v1_employees_url
    assert_equal "application/json; charset=utf-8", @response.content_type
  end

  test "should return all employees" do
    get api_v1_employees_url
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal Employee.count, json_response.length
  end

  test "should include employee attributes in response" do
    get api_v1_employees_url
    assert_response :success

    json_response = JSON.parse(response.body)
    employee = json_response.first

    assert_includes employee.keys, "id"
    assert_includes employee.keys, "firstname"
    assert_includes employee.keys, "lastname"
    assert_includes employee.keys, "email"
    assert_includes employee.keys, "phone"
    assert_includes employee.keys, "salary"
    assert_includes employee.keys, "haspassport"
    assert_includes employee.keys, "birthdate"
    assert_includes employee.keys, "hiredate"
    assert_includes employee.keys, "gender"
    assert_includes employee.keys, "notes"
  end

  test "should include department association in response" do
    get api_v1_employees_url
    assert_response :success

    json_response = JSON.parse(response.body)
    employee = json_response.first

    assert_includes employee.keys, "department_id"
  end

  test "should include country association in response" do
    get api_v1_employees_url
    assert_response :success

    json_response = JSON.parse(response.body)
    employee = json_response.first

    assert_includes employee.keys, "country_id"
  end

  test "should return correct employee data" do
    get api_v1_employees_url
    assert_response :success

    json_response = JSON.parse(response.body)
    employee_one = json_response.find { |e| e["firstname"] == "John" }

    assert_not_nil employee_one
    assert_equal "John", employee_one["firstname"]
    assert_equal "Doe", employee_one["lastname"]
    assert_equal "john.doe@example.com", employee_one["email"]
    assert_equal true, employee_one["haspassport"]
  end

  test "should return status 200" do
    get api_v1_employees_url
    assert_response 200
  end
end
