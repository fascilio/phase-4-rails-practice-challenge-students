class InstructorsController < ApplicationController
    def index
        instructors = Instructor.all
        render json: instructors
    end

    def show
        instructor = Instructor.find(params[:id])
        render json: instructor
    rescue ActiveRecord::RecordNotFound
        render json: {error: "Instructor not found"}, status: :not_found
    end

    def create
        instructor = Instructor.new(instructor_params)
        if instructor.save
            render json: instructor, status: :created
        else 
            render json: {errors: instructor.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def update
        instructor = Instructor.find(params[:id])
        if instructor.update(instructor_params)
            render json: instructor
        else 
            render json: {errors: instructor.errors.full_messages}, status: :unprocessable_entity
        end
    rescue ActiveRecord::RecordNotFound
        render json: { error: "Instructor not found" }, status: :not_found 
    end

    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content
    rescue ActiveRecord::RecordNotFound
        render json: {error: "Instructor not found"}, status: :not_found
    end

    private

    def instructor_params
        params.require(:instructor).permit(:name)
    end
end
