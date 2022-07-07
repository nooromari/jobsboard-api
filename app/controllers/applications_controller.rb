# frozen_string_literal: true

# ApplicationsController is for controll applications
class ApplicationsController < ApplicationController
  before_action :set_job, :set_user_id
  before_action :set_job_application, only: %i[show update]
  authorize_resource

  def index
    @applications = Application.all
    json_response(@applications)
  end

  def create
    @application = Application.apply(@user_id, @job.id)
    json_response(@application, :created)
  end

  def show
    @application.update(seen: true)
    json_response(@application)
  end

  private

  def set_job
    @job = Job.find(params[:job_id])
  end

  def set_job_application
    @application = @job.applications.find_by!(id: params[:id]) if @job
  end

  def set_user_id
    @user_id = current_user.id
  end
end
