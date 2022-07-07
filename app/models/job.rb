# frozen_string_literal: true

class Job < ApplicationRecord
  has_many :applications, dependent: :destroy

  validates_presence_of :title, :description
end
