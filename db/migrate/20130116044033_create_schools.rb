class CreateSchools < ActiveRecord::Migration
  def up
    create_table :schools do |t|
      t.string :name
      t.string :latitude
      t.string :longitude
      t.string :isbe
    end
  end

  def down
    drop_table :schools
  end
end
