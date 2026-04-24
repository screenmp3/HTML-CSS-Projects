declare option output:indent "yes";
  let $max_pop := max(//atraccion/popularidad)
for $atraccion in //atraccion
  where $atraccion/popularidad = $max_pop
  return
  <atraccion>
  <nombre>{$atraccion/nombre/text()}</nombre>
  </atraccion>
