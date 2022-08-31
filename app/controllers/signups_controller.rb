class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record

    def create
        signup = Signup.create!(signup_params)
        activity = Activity.find(params[:activity_id])
        render json: activity, status: :created
    end

    private

    def signup_params
        params.permit(:time, :activity_id, :camper_id)
    end

    def render_not_found_response
        render json: {error: 'Camper not found'}, status: :not_found
    end

    def render_invalid_record(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
