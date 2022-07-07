# frozen_string_literal: true

# Application model
class Application < ApplicationRecord
  belongs_to :user
  belongs_to :job

  def self.apply(user_id, job_id)
    Application.create(user_id:, job_id:, seen: false)
  end
end
