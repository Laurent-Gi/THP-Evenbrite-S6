class Event < ApplicationRecord
  belongs_to :administrator, class_name: 'User'
  has_many :attendances
  has_many :users, through: :attendances

  validate :start_date_must_be_later

  validates :start_date, presence: true

  # validates :duration, presence: true, numericality: { greater_than: 4 }
  validate :duration_format
  validates :duration, presence: true
  
  validates :title, presence: true, length: {in: 5..140}

  validates :description, presence: true, length: { in: 20..1000 }

  validates :price, presence: true,
  numericality: { greater_than: 0, less_than: 1001 }

  validates :location, presence: true

  private

  def start_date_must_be_later
    errors.add(:start_date, "must be after now") unless
        start_date > Time.now
  end

  def duration_format
    errors.add(:duration, "must be a positive mutiple of 5") unless
      duration > 0 && duration % 5 == 0
  end
end
