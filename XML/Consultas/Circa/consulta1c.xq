declare option output:indent "yes";
for $atraccion in //atraccion
  where $atraccion/tipo = "Familiar"
  return 
  <atraccion>
  <nombre>{$atraccion/nombre/text()}</nombre>
  </atraccion>
