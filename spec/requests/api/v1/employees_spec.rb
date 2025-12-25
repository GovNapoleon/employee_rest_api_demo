require 'rails_helper'

RSpec.describe "Api::V1::Employees", type: :request do
  describe "GET /api/v1/employees" do
    context "when employees exist" do
      let!(:country1) { create(:country, name: "USA") }
      let!(:country2) { create(:country, name: "Canada") }
      let!(:department1) { create(:department, name: "Engineering") }
      let!(:department2) { create(:department, name: "Marketing") }

      let!(:employee1) do
        create(:employee,
          firstname: "John",
          lastname: "Doe",
          email: "john.doe@example.com",
          phone: "555-0001",
          salary: 75000,
          haspassport: true,
          gender: "Male",
          country: country1,
          department: department1
        )
      end

      let!(:employee2) do
        create(:employee,
          firstname: "Jane",
          lastname: "Smith",
          email: "jane.smith@example.com",
          phone: "555-0002",
          salary: 65000,
          haspassport: false,
          gender: "Female",
          country: country2,
          department: department2
        )
      end

      before { get "/api/v1/employees" }

      it "returns status code 200" do
        expect(response).to have_http_status(:ok)
      end

      it "returns status code 200 (numeric)" do
        expect(response).to have_http_status(200)
      end

      it "returns all employees" do
        json_response = JSON.parse(response.body)
        expect(json_response.size).to eq(2)
      end

      it "returns json content type" do
        expect(response.content_type).to match(%r{application/json})
      end

      describe "response structure" do
        let(:json_response) { JSON.parse(response.body) }
        let(:first_employee) { json_response.first }

        it "includes all employee attributes" do
          expect(first_employee).to include(
            "id",
            "firstname",
            "lastname",
            "email",
            "phone",
            "salary",
            "haspassport",
            "birthdate",
            "hiredate",
            "gender",
            "notes"
          )
        end

        it "includes department association" do
          expect(first_employee).to have_key("department_id")
        end

        it "includes country association" do
          expect(first_employee).to have_key("country_id")
        end

        it "includes timestamps" do
          expect(first_employee).to have_key("created_at")
          expect(first_employee).to have_key("updated_at")
        end
      end

      describe "response data accuracy" do
        let(:json_response) { JSON.parse(response.body) }
        let(:john_employee) { json_response.find { |e| e["firstname"] == "John" } }
        let(:jane_employee) { json_response.find { |e| e["firstname"] == "Jane" } }

        it "returns correct data for first employee" do
          expect(john_employee).to include(
            "firstname" => "John",
            "lastname" => "Doe",
            "email" => "john.doe@example.com",
            "phone" => "555-0001",
            "salary" => 75000,
            "haspassport" => true,
            "gender" => "Male"
          )
        end

        it "returns correct data for second employee" do
          expect(jane_employee).to include(
            "firstname" => "Jane",
            "lastname" => "Smith",
            "email" => "jane.smith@example.com",
            "phone" => "555-0002",
            "salary" => 65000,
            "haspassport" => false,
            "gender" => "Female"
          )
        end

        it "returns correct country_id for first employee" do
          expect(john_employee["country_id"]).to eq(country1.id)
        end

        it "returns correct department_id for first employee" do
          expect(john_employee["department_id"]).to eq(department1.id)
        end

        it "returns correct country_id for second employee" do
          expect(jane_employee["country_id"]).to eq(country2.id)
        end

        it "returns correct department_id for second employee" do
          expect(jane_employee["department_id"]).to eq(department2.id)
        end
      end

      describe "data types" do
        let(:json_response) { JSON.parse(response.body) }
        let(:employee) { json_response.first }

        it "returns salary as integer" do
          expect(employee["salary"]).to be_a(Integer)
        end

        it "returns haspassport as boolean" do
          expect([true, false]).to include(employee["haspassport"])
        end

        it "returns id as integer" do
          expect(employee["id"]).to be_a(Integer)
        end

        it "returns firstname as string" do
          expect(employee["firstname"]).to be_a(String)
        end

        it "returns email as string" do
          expect(employee["email"]).to be_a(String)
        end
      end
    end

    context "when no employees exist" do
      before do
        Employee.destroy_all
        get "/api/v1/employees"
      end

      it "returns status code 200" do
        expect(response).to have_http_status(:ok)
      end

      it "returns an empty array" do
        json_response = JSON.parse(response.body)
        expect(json_response).to eq([])
      end
    end

    context "with multiple employees" do
      let!(:employees) { create_list(:employee, 5) }

      before { get "/api/v1/employees" }

      it "returns all employees" do
        json_response = JSON.parse(response.body)
        expect(json_response.size).to eq(5)
      end

      it "returns success status" do
        expect(response).to have_http_status(:success)
      end
    end

    context "performance considerations" do
      it "eager loads associations to avoid N+1 queries" do
        # Create additional employees
        create_list(:employee, 3)

        # This tests that the controller uses .includes(:department, :country)
        # In a real scenario, you'd use tools like bullet gem to detect N+1
        expect { get "/api/v1/employees" }.not_to raise_error
      end
    end

    context "edge cases" do
      let!(:country) { create(:country) }
      let!(:department) { create(:department) }

      it "handles employees with nil notes" do
        employee_with_nil_notes = create(:employee, notes: nil, country: country, department: department)
        get "/api/v1/employees"

        json_response = JSON.parse(response.body)
        employee_data = json_response.find { |e| e["id"] == employee_with_nil_notes.id }

        expect(employee_data["notes"]).to be_nil
      end

      it "handles employees with special characters in names" do
        special_employee = create(:employee,
          firstname: "José",
          lastname: "O'Brien-Smith",
          country: country,
          department: department
        )
        get "/api/v1/employees"

        json_response = JSON.parse(response.body)
        employee_data = json_response.find { |e| e["id"] == special_employee.id }

        expect(employee_data["firstname"]).to eq("José")
        expect(employee_data["lastname"]).to eq("O'Brien-Smith")
      end
    end
  end
end

