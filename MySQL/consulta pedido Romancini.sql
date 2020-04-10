SELECT *
  FROM Pedido p
  JOIN Cliente c
 WHERE c.name LIKE '%CASSIANO SILVEIRA%'
   AND p.numero is NULL
  ORDER BY p.id DESC