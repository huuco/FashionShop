10.times do |n|
  User.create! full_name: Faker::Internet.user_name,
    username: Faker::Internet.user_name,
    email: Faker::Internet.free_email,
    password: "123456",
    password_confirmation: "123456",
    role: 0,
    activated: 1
end
20.times do |n|
  Address.create! alias: "my address"+n.to_s,
    full_name: Faker::Name.name,
    post_code: Faker::Address.postcode,
    city: Faker::Address.city,
    country: Faker::Address.country,
    phone: Faker::PhoneNumber.phone_number,
    user_id: rand(1..10)
end


Shipping.create! title: "My shipping",
  description: "",
  price: 15
Shipping.create! title: "UPS",
  description: "",
  price: 20


30.times do |n|
  Brand.create name: Faker::Space.planet,
  description: Faker::Lorem.sentence
end

30.times do |n|
  Category.create name: Faker::Space.moon
end

10.times do |n|
  Product.create name: Faker::LeagueOfLegends.champion,
    price: Faker::Number.decimal(3),
    promotion_price: Faker::Number.decimal(2, 2),
    quantity: Faker::Number.number(2),
    short_description: Faker::Lorem.sentence,
    long_description: Faker::Lorem.paragraph,
    brand_id: rand(0..30),
    category_id: rand(1..30)
end


Payment.create! name: "COD", description: ""
Payment.create! name: "paypal", description: ""

10.times do |n|
  Order.create transaction_id: rand(2000..3000),
    user_id: rand(1..10),
    total: 100+n,
    status: rand(0..2),
    shipping_id: rand(1..2),
    payment_id: rand(1..2),
    address_id: rand(1..20)
end

10.times do |n|
  OrderDetail.create product_id: rand(1..10),
    order_id: rand(1..10),
    quantity: rand(1..5),
    total_price: 1500
end


9.times do |n|
  image = "sp"+(n+1).to_s+".jpg"
  Image.create! image: image,
    product_id: n+1
end

20.times do |n|
  Slide.create! title: "slider"+(n+1).to_s,
    image: "image/path"+(n+1).to_s,
    link: "link"
end
