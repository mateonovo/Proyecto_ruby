# README
Pryecto Mateo

Requisitos para correr la app

Ruby version = 3.2.2 


Linux OS/MACos/Windows

Firefox/Chrome

Git clone https://github.com/mateonovo/Proyecto_ruby.git

Pasos para correr la app localmente
Clonar el repo

git clone 
Dentro de la carpeta del proyecto correr los siguientes comandos:

instalar todas las dependencias necesarias:
  -bundle install 

Genera la base de datos con datos de prueba
  -rails db:migrate
  -rails db:seed

Corre el servidor local:
  -rails s
Para acceder a la aplicación hay que entrar a la siguiente url desde el navegador 

http://127.0.0.1:3000/


En el sistema ya hay cargados varios usuarios
Todos tienen contraseña: "123456"
Los usuarios son los siguientes:
- user1@gmail.com
- user2@gmail.com



Gemas usadas :
 devise: modelo de usuarios  , ABM. 
 ransack: Se uso para el filtrado de accesos en los links.
 will_paginate : Paginado.
 bootstrap: estilos.
 groupdate: Para las estadisticas de cantidad de accesos al link por dia. 
 Rails version = 7.1.2


