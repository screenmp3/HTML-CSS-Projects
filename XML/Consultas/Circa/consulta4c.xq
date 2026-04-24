declare option output:indent "yes";
for $atraccion in //atraccion
  where exists(//$atraccion/averias/averia)
  return
  <atraccion>
  <nombre>{$atraccion/nombre/text()}</nombre>
  </atraccion>
