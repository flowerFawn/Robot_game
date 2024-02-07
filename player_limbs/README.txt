#each limb has its own stats
#if a stat isn't present, that doesn't matter, it just won't do anything
#hp (standard for whole body is 60)
#weight (standard for whole body is bout 100)
#speed (multiplier, standard is 1)
#jump (only present on legs typically, standard is 30 per leg)
#script ("res://limb_scripts/script_name.gd")
#script_value (calls set_script_stats() on the script, and sets the variable to whatever script_value is)

#weapons are very different, their stuff is here beneath
#projectile ("res://instanceables/projectiles/scene_name.tscn") the projectile that gets loaded
#attack_speed (in seconds)
#damage (damage it does, standard dps should be /put standard dps here/)