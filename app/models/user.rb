class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :name, presence: true
  validates :email_address, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :birth_date, presence: true, timeliness: true
  validates :profile_image, presence: true, length: { maximum: 2.megabytes.to_i }, allow_blank: true
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  def age
    return unless birth_date

    today = Date.current
    today.year - birth_date.year - ((today.month > birth_date.month || (today.month == birth_date.month && today.day >= birth_date.day)) ? 0 : 1)
  end

  def generate_password_reset_token!
    self.password_reset_token = SecureRandom.urlsafe_base64
    self.password_reset_sent_at = Time.zone.now
    save!
  end

  def self.info
    all.pluck(:name, :email_address, :username)
  end

  # Verificar si el token de restablecimiento es válido
  def password_reset_token_valid?
    (password_reset_sent_at + 2.hours) > Time.current
  end

  def profile_image=(uploaded_image)
    if uploaded_image
      # Convierte la imagen subida en base64 y la guarda en el campo 'profile_image'
      self[:profile_image] = Base64.encode64(uploaded_image.read)
    else
      self[:profile_image] = nil
    end
  end
end
