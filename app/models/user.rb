class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { admin: 0, manager: 1, member: 2 }, default: :member

  validates :first_name, :last_name, presence: true

  has_many :created_tasks,
           class_name: "Task",
           foreign_key: "creator_id",
           dependent: :nullify

  has_many :assigned_tasks,
           class_name: "Task",
           foreign_key: "assigned_to_id",
           dependent: :nullify

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
