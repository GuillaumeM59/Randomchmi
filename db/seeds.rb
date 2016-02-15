a=["Guillaume",
"Sophie",
"Jade",
"Philippe",
"Anas",
"Najib",
"Marc",
"Antoine",
"Thierry",
"Anthony",
"Thomas",
"Vincent",
"Alexis",
"Julie",
"Sabrina",
"Bertrand",
"Naïma",
"François",
"Othman",
"Caroline",
"Didier",
"Thanh",
"Manoël"]

23.times do |i|
    us = Person.create(
          name: "#{a[i]}",
          email: "#{a[i]}@gmail.com",
          tel: 612345678 ,
          sensei: false ,
          )
    end
