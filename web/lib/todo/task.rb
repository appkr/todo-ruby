# coding: utf-8

require 'active_record'

module Todo

  class Task < ActiveRecord::Base

    NOT_YET = 0
    DONE = 1
    PENDING = 2
    STATUS = {
        'NOT_YET' => NOT_YET,
        'DONE' => DONE,
        'PENDING' => PENDING
    }.freeze

    validates :name, presence: true, length: {maximum: 140}
    validates :content, presence: true
    validates :status, numericality: true, inclusion: {in: STATUS.values}

    scope :status_is, ->(status) { where(status: status) }
    scope :status_is_not_yet, -> { status_is(NOT_YET) }
    scope :status_is_done, -> { status_is(DONE) }
    scope :status_is_pending, -> { status_is(PENDING) }

    def status_name
      STATUS.key(self.status)
    end

  end

end