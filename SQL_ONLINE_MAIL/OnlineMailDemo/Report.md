c4ca4238a0b923820dcc509a6f75849b



触发器 新建订单、取消订单，库存更新。

函数 

视图 买家订单中的买家信息。



增 加入购物车，新建订单

删 移出购物车

改 修改订单的当前状态

查 查询商品

事务处理



关于Order

草拟 Draft D

取消 Cancel C

执行 Running R

完成 Finished F

换货 Exchange E

退货 Back B



在显示订单详情中使用视图以合并显示不同表的信息，而购物车详情内采用的是Python程序进行多次查询的方法，相较而言使用视图简化了程序设计的复杂度。

seller在order detail内错写为deital，其余错写为detial。



```SQL
drop procedure if exists viewSaleListWeek;
delimiter //
create procedure viewSaleListWeek()
begin
	drop table if exists saleList;
	create temporary table saleList(number int unsigned not null, id int unsigned not null primary key);
	drop table if exists typeList;
	create temporary table typeList(number int unsigned not null, type varchar(45) not null primary key);
	insert into saleList select sum(order_detial_number),order_detial_goods_id from order_detial where order_detial_status='F' and order_detial_time>date_sub(now(),interval 7 Day) group by order_detial_goods_id;
	insert into typeList select sum(number), goods_type from saleList, goods where saleList.id=goods.goods_id group by goods_type;
end //
delimiter ;


drop procedure if exists viewSaleListMonth;
delimiter //
create procedure viewSaleListMonth()
begin
	drop table if exists saleList;
	create temporary table saleList(number int unsigned not null, id int unsigned not null primary key);
	drop table if exists typeList;
	create temporary table typeList(number int unsigned not null, type varchar(45) not null primary key);
	insert into saleList select sum(order_detial_number),order_detial_goods_id from order_detial where order_detial_status='F' and  order_detial_time>date_sub(now(),interval 1 Month) group by order_detial_goods_id;
	insert into typeList select sum(number), goods_type from saleList, goods where saleList.id=goods.goods_id group by goods_type;
end //
delimiter ;




 where order_detial_time>date_sub(now(),interval 1 Month)
```

```SQL
delimiter //
drop trigger if exists updateOrderStatus;
create trigger `updateOrderStatus` after update on `customer_order` for each row
begin
	update order_detial set order_detial_status=NEW.`customer_order_status` where order_detial_customer_order_id=OLD.`customer_order_id`;
end //
delimiter ;



delimiter //
drop trigger if exists updateTypeInfo;
create trigger `updateTypeInfo` after update on `goods_type` for each row
begin
	update goods set goods_type=NEW.`goods_type` where goods_type=OLD.`goods_type`;
end //
delimiter ;


delimiter //
drop trigger if exists updateTypeInfo;
create trigger `updateTypeInfo` before update on `goods_type` for each row
begin
	SET FOREIGN_KEY_CHECKS=0; 
	update goods set goods_type=NEW.`goods_type` where goods_type=OLD.`goods_type`;
	SET FOREIGN_KEY_CHECKS=1;
end //
delimiter ;

update goods_type set goods_type="Tools" where goods_type="Tool";

delimiter //
drop trigger if exists updateTypeInfo;
create trigger `updateTypeInfo` after update on `goods_type` for each row
begin
	declare @old varchar(45);
	declare @new varchar(45);
	update goods set goods_type=NEW.`goods_type` where goods_type=OLD.`goods_type`;
end //
delimiter ;

CREATE TRIGGER Updateid ON dbo.mastertable
FOR UPDATE
AS
declare @oldid varchar(10),
@newid char(10)
select @oldid=deleted.id from deleted
select @newid=mastertable.id from mastertable,inserted where mastertable.id=inserted.id
if (@oldid is null) or (@newid is null) or (@oldid=@newid) return
update detailtable set id=@newid where id=@oldid
```

