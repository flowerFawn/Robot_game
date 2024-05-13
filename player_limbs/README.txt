#each limb has its own stats
#if a stat isn't present, that doesn't matter, it just won't do anything
#hp (standard for whole body is 60)
#weight (standard for whole body is bout 100)
#speed (multiplier, standard is 1)
#jump (only present on legs typically, standard is 30 per leg)
#script ("res://limb_scripts/script_name.gd")
#script_value (calls set_script_stats() on the script, and sets the variable to whatever script_value is)
#texture (res://sprites/limbs/limb/limb_texture.png) if there is no texture then it will give an error texture 
#company (a string from a predetermined list, not case sensitive)
#cost (how much scrap it costs to buy)

#weapons are very different, their stuff is here beneath. they can also use any value found in standard limbs, except for hosts, though it is not undone when destroyed as the systems are to intertwined with the rest of the body
#projectile ("res://instanceables/projectiles/scene_name.tscn") the projectile that gets loaded, texture is included in this
#attack_speed (in seconds)
#damage (damage it does, standard dps should be /put standard dps here/)
#projectile_speed (in units per second, not a Vector2)