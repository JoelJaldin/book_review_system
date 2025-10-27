# Crear usuarios
users = [
  { name: "Ana García", email: "ana@example.com", banned: false },
  { name: "Carlos López", email: "carlos@example.com", banned: false },
  { name: "María Rodríguez", email: "maria@example.com", banned: false },
  { name: "Pedro Martínez", email: "pedro@example.com", banned: false },
  { name: "Laura Sánchez", email: "laura@example.com", banned: false },
  { name: "Usuario Baneado", email: "baneado@example.com", banned: true }
]

users.each do |user_attrs|
  User.find_or_create_by!(email: user_attrs[:email]) do |user|
    user.name = user_attrs[:name]
    user.banned = user_attrs[:banned]
  end
end

# Crear libros
books = [
  { title: "Cien años de soledad", author: "Gabriel García Márquez" },
  { title: "Don Quijote de la Mancha", author: "Miguel de Cervantes" },
  { title: "1984", author: "George Orwell" },
  { title: "El Principito", author: "Antoine de Saint-Exupéry" },
  { title: "Orgullo y prejuicio", author: "Jane Austen" },
  { title: "El señor de los anillos", author: "J.R.R. Tolkien" },
  { title: "Harry Potter y la piedra filosofal", author: "J.K. Rowling" },
  { title: "El código Da Vinci", author: "Dan Brown" }
]

books.each do |book_attrs|
  Book.find_or_create_by!(title: book_attrs[:title]) do |book|
    book.author = book_attrs[:author]
  end
end

# Crear reseñas para algunos libros
book1 = Book.find_by(title: "Cien años de soledad")
book2 = Book.find_by(title: "1984")
book3 = Book.find_by(title: "El Principito")

# Usuarios normales
user1 = User.find_by(email: "ana@example.com")
user2 = User.find_by(email: "carlos@example.com")
user3 = User.find_by(email: "maria@example.com")
user4 = User.find_by(email: "pedro@example.com")
user5 = User.find_by(email: "laura@example.com")

# Usuario baneado
banned_user = User.find_by(email: "baneado@example.com")

# Reseñas para "Cien años de soledad"
if book1
  [
    { user: user1, rating: 5, content: "Una obra maestra de la literatura latinoamericana. García Márquez crea un mundo mágico y realista que te atrapa desde la primera página.", reviewer_name: "Ana García" },
    { user: user2, rating: 4, content: "Excelente novela, aunque a veces puede ser un poco densa. La prosa es hermosa y los personajes muy bien desarrollados.", reviewer_name: "Carlos López" },
    { user: user3, rating: 5, content: "Simplemente espectacular. Una de las mejores novelas que he leído en mi vida. La recomiendo totalmente.", reviewer_name: "María Rodríguez" },
    { user: user4, rating: 4, content: "Muy buena historia, aunque requiere concentración para seguir todos los personajes. Vale la pena el esfuerzo.", reviewer_name: "Pedro Martínez" },
    { user: user5, rating: 5, content: "Una joya literaria. La forma en que García Márquez mezcla realidad y fantasía es única.", reviewer_name: "Laura Sánchez" },
    { user: banned_user, rating: 1, content: "No me gustó para nada. Muy aburrido.", reviewer_name: "Usuario Baneado" }
  ].each do |review_attrs|
    book1.reviews.find_or_create_by!(user: review_attrs[:user]) do |review|
      review.rating = review_attrs[:rating]
      review.content = review_attrs[:content]
      review.reviewer_name = review_attrs[:reviewer_name]
    end
  end
end

# Reseñas para "1984"
if book2
  [
    { user: user1, rating: 5, content: "Una distopía que te hace reflexionar sobre el poder y la libertad. Muy actual a pesar de haber sido escrita hace décadas.", reviewer_name: "Ana García" },
    { user: user2, rating: 4, content: "Excelente novela de ciencia ficción. La descripción del mundo totalitario es muy convincente.", reviewer_name: "Carlos López" },
    { user: user3, rating: 5, content: "Un clásico que todo el mundo debería leer. La visión de Orwell sobre el futuro es escalofriante.", reviewer_name: "María Rodríguez" }
  ].each do |review_attrs|
    book2.reviews.find_or_create_by!(user: review_attrs[:user]) do |review|
      review.rating = review_attrs[:rating]
      review.content = review_attrs[:content]
      review.reviewer_name = review_attrs[:reviewer_name]
    end
  end
end

# Reseñas para "El Principito"
if book3
  [
    { user: user1, rating: 5, content: "Un libro aparentemente simple pero con una profundidad increíble. Cada vez que lo leo descubro algo nuevo.", reviewer_name: "Ana García" },
    { user: user2, rating: 4, content: "Una historia hermosa y conmovedora. Perfecta para todas las edades.", reviewer_name: "Carlos López" }
  ].each do |review_attrs|
    book3.reviews.find_or_create_by!(user: review_attrs[:user]) do |review|
      review.rating = review_attrs[:rating]
      review.content = review_attrs[:content]
      review.reviewer_name = review_attrs[:reviewer_name]
    end
  end
end

puts "Seeds creados exitosamente!"
puts "- #{User.count} usuarios creados"
puts "- #{Book.count} libros creados"
puts "- #{Review.count} reseñas creadas"
