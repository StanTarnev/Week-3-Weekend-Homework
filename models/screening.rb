require_relative('../db/sql_runner')

class Screening

  attr_reader :id
  attr_accessor :film_id, :show_time, :capacity

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @film_id = options['film_id'].to_i()
    @show_time = options['show_time']
    @capacity = options['capacity']
  end

  def save()
    sql = "INSERT INTO screenings (film_id, show_time, capacity)
          VALUES ($1, $2, $3)
          RETURNING id"
    values = [@film_id, @show_time, @capacity]
    screening = SqlRunner.run(sql, values).first()
    @id = screening['id'].to_i()
  end

  def update()
    sql = "UPDATE screenings SET (film_id, show_time, capacity) = ($1, $2, $3) WHERE id = $4"
    values = [@film_id, @show_time, @capacity, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT *
          FROM screenings
          WHERE id = $1"
    result = SqlRunner.run(sql, [id])
    screening = Screening.new(result.first())
    return screening
  end

end
