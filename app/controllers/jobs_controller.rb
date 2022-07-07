# frozen_string_literal: true

# This class is to handle jobs.
class JobsController < ApplicationController
  before_action :set_job, only: %i[show update destroy]
  authorize_resource

  def index
    @jobs = Job.all
    json_response(@jobs)
  end

  def create
    @job = Job.create!(job_params)
    json_response(@job, :created)
  end

  def show
    json_response(@job)
  end

  def update
    @job.update(job_params)
    head :no_content
  end

  def destroy
    @job.destroy
    head :no_content
  end

  private

  def job_params
    params.permit(:title, :description)
  end

  def set_job
    @job = Job.find(params[:id])
  end
end
