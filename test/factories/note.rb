# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :title do |n|
    "title#{n}"
  end

  sequence :content do |n|
    "content#{n}"
  end

  factory :note do
    title
    content
    pos_x "0px"
    pos_y "47px"
  end

end