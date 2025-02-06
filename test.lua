-- asciiquarium.lua
-- ASCII art aquarium animation using Lua and curses library
-- Requires Lua Curses and corresponding library
-- This program is distributed under the terms of the GNU General Public License

local curses = require('curses')
local anim = require('animation') -- Assuming you have a compatible Lua animation module

local version = "1.1"
local new_fish = 1
local new_monster = 1

local options = arg[1]
if options == '-c' then -- 'classic' mode
  new_fish = 0
  new_monster = 0
end

local random_objects = init_random_objects()

local depth = {
  guiText = 0,
  gui = 1,
  shark = 2,
  fish_start = 3,
  fish_end = 20,
  seaweed = 21,
  castle = 22,
  water_line3 = 2,
  water_gap3 = 3,
  water_line2 = 4,
  water_gap2 = 5,
  water_line1 = 6,
  water_gap1 = 7,
  water_line0 = 8,
  water_gap0 = 9
}

local function main()
  local anim = anim.new()
  curses.halfdelay(1)
  anim:color(1)

  while true do
    add_environment(anim)
    add_castle(anim)
    add_all_seaweed(anim)
    add_all_fish(anim)
    random_object(nil, anim)
    anim:redraw_screen()
    
    while true do
      local input = curses.getch()

      if input == 'q' then quit()
      elseif input == 'r' then break
      elseif input == 'p' then paused = not paused
      end

      if not paused then anim:animate() end
    end
    
    anim:update_term_size()
    anim:remove_all_entities()
  end
end

local function add_environment(anim)
  local water_line_segment = {
    "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",
    "^^^^ ^^^  ^^^   ^^^    ^^^^      ",
    "^^^^      ^^^^     ^^^    ^^     ",
    "^^      ^^^^      ^^^    ^^^^^^  "
  }

  local segment_size = #water_line_segment[1]
  local segment_repeat = math.floor(anim:width() / segment_size) + 1
  for i = 1, #water_line_segment do
    water_line_segment[i] = string.rep(water_line_segment[i], segment_repeat)
  end

  for i = 1, #water_line_segment do
    anim:new_entity {
      name = "water_seg_" .. i,
      type = "waterline",
      shape = water_line_segment[i],
      position = {0, i + 5, depth["water_line" .. i]},
      default_color = 'cyan',
      depth = 22,
      physical = 1
    }
  end
end

local function add_castle(anim)
  local castle_image = [[
               T~~
               |
              /^\
             /   \
 _   _   _  /     \  _   _   _
[ ]_[ ]_[ ]/ _   _ 

\[ ]_[ ]_[ ]
|_=__-_ =_|_[ ]_[ ]_|_=-___-__|
 | _- =  | =_ = _    |= _=   |
 |= -[]  |- = _ =    |_-=_[] |
 | =_    |= - ___    | =_ =  |
 |=  []- |-  /| |\   |=_ =[] |
 |- =_   | =| | | |  |- = -  |
 |_______|__|_|_|_|__|_______|
]]

  local castle_mask = [[
                RR

              yyy
             y   y
            y     y
           y       y

              yyy
             yy yy
            y y y y
            yyyyyyy
]]

  anim:new_entity {
    name = "castle",
    shape = castle_image,
    color = castle_mask,
    position = {anim:width() - 32, anim:height() - 13, depth.castle},
    default_color = 'BLACK'
  }
end

local function add_all_seaweed(anim)
  local seaweed_count = math.floor(anim:width() / 15)
  for i = 1, seaweed_count do
    add_seaweed(nil, anim)
  end
end

local function add_seaweed(old_seaweed, anim)
  local seaweed_image = {"", ""}
  local height = math.random(4) + 3
  for i = 1, height do
    local left_side = i % 2
    local right_side = 1 - left_side
    seaweed_image[left_side + 1] = seaweed_image[left_side + 1] .. "(\n"
    seaweed_image[right_side + 1] = seaweed_image[right_side + 1] .. " )\n"
  end
  local x = math.random(anim:width() - 2) + 1
  local y = anim:height() - height
  local anim_speed = math.random() * 0.05 + 0.25
  anim:new_entity {
    name = 'seaweed' .. math.random(),
    shape = seaweed_image,
    position = {x, y, depth.seaweed},
    callback_args = {0, 0, 0, anim_speed},
    die_time = os.time() + math.random(4 * 60) + (8 * 60), -- seaweed lives for 8 to 12 minutes
    death_cb = add_seaweed,
    default_color = 'green'
  }
end

local function add_bubble(fish, anim)
  local cb_args = fish:callback_args()
  local fish_size = fish:size()
  local fish_pos = fish:position()
  local bubble_pos = {table.unpack(fish_pos)}

  if cb_args[1] > 0 then
    bubble_pos[1] = bubble_pos[1] + fish_size[1]
  end
  bubble_pos[2] = bubble_pos[2] + math.floor(fish_size[2] / 2)
  bubble_pos[3] = bubble_pos[3] - 1

  anim:new_entity {
    shape = {".", "o", "O", "O", "O"},
    type = 'bubble',
    position = bubble_pos,
    callback_args = {0, -1, 0, 0.1},
    die_offscreen = 1,
    physical = 1,
    coll_handler = bubble_collision,
    default_color = 'CYAN'
  }
end

local function bubble_collision(bubble, anim)
  local collisions = bubble:collisions()
  for _, col_obj in ipairs(collisions) do
    if col_obj.type == 'waterline' then
      bubble:kill()
      break
    end
  end
end

local function add_all_fish(anim)
  local screen_size = (anim:height() - 9) * anim:width()
  local fish_count = math.floor(screen_size / 350)
  for i = 1, fish_count do
    add_fish(nil, anim)
  end
end

local function add_fish(old_fish, anim)
  if new_fish then
    if math.random(12) > 8 then
      add_new_fish(old_fish, anim)
    else
      add_old_fish(old_fish, anim)
    end
  else
    add_old_fish(old_fish, anim)
  end
end

-- Add additional functions for add_new_fish, add_old_fish, add_fish_entity, fish_callback, fish_collision, add_splat, add_shark, shark_death, add_ship, add_whale, add_new_monster, add_old_monster, add_big_fish, add_big_fish_1, add_big_fish_2, init_random_objects, random_object, dprint, sighandler, quit, initialize, center, rand_color, VERSION_MESSAGE similarly...

main()
