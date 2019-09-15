require_relative('models/film')
require_relative('models/customer')
require_relative('models/ticket')

require('pry-byebug')

Film.delete_all()
Customer.delete_all()
Ticket.delete_all()

customer1 = Customer.new({
  'name' => 'Eduardo Noriega',
  'funds' => 350
  })

customer1.save()

customer2 = Customer.new({
  'name' => 'Hans Neumann',
  'funds' => 250
  })

customer2.save()

customer3 = Customer.new({
  'name' => 'Philippe LeGrand',
  'funds' => 400
  })

customer3.save()
customer3.funds = 300
customer3.update()

customer4 = Customer.new({
  'name' => 'Hassan Al-Ghraibi',
  'funds' => 200
  })

customer4.save()
customer4.delete()

film1 = Film.new({
  'title' => 'The Bad and the Beautiful',
  'price' => 15
  })

film1.save()

film2 = Film.new({
  'title' => 'Three Little Secrets',
  'price' => 12
  })

film2.save()

film3 = Film.new({
  'title' => 'Meanwhile',
  'price' => 10
  })

film3.save()
film3.price = 18
film3.update()

film4 = Film.new({
  'title' => "Here and Now",
  'price' => 10
  })

film4.save()
film4.delete()

ticket1 = Ticket.new({
  'film_id' => film1.id,
  'customer_id' => customer1.id
  })

ticket1.save()

ticket2 = Ticket.new({
  'film_id' => film2.id,
  'customer_id' => customer3.id
  })

ticket2.save()

ticket3 = Ticket.new({
  'film_id' => film3.id,
  'customer_id' => customer1.id
  })

ticket3.save()

ticket4 = Ticket.new({
  'film_id' => film1.id,
  'customer_id' => customer2.id
  })

ticket4.save()

ticket5 = Ticket.new({
  'film_id' => film2.id,
  'customer_id' => customer3.id
  })

ticket5.save()
ticket5.film_id = film3.id
ticket5.update()

ticket6 = Ticket.new({
  'film_id' => film2.id,
  'customer_id' => customer2.id
  })

ticket6.save()
ticket6.delete()

found_film = Film.find(film2.id)
found_customer = Customer.find(customer3.id)
found_ticket = Ticket.find(ticket4.id)

sorted_by_funds = Customer.order_by_funds()

binding.pry
nil
