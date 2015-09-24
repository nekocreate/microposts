class Relationfavotweet < ActiveRecord::Base
  belongs_to :favoer, class_name: "User"
  belongs_to :tweet, class_name: "Micropost"
end
