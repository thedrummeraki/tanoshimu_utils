class User < ApplicationRecord
  include TanoshimuUtils::Concerns::Identifiable
  include TanoshimuUtils::Concerns::RespondToTypes
  include TanoshimuUtils::Validators::UserLike

  REGULAR = 'regular'
  GOOGLE = 'google'
  ADMIN = 'admin'

  USER_TYPES = [REGULAR, GOOGLE, ADMIN].freeze

  respond_to_types USER_TYPES
  validate_like_user user_types: USER_TYPES
end
