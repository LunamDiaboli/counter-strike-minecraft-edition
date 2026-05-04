# --- СИСТЕМА ВЫДАЧИ ЭКИПИРОВКИ (KOLOK4P@) ---

# 1. ОЧИСТКА ТОЛЬКО БАЗОВЫХ ВЕЩЕЙ
# Мы не трогаем железные мечи, арбалеты и покупную броню!
clear @a wooden_sword
clear @a leather_helmet
clear @a leather_chestplate
clear @a leather_leggings
clear @a leather_boots
clear @a minecraft:tnt
clear @a minecraft:shears

# 2. ОБЩЕЕ СНАРЯЖЕНИЕ
# Базовый нож выдается всем всегда
give @a wooden_sword[unbreakable={},item_name={"text":"Тренировочный нож","italic":false}] 1

# 3. ЭКИПИРОВКА СПЕЦНАЗА (CT)
# Броня автоматически надевается в слоты (item replace) ТОЛЬКО если эти слоты пустые (unless items).
execute as @a[team=CT] unless items entity @s armor.head * run item replace entity @s armor.head with leather_helmet[unbreakable={},dyed_color=3949738,item_name={"text":"Шлем спецназа","color":"blue","italic":false}]
execute as @a[team=CT] unless items entity @s armor.chest * run item replace entity @s armor.chest with leather_chestplate[unbreakable={},dyed_color=3949738,item_name={"text":"Бронежилет спецназа","color":"blue","italic":false}]
execute as @a[team=CT] unless items entity @s armor.legs * run item replace entity @s armor.legs with leather_leggings[unbreakable={},dyed_color=3949738,item_name={"text":"Тактические поножи","color":"blue","italic":false}]
execute as @a[team=CT] unless items entity @s armor.feet * run item replace entity @s armor.feet with leather_boots[unbreakable={},dyed_color=3949738,item_name={"text":"Ботинки спецназа","color":"blue","italic":false}]

# Выдача Defuse Kit (Ножницы) одному живому спецназовцу
execute as @r[team=CT,gamemode=adventure] run give @s shears[item_name={"text":"Набор сапера (Defuse Kit)","color":"aqua","bold":true,"italic":false}] 1

# 4. ЭКИПИРОВКА ТЕРРОРИСТОВ (T)
execute as @a[team=T] unless items entity @s armor.head * run item replace entity @s armor.head with leather_helmet[unbreakable={},dyed_color=11546150,item_name={"text":"Маска террориста","color":"red","italic":false}]
execute as @a[team=T] unless items entity @s armor.chest * run item replace entity @s armor.chest with leather_chestplate[unbreakable={},dyed_color=11546150,item_name={"text":"Куртка террориста","color":"red","italic":false}]
execute as @a[team=T] unless items entity @s armor.legs * run item replace entity @s armor.legs with leather_leggings[unbreakable={},dyed_color=11546150,item_name={"text":"Штаны террориста","color":"red","italic":false}]
execute as @a[team=T] unless items entity @s armor.feet * run item replace entity @s armor.feet with leather_boots[unbreakable={},dyed_color=11546150,item_name={"text":"Тяжелые ботинки","color":"red","italic":false}]

# Выдача Бомбы (C4) одному живому террористу
execute as @r[team=T,gamemode=adventure] run give @s tnt[unbreakable={},item_name={"text":"C4 (Бомба)","color":"dark_red","bold":true,"italic":false},can_place_on={blocks:["minecraft:red_wool"]}] 1
