# Chqto - TTPS Ruby - Lopez Luciano Ariel

## Usuarios de prueba:

# Para ejecutar y probar esta aplicacion se necesita seguir los siguientes pasos:
- Tener Ruby 3.2.2 instalado
- Ejecutar en orden los siguientes comandos:

```bash
1. bundle install

2. rails db:drop 

3. rails db:create 

4. rails db:migrate

5. rails db:seed

6. rails server
```

## Consideraciones que se tuvieron para el desarrollo de la aplicacion:
* Se utilizo la gema Devise para la autenticacion.
* Se utilizo la gema Pagy para realizar paginacion ya que Kaminari y Will Paginate no funcionaron ya sea por incompatibilidad o errores al utilizarlas.
* Se utilizo la gema jquery-rails para mostrar u ocultar campos en formularios.
* Se utilizo la gema rails-i18n para ayudar a la traduccion de la aplicacion a español.
* Se utilizo la gema bcrypt para la encriptacion de la contraseña de los links privados.
* En el modelo de Links en un principio se habia decidido manejarlo con string pero mas adelante en el desarrollo se noto que era mas correcto usar un enum para los tipos de links ya que era mas modularizable, simple de manejar y de extender en un futuro, el uso de una jerarquia podria ser mas optimo, pero un enum me parecio la manera mas simple y eficiente para la identificacion de tipos de links.
* Se decidio mostrar los accesos y estadisticas de los links en la vista show del link ya que se tuvo en cuenta que no hay suficiente informacion para plasmar y la informacion que se muestra tiene relacion directa con el link.
* En cuanto a las estadisticas se decidio mostrar la cantidad de dias desde la existencia del link, la cantidad de visitas concretadas y el promedio entre estas dos (si se filtra por un rango de fechas estas estadisticas se calcula en relacion al filtro aplicado).