class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  has_one :profile
  has_many :playlists
  has_many :tracks, through: :playlists

  accepts_nested_attributes_for :profile

  before_create :set_default_role

  private
  def set_default_role
    self.role ||= Role.find_by_name('registered')
  end
end
