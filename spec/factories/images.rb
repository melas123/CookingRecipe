FactoryGirl.define do
  factory  :image_with_valid_avatar, class: Image do
    title  "MyString"
    avatar File.open("public/images.jpg")
    recipe
  end

  factory  :image_with_invalid_avatar, class: Image do
    title  "MyString"
    avatar nil
    recipe
  end
  factory  :image_with_no_recipe, class: Image do
    title  "MyString"
    avatar File.open("public/images.jpg")
    recipe nil
  end
end
