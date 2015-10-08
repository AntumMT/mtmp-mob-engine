--= Zombie for Creatures MOB-Engine (cme) =--
-- Copyright (c) 2015 BlockMen <blockmen2015@gmail.com>
--
-- init.lua
--
-- This software is provided 'as-is', without any express or implied warranty. In no
-- event will the authors be held liable for any damages arising from the use of
-- this software.
--
-- Permission is granted to anyone to use this software for any purpose, including
-- commercial applications, and to alter it and redistribute it freely, subject to the
-- following restrictions:
--
-- 1. The origin of this software must not be misrepresented; you must not
-- claim that you wrote the original software. If you use this software in a
-- product, an acknowledgment in the product documentation is required.
-- 2. Altered source versions must be plainly marked as such, and must not
-- be misrepresented as being the original software.
-- 3. This notice may not be removed or altered from any source distribution.
--


core.register_craftitem(":creatures:rotten_flesh", {
	description = "Rotten Flesh",
	inventory_image = "creatures_rotten_flesh.png",
	on_use = core.item_eat(1),
})

local def = {
  -- general
  name = "creatures:zombie",
  stats = {
    hp = 20,
    lifetime = 300, -- 5 Minutes
    can_jump = 1,
    can_swim = true,
    can_burn = true,
    has_falldamage = true,
    has_kockback = true,
    light = {min = 0, max = 8},
    hostile = true,
  },

  modes = {
    idle = {chance = 0.7, duration = 3, update_yaw = 6},--dur = 8 is gut
    walk = {chance = 0.3, duration = 5.5, moving_speed = 1.5},
    -- special modes
    attack = {chance = 0, moving_speed = 2.5},
  },

  model = {
    mesh = "zombie.b3d",
    textures = {"creatures_zombie.png"},
    collisionbox = {-0.25, -0.01, -0.3, 0.25, 1.75, 0.3},
    rotation = -90.0,
    animations = {
      idle = {start = 0, stop = 80, speed = 15},
      walk = {start = 168, stop = 188, speed = 15.5},
      attack = {start = 168, stop = 188, speed = 25},
      -- death
    },
  },

  sounds = {
      on_damage = {name = "creatures_zombie_hit", gain = 0.4, distance = 10},
      on_death = {name = "creatures_zombie_death", gain = 0.7, distance = 10},
      swim = {name = "creatures_splash", gain = 1.0, distance = 10},
      random = {
        idle = {name = "creatures_zombie", gain = 0.7, distance = 12},
      },
  },

  combat = {
    attack_damage = 1, -- in hp
    attack_speed = 0.6, -- time in seconds between hits
    attack_radius = 1.1, -- radius of hit range

    search_enemy = true,
    search_timer = 2,
    search_radius = 12, --in nodes
    search_type = "player", --types = {all, hostile, nonhostile, player, mates}
    --search_xray = false, -- can see through walls?
  },

  spawning = {
    abm_nodes = {
      spawn_on = {"default:stone", "default:dirt_with_grass", "default:dirt",
        "default:cobblestone", "default:mossycobble", "group:sand"},
    },
    abm_interval = 36,
    abm_chance = 7600,
    max_number = 1, -- per mapblock
    number = 2,
    --time_range = {min = 18500, max = 4000}, -- 0-24000
    light = {min = 0, max = 8},
    height_limit = {min = -200, max = 50},

    spawn_egg = {
      description = "Zombie Spawn-Egg",
      texture = "creatures_spawn_egg.png^[colorize:#2c9a",
    },

    spawner = {
      range = 8, -- defines area withing mobs are spawned
      number = 6, -- maxmimum number of mobs spawned in area defined via range
      light = {min = 0, max = 8}, -- additional light check
    }
  },

  drops = {
    {"creatures:rotten_flesh", {min = 1, max = 2}, chance = 0.7},
  }
}

creatures.register_mob(def)
