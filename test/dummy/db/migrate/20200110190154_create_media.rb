class CreateMedia < ActiveRecord::Migration[6.0]
  def change
    create_table :media do |t|
      t.string :avatar_url
      t.string :video_url

      t.timestamps
    end
  end
end
