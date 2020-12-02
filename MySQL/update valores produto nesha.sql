select z.slug, z.desconto, from (select (ps.price * x.quantity ) as desconto, ps.price descs, ps.product_special_id, x.* from (SELECT produto.product_id, produto.quantity, produto.price, produto.status, (SELECT urlamigavel.keyword FROM oc_url_alias urlamigavel where urlamigavel.query = CONCAT('product_id=', '', produto.product_id)) as slug FROM oc_product produto LEFT JOIN oc_product_description descricao ON descricao.product_id = produto.product_id LEFT JOIN oc_product_to_category produtoCategoria ON produtoCategoria.product_id = produto.product_id ) x  join oc_product_special ps on ps.product_id = x.product_id  where x.slug = '-Faca-Talon-Manchado-MW-Float-0110-CS-GO') z


-- script etapa 1

CREATE TEMPORARY TABLE product_special (id int, valor float);

-- script etapa 2

insert into product_special (id, valor) select z.product_special_id, (z.desc + z.desc * 0.03) from (select (ps.price * x.quantity ) as desconto, ps.price descs, ps.product_special_id, x.* from (SELECT produto.product_id, produto.quantity, produto.price FROM oc_product produto LEFT JOIN oc_product_description descricao ON descricao.product_id = produto.product_id LEFT JOIN oc_product_to_category produtoCategoria ON produtoCategoria.product_id = produto.product_id ) x join oc_product_special ps on ps.product_id = x.product_id ) z;

-- script etapa 3


DELIMITER //
CREATE FUNCTION produtoUpdate (id int, valor float) RETURNS INT
READS SQL DATA
BEGIN
UPDATE oc_product_special ps SET ps.price = valor WHERE ps.product_special_id = id;
RETURN 1;
END
//  DELIMITER

-- script etapa 4

select produtoUpdate(t.id, t.valor) from product_special t;


-- Consultas

select * from neshaupdate.oc_product_special where product_id = 3763; '212703'
select * from neshaupdate.oc_product where product_id = 3763;



select z.slug,
        z.desconto,
        (z.descs*0.97),
        z.product_special_id,
        z.*
 from (


 select (ps.price * x.quantity ) as desconto,
               ps.price descs,
               ps.product_special_id,
               x.*
         from (SELECT produto.product_id,
					  produto.quantity,
					  produto.price,
					  produto.status,
					  (SELECT urlamigavel.keyword
						 FROM oc_url_alias urlamigavel
						where urlamigavel.query = CONCAT('product_id=', '', produto.product_id)) as slug -- ,
					  -- (SELECT GROUP_CONCAT(filter_id)
		--                  FROM oc_product_filter
		--                 WHERE product_id = produto.product_id) as filter
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
 where x.slug in ( '-Faca-Talon-Manchado-MW-Float-0110-CS-GO', 'AWP-Sonho-Febril-MW')
) z







  select format(sum(z.prexquant),2)
    from (select (ps.price * x.quantity ) as prexquant, ps.price descs, x.*
            from (SELECT produto.product_id,
			             produto.quantity,
			             produto.price,
			             produto.status,
			             (SELECT urlamigavel.keyword
			                FROM oc_url_alias urlamigavel
			               where urlamigavel.query = CONCAT('product_id=', '', produto.product_id)) as slug,
			             (SELECT GROUP_CONCAT(filter_id)
			                FROM oc_product_filter
			               WHERE product_id = produto.product_id) as filter
	                FROM oc_product produto
			        LEFT JOIN oc_product_description descricao
			          ON descricao.product_id = produto.product_id
			        LEFT JOIN oc_product_to_category produtoCategoria
			          ON produtoCategoria.product_id = produto.product_id
			       where produtoCategoria.category_id NOT in (63, 64, 69, 74, 75, 76, 77, 78, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 121, 122, 126, 127, 129, 130, 131, 132)
			         and upper(produto.model) not like upper('%cs-go%')
			         and produto.quantity > 0) x
	        join oc_product_special ps
		      on ps.product_id = x.product_id) z;


