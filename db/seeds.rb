require "csv"

AdminUser.delete_all
User.destroy_all
Order.destroy_all
OrderItem.destroy_all
Car.delete_all
SocialMedia.delete_all
Manufacturer.delete_all

# Load data from manufacturers.csv
filename_manufacturers = Rails.root.join("db/manufacturers.csv")
puts "Loading manufacturers data from csv file: #{filename_manufacturers}"

csv_data_manufacturers = File.read(filename_manufacturers)
manufacturers = CSV.parse(csv_data_manufacturers, headers: true, encoding: "utf-8")

manufacturers.each do |manufacturer_data|
  manufacturer = Manufacturer.create(
    name: manufacturer_data["name"],
    site: manufacturer_data["site"]
  )

  # Crear la instancia de SocialMedia asociada al fabricante
  social_media = SocialMedia.create(
    twitter: manufacturer_data["twitter"],  # Asignar el nombre del fabricante a twitter
    facebook: manufacturer_data["facebook"],  # Asignar el valor del CSV a facebook
    instagram: manufacturer_data["instagram"],  # Asignar el valor del CSV a instagram
    youtube: manufacturer_data["youtube"],  # Asignar el valor del CSV a youtube
    linkedin: manufacturer_data["linkedin"]
  )

  # Asociar el SocialMedia al Manufacturer
  manufacturer.social_media = social_media
  manufacturer.save  # Guardar el manufacturer después de asociar

  created_cars_count = 0

  # Load data from cars.csv
  filename_cars = Rails.root.join("db/cars.csv")
  puts "Loading cars data from csv file: #{filename_cars}"

  csv_data_cars = File.read(filename_cars)
  cars = CSV.parse(csv_data_cars, headers: true, encoding: "utf-8")

  cars.each do |car_data|
    next unless car_data["manufacturer_id"] == manufacturer_data["id"]
    next unless car_data["brand"].downcase == manufacturer_data["name"].downcase

    break if created_cars_count >= 30 # Salir después de crear 20 carros por manufactura

    car = manufacturer.cars.create(
      price: car_data["price"].to_f,
      brand: car_data["brand"],
      model: car_data["model"],
      year: car_data["year"].to_i,
      title_status: car_data["title_status"],
      mileage: car_data["mileage"].to_i,
      color: car_data["color"],
      vin: car_data["vin"],
      lot: car_data["lot"],
      state: car_data["state"],
      condition: car_data["condition"]
    )

    query = URI.encode_www_form_component([car.model + ' car', manufacturer.name + ' car', car.color+ ' car'].join(','))
    download_image = URI.open("https://source.unsplash.com/600x600/?#{query}")
    car.image.attach(io: download_image,
                     filename: "m-#{[car.model + ' car',
                                     manufacturer.name + ' car', car.color + ' car'].join('-')}.jpg")
    sleep(1)

    created_cars_count += 1
  end
end

user = User.create!(
  first_name: 'Nombre',
  last_name: 'Apellido',
  email: 'usuario@example.com',
  address: '100 123 direccion',
  province: 'Manitoba',
  state: 'Manitoba',
  country: 'Canada',
  encrypted_password:'password',
  reset_password_token: nil,
  reset_password_sent_at: nil,
  remember_created_at: nil
)
order = Order.create!(
  user_id: user.id,
  total_amount: 100.00, # Reemplazar con el monto real
  status: 'pending' # Otros estados como 'paid', 'shipped', etc.
)

# Crear un nuevo order_item asociado al pedido
car = Car.first # Reemplazar con el carro real
order_item = OrderItem.create!(
  order_id: order.id,
  car_id: car.id,
  quantity: 1, # Reemplazar con la cantidad real
  price: car.price # Reemplazar con el precio real
)

puts "Created #{Manufacturer.count} Manufacturers."
puts "Created #{Car.count} Cars."
puts "Created #{SocialMedia.count} SocialMedia instances."
puts 'Usuario creado exitosamente.'
if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password',
                    password_confirmation: 'password')
end
