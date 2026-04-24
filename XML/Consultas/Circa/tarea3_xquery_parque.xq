"1.Obtener el nombre y la capacidad de las atracciones de tipo 'Familiar'","",
 for $atraccion in /parque_atracciones/atracciones/atraccion[tipo = "Familiar"]
    return
      <atraccion>
        <nombre>{$atraccion/nombre/text()}</nombre>
        <capacidad>{$atraccion/capacidad/text()}</capacidad>
      </atraccion>,"",
"2.Encontrar la atracción con la mayor popularidad.","",
 let $max_popularidad := max(/parque_atracciones/atracciones/atraccion/popularidad)
 return /parque_atracciones/atracciones/atraccion[popularidad = $max_popularidad]/nombre/text(),"",
 "3.Obtener el nombre de los empleados y el nombre de la atracción que operan (si tienen una asignada).","",
 for $empleado in /parque_atracciones/empleados/empleado
        let $atraccion := /parque_atracciones/atracciones/atraccion[@id = $empleado/atraccion_asignada]
        return
           if (exists($atraccion))
           then <empleado><nombre>{$empleado/nombre/text()}</nombre>
                <atraccion>{$atraccion/nombre/text()}</atraccion>
                </empleado>
           else <empleado><nombre>{$empleado/nombre/text()}</nombre>
                <atraccion>Ninguna</atraccion>
                </empleado>,"",
"4.Listar las atracciones que han tenido averías.","",
 for $a in /parque_atracciones/atracciones/atraccion[averias/averia]
   return $a/nombre,"",
"5.Mostrar las fechas de las averías de la 'Montaña Rusa Dragón'","",
for $atraccion in /parque_atracciones/atracciones/atraccion[nombre = "Montaña Rusa Dragón"]
    return $atraccion/averias/averia/@fecha,"",
"6 Contar cuántas atracciones hay de cada tipo.","",
for $tipo in distinct-values(/parque_atracciones/atracciones/atraccion/tipo)
    let $atracciones :=/parque_atracciones/atracciones/atraccion[tipo = $tipo]
    return
      <tipo>
        <nombre>{$tipo}</nombre>
        <cantidad>{count($atracciones)}</cantidad>
      </tipo>,"",
"7. Para cada visitante, mostrar su nombre y las atracciones a las que puede acceder según su altura.","",
for $visitante in /parque_atracciones/visitantes/visitante
    return
        <visitante>
            <nombre>{$visitante/nombre/text()}</nombre>
            <atracciones_accesibles>
            {
                for $atraccion in /parque_atracciones/atracciones/atraccion
                where $visitante/altura >= $atraccion/altura_minima
                return <atraccion>{$atraccion/nombre/text()}</atraccion>
            }
            </atracciones_accesibles>
        </visitante>,"",
"8.Listar los nombres de los restaurantes y su valoración, ordenados de mayor a menor valoración.","",
for $r in /parque_atracciones/restaurantes/restaurante
        order by $r/valoracion descending
        return
            <restaurante>
                <nombre>{$r/nombre/text()}</nombre>
                <valoracion>{$r/valoracion/text()}</valoracion>
            </restaurante>,"",
"9.Mostrar los eventos y las atracciones relacionadas con cada uno.","",
for $evento in /parque_atracciones/eventos/evento
    return
      <evento>
        <nombre>{$evento/nombre/text()}</nombre>
        <atracciones>
          {
            for $atraccion_id in $evento/atracciones_relacionadas/atraccion_id
            let $atraccion := /parque_atracciones/atracciones/atraccion[@id = $atraccion_id]
            return
              <atraccion>{$atraccion/nombre/text()}</atraccion>
          }
        </atracciones>
      </evento>,"",
"10.Encontrar los visitantes cuyas preferencias incluyan 'Montaña Rusa'.","",
for $v in /parque_atracciones/visitantes/visitante
        where $v/preferencias/preferencia[@tipo eq "Montaña Rusa"]
        return $v/nombre,"",
"11. Muestra la información de la atracción (nombre, tipo y altura mínima) junto a la información de los empleados asignados a esa atracción (nombre y puesto)","",
 for $atraccion in /parque_atracciones/atracciones/atraccion
    let $empleados := /parque_atracciones/empleados/empleado[atraccion_asignada = $atraccion/@id]
    return
      <atraccion_info>
        <atraccion>
            <nombre>{$atraccion/nombre/text()}</nombre>
            <tipo>{$atraccion/tipo/text()}</tipo>
            <altura_minima>{$atraccion/altura_minima/text()}</altura_minima>
        </atraccion>
        <empleados>
        {
            for $empleado in $empleados
            return
               <empleado>
                    <nombre>{$empleado/nombre/text()}</nombre>
                    <puesto>{$empleado/puesto/text()}</puesto>
                </empleado>
        }
        </empleados>
      </atraccion_info>,"",
"12. Obtener los diferentes tipos de atracciones que comienzan con la letra 'M'.","",
distinct-values(
    for $atraccion in /parque_atracciones/atracciones/atraccion
    where starts-with($atraccion/tipo, "M")
    return $atraccion/tipo/text()
),"",
"13. Encontrar el promedio de la altura mínima de las atracciones.","",
avg(
    for $atraccion in /parque_atracciones/atracciones/atraccion
    return number($atraccion/altura_minima)
),"",
"14.Listar los nombres de las atracciones cuyo nombre contenga la palabra 'Dragón' ","",
for $atraccion in /parque_atracciones/atracciones/atraccion
where contains(lower-case($atraccion/nombre/text()), "dragón")
return $atraccion/nombre/text(),"",
"15.Obtener una lista de todos los años en los que ha habido averías. ","",
distinct-values(
    for $atraccion in /parque_atracciones/atracciones/atraccion
    for $averia in $atraccion/averias/averia
    return substring(string($averia/@fecha), 1, 4)
),"",
"16.Para cada atracción, mostrar su nombre y el número de empleados que no están asignados a ella, pero que tienen un puesto de ‘Operador’.","",
for $atraccion in /parque_atracciones/atracciones/atraccion
let $empleados_no_asignados := /parque_atracciones/empleados/empleado
                                [puesto = "Operador" and not(atraccion_asignada = $atraccion/@id)]
return
   <atraccion>
      <nombre>{$atraccion/nombre/text()}</nombre>
      <operadores_no_asignados>{count($empleados_no_asignados)}</operadores_no_asignados>
   </atraccion>,"",
"17.Mostrar, para cada evento, el nombre del evento y los nombres de todos los restaurantes del parque, independientemente de si están o no relacionados con el evento","",
for $evento in /parque_atracciones/eventos/evento 
return <evento> 
       <nombre_evento>{$evento/nombre/text()}</nombre_evento> 
       <restaurantes> { for $restaurante in //restaurante 
                       return <nombre_restaurante>{$restaurante/nombre/text()}</nombre_restaurante> } 
                              </restaurantes> 
       </evento>,"",
"18. Encontrar los pares de atracciones (nombre de la atracción 1, nombre de la atracción 2) que tengan exactamente la misma altura mínima, pero no sean la misma atracción.En caso de que no haya devuelva la marca con NINGUNA.","",
let $pares :=
    for $atraccion1 in //atraccion
    for $atraccion2 in //atraccion
    where $atraccion1/altura_minima = $atraccion2/altura_minima and $atraccion1/@id != $atraccion2/@id
    return
      <par_atracciones>
        <atraccion1>{$atraccion1/nombre/text()}</atraccion1>
        <atraccion2>{$atraccion2/nombre/text()}</atraccion2>
      </par_atracciones>

return
 if (empty($pares)) then (:not(exists($pares)):)
    <par_atracciones>NINGUNA</par_atracciones>
  else
   $pares,"",
"19. Para cada visitante, mostrar su nombre, su altura y los nombres de todas las atracciones, junto con una indicación de si el visitante cumple o no la altura mínima para cada atracción  ","",
 for $visitante in //visitante
 return
   <visitante>
     <nombre>{$visitante/nombre/text()}</nombre>
     <altura>{$visitante/altura/text()}</altura>
     <atracciones>
     {
       for $atraccion in //atraccion
       return
         <atraccion>
           <nombre>{$atraccion/nombre/text()}</nombre>
           <cumple_altura>{
             if (number($visitante/altura) >= number($atraccion/altura_minima))
             then "Sí"
             else "No"
           }</cumple_altura>
         </atraccion>
     }
     </atracciones>
   </visitante>,"",
"20. Devuelva una cadena con los nombres de todos los empleados que tienen el mismo puesto, separados por comas.","",
<informe>
  {let $puesto := distinct-values(//empleado/puesto/text())
  for $p in $puesto
    let $e := //empleado[puesto = $p]
    return 
           (<puesto>{$p}</puesto>,
           <empleados>{string-join($e/nombre,', ')}</empleados>)
}</informe>          
 
