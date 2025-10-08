class Lead < ApplicationRecord
  belongs_to :user

  # Enums for interest level and status
  enum :interest_level, {
    low: 0,
    medium: 1,
    high: 2,
    very_high: 3
  }, prefix: true

  enum :status, {
    interested: 0,
    thinking: 1,
    follow_up: 2,
    onboarding: 3,
    accepted: 4,
    denied: 5,
    on_hold: 6
  }, prefix: true

  # Validations
  validates :business_name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, allow_blank: true }
  validates :phone, format: { with: /\A[\d\s\-\+\(\)]+\z/, allow_blank: true }
  validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), allow_blank: true }
  validates :interest_level, presence: true
  validates :status, presence: true

  # Scopes for filtering
  scope :by_status, ->(status) { where(status: status) if status.present? }
  scope :by_interest_level, ->(level) { where(interest_level: level) if level.present? }
  scope :search, ->(query) {
    return all if query.blank?
    where("business_name ILIKE ? OR contact_name ILIKE ? OR location ILIKE ?", 
          "%#{query}%", "%#{query}%", "%#{query}%")
  }
  scope :recent, -> { order(created_at: :desc) }

  # Display helpers
  def interest_level_badge_class
    case interest_level
    when "low" then "badge-secondary"
    when "medium" then "badge-info"
    when "high" then "badge-warning"
    when "very_high" then "badge-danger"
    end
  end

  def status_badge_class
    case status
    when "interested" then "badge-info"
    when "thinking" then "badge-secondary"
    when "follow_up" then "badge-warning"
    when "onboarding" then "badge-primary"
    when "accepted" then "badge-success"
    when "denied" then "badge-danger"
    when "on_hold" then "badge-secondary"
    end
  end
end
