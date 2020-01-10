class Medium < ApplicationRecord
  include TanoshimuUtils::Concerns::ResourceFetch

  has_one_attached :avatar
  has_one_attached :video

  has_resource :avatar, default_url: '/img/404.jpg', expiry: 10.days
  has_resource :video, default_url: '/img/404.mp4', expiry: 1.day
end
