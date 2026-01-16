class Task < ApplicationRecord
  enum :status, { pending: 0, completed: 1 }, default: :pending

  belongs_to :creator, class_name: "User"
  belongs_to :assigned_to, class_name: "User", optional: true

  validates :title, :description, :due_date, presence: true
  validate :due_date_in_future
  validate :assigned_to_is_member, if: -> { assigned_to_id.present? }

  private

  def due_date_in_future
    return if due_date.blank?
    errors.add(:due_date, "must be in the future") if due_date <= Date.today
  end

  def assigned_to_is_member
    errors.add(:assigned_to, "must be a member") unless assigned_to&.member?
  end
end
