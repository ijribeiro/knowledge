select z.product_id
       z.slug,
       z.desconto,
       (z.desconto*0.97)
  from (select (ps.price * x.quantity ) as desconto,
               ps.price descs,
               x.*
          from (SELECT produto.product_id,
                       produto.quantity,
                       produto.price,
                       produto.status,
                       (SELECT urlamigavel.keyword
                          FROM oc_url_alias urlamigavel
                         where urlamigavel.query = CONCAT('product_id=', '', produto.product_id)) as slug -- ,
                       --(SELECT GROUP_CONCAT(filter_id)
                       --   FROM oc_product_filter
                       --  WHERE product_id = produto.product_id) as filter
                  FROM oc_product produto
                  LEFT JOIN oc_product_description descricao
                    ON descricao.product_id = produto.product_id
                  LEFT JOIN oc_product_to_category produtoCategoria
                    ON produtoCategoria.product_id = produto.product_id
                  -- where produtoCategoria.category_id NOT in (63, 64, 69, 74, 75, 76, 77, 78, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 121, 122, 126, 127, 129, 130, 131, 132)
                  -- where upper(produto.model) not like upper('%cs-go%')
                    -- where produto.quantity > 0
               ) x
  join oc_product_special ps
    on ps.product_id = x.product_id
 where x.slug = '-Faca-Talon-Manchado-MW-Float-0110-CS-GO') z




-- cliente
SELECT c.*
  FROM Cliente c
 WHERE c.name LIKE '%Ferreira e araujo%'

-- Pedido

SELECT p.*
  FROM Pedido p
  JOIN Cliente c
    on c.id = p.id_cliente
  JOIN Vendedor u
   on u.id = p.id_user
  left join Endereco e
    on e.id = p.id_endereco
 WHERE c.name LIKE '%PAULO ROBERTO DONELLAS PEREIRA%'
   AND p.numero is NULL
  -- and u.codRep = '145'
  ORDER BY p.id DESC

  -- endereço de entrega

SELECT e.*
  FROM Pedido p
  JOIN Cliente c
    on c.id = p.id_cliente
  -- JOIN Vendedor u
   -- on u.id = p.id_user
  left join Endereco e
    on e.id = p.id_endereco
 WHERE c.name LIKE '%DILIAM COSTA OLIVEIRA RIGON%'
   AND p.numero is NULL
   -- and u.codRep = '220'
  ORDER BY p.id DESC

delete from Endereco where id in (ID)



<option value="F">Financiamento</option>
<option value="P" selected="">Recurso próprio</option>
<option value="D">Demonstração / Representante</option>
<option value="E">Exportação</option>
<option value="X">Exposição e Feiras</option>