declare option output:indent "yes";
for $empleado in //empleado
  let $atraccion := //atraccion[@id=$empleado/atraccion_asignada]
  return
  if (exists($atraccion))
    then
    <empleado>
      <nombre>{$empleado/nombre/text()}</nombre>
      <atraccion>{$atraccion/nombre/text()}</atraccion>
    </empleado>
    else
    <empleado>
      <nombre>{$empleado/nombre/text()}</nombre>
      <atraccion>Ninguna</atraccion>
    </empleado>
