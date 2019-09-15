require_relative('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers (name, funds)
          VALUES ($1,$2)
          RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first()
    @id = customer['id'].to_i()
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.*
          FROM films
          INNER JOIN tickets
          ON tickets.film_id = films.id
          WHERE customer_id = $1"
    films = SqlRunner.run(sql, [@id])
    result = films.map {|film| Film.new(film)}
    return result
  end

  def film_count()
    sql = "SELECT films.*
          FROM films
          INNER JOIN tickets
          ON tickets.film_id = films.id
          WHERE customer_id = $1"
    films = SqlRunner.run(sql, [@id])
    result = films.map {|film| Film.new(film)}
    return result.count
  end

  def self.order_by_funds()
    sql = "SELECT *
          FROM customers
          ORDER BY customers.funds"
    funds = SqlRunner.run(sql, [])
    result = funds.map {|fund| Customer.new(fund)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT *
          FROM customers
          WHERE id = $1"
    result = SqlRunner.run(sql, [id])
    customer = Customer.new(result.first())
    return customer
  end

end
