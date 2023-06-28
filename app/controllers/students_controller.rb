class StudentsController < ApplicationController
    def index
        students = Student.all
        render json: students

    end

    def show
        student = Student.find_by(params[:id])
        render json: student
    rescue ActiveRecord::RecordNotFound
        render json: { error: "Student not found" }, status: :not_found
    end

    def create
        student = Student.new(student_params)
        if student.save
            render json: student, status: :created
        else
            render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        student = Student.find(params[:id])
        if student.update(student_params)
            render json: student
        else
            render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
        end
    rescue ActiveRecord::RecordNotFound
        render json: { error: "Student not found" }, status: :not_found
    end

    def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    rescue ActiveRecord::RecordNotFound
        render json: { error: "Student not found" }, status: :not_found
    end

    private

    def student_params
        params.require(:student).permit(:name, :major, :age, :instructor_id)
    end
end
