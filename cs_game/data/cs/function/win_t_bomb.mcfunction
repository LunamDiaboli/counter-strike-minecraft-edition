# Выводим сообщение
title @a title {"text":"БОМБА ВЗОРВАНА","color":"red"}

# Создаем мгновенный мощный взрыв на месте маркера (используем крипера с Fuse 0)
execute at @e[type=armor_stand,tag=c4_entity] run summon creeper ~ ~ ~ {ExplosionRadius:10b,Fuse:0,ignited:1b}

# Удаляем блок TNT из мира (ищем в радиусе 3 блоков от маркера бомбы)
execute at @e[type=armor_stand,tag=c4_entity] run fill ~-3 ~-3 ~-3 ~3 ~3 ~3 air replace tnt

# Уничтожаем технический маркер бомбы
kill @e[type=armor_stand,tag=c4_entity]

# Вызываем стандартную победу террористов
function cs:win_t