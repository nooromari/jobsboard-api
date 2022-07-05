class ApplicationsController < ApplicationController

    before_action :set_application, only: [:show, :update]

    def index 
        @applications = Application.all
        json_response(@applications)
    end

    def create 
        @application = Application.create!(application_params)
        json_response(@application, :created)
    end

    def show 
        json_response(@application)
    end

    def update 
        @application.update(application_params)
        head :no_content
    end

    private

    def application_params
        params.permit(:job_id, applier_id: :user_id)
    end

    def set_application
        @application = Application.find(params[:id])
    end
end
