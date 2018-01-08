turf
	Grid
		icon='Grid.dmi'

	Grass
		icon='Grass.dmi'
		Flowers
			icon_state="Flower"
		Leaves
			icon_state="Grass"
		Leaves2
			icon_state="Grass2"
		Plain
			icon_state="Plain"
		Water_Edges
			Corners
				DownLeft
					icon_state="edge1"
				DownRight
					icon_state="edge2"
				UpRight
					icon_state="edge3"
				UpLeft
					icon_state="edge4"
			Sides
				Down
					icon_state="edge5"
				Up
					icon_state="edge6"
				Right
					icon_state="edge7"
				Left
					icon_state="edge8"

	Sand
		icon='Dirt.dmi'
		icon_state="sand"

	Misc
		Start
			icon='Grass.dmi'
			icon_state="Start"
			Exited()
				src.icon_state="Plain"
				..()
		Town_Path
			icon='Ground.dmi'
			icon_state="Town"

		Wood
			icon='Ground.dmi'
			icon_state="House"

		Cave_Floor
			icon='Ground.dmi'
			icon_state="Cave"

	Water
		icon='Water.dmi'
		RiverWater
			icon_state="Deep"

			Enter(atom/movable/o)
				return ..(o) && ( istype(o, /mob/Link) || o.flying )

			Entered(atom/movable/o, atom/oldLoc)
				if( istype(o, /mob/Link) )
					var
						mob/Link/u = o
						list/flippers = list()
					for( var/obj/Key_Items/Flippers/f in u.contents )
						flippers.Add(f)
					if( flippers.len )
						u.icon_state = "Swim"
					else
						u.icon_state = "Drowning"
						sleep(15)
						u.hurt(1, false)
						u.loc = oldLoc
						u.icon_state = null

			Exited(atom/movable/o)
				o.icon_state = null

		ShallowWater
			icon_state="Shallow"

		Waterfall
			density=1
			Waterfall_Top
				icon_state = "Waterfall Top"
			Waterfall_Bottem
				icon_state = "Waterfall Bot"

	Dirt
		icon='Dirt.dmi'
		Middle
			icon_state="mid"
		Middle_Light
			icon_state="light"
		Sides
			Up
				icon_state="up"
			Down
				icon_state="down"
			Right
				icon_state="right"
			Left
				icon_state="left"
		Corners
			Up_Right
				icon_state="upright"
			Up_Left
				icon_state="upleft"
			Down_Right
				icon_state="downright"
			Down_Left
				icon_state="downleft"
	Stairs
		icon='Stairs.dmi'
		Staircase_Cliff
			icon_state="Cliff"
		Staircase_Inside
			Enter(atom/movable/m)
				if( istype(m, /obj/Dungeon_Objects/Level_1/Push_Block) )
					return 0
				return ..(m)
			Up
				icon_state="House1"
			Down
				icon_state="House2"
			Left
				icon_state="House4"
			Right
				icon_state="House3"
	Caves_and_Doors
		var
			dest = "/turf/Caves_and_Doors"

		Enter(atom/movable/o)
			return !istype(o, /mob/Enemies)

		Entered(atom/movable/o, atom/oldLoc)
			var/prevLoc = o.loc
			o.loc = locate(src.dest)
			src.resetRoom()
			o.loc.loc.Entered(o, prevLoc)
			if( istype(o, /mob/Link) )
				var/mob/Link/u = o
				u.bringNavi()
				if( u.client != null )
					u.client.eye = u.getCenter()

		New()
			..()
			src.tag = "[src.type]"


		Doors
			icon = 'House.dmi'

			Door1
				icon_state = "door"
				dest = "/turf/Caves_and_Doors/Doors/Exit1"

			Exit1
				icon_state = "exit"
				dest = "/turf/Caves_and_Doors/Doors/Door1"

			Door2
				icon_state = "door"
				dest = "/turf/Caves_and_Doors/Doors/Exit2"

			Exit2
				icon_state = "exit"
				dest = "/turf/Caves_and_Doors/Doors/Door2"

			Door3
				icon_state = "door"
				dest = "/turf/Caves_and_Doors/Doors/Exit3"

			Exit3
				icon_state = "exit"
				dest = "/turf/Caves_and_Doors/Doors/Door3"

			DoorShop
				icon_state = "door"
				dest = "/turf/Caves_and_Doors/Doors/ExitShop"

			ExitShop
				icon_state = "exit"
				dest = "/turf/Caves_and_Doors/Doors/DoorShop"

			DoorBank
				icon_state = "door"
				dest = "/turf/Caves_and_Doors/Doors/ExitBank"

			ExitBank
				icon_state = "exit"
				dest = "/turf/Caves_and_Doors/Doors/DoorBank"

			DoorHope
				icon_state = "door"
				dest = "/turf/Caves_and_Doors/Doors/ExitHope"

			ExitHope
				icon_state = "exit"
				dest = "/turf/Caves_and_Doors/Doors/DoorHope"

			DoorMayor
				icon_state = "door"
				dest = "/turf/Caves_and_Doors/Doors/ExitMayor"

			ExitMayor
				icon_state = "exit"
				dest = "/turf/Caves_and_Doors/Doors/DoorMayor"

		Dungeons
			Level_1
				icon ='Level1.dmi'

				Entrance
					icon_state = "Entrance"
					dest = "/turf/Caves_and_Doors/Dungeons/Level_1/Exit"

				Exit
					icon_state = "Exit"
					dest = "/turf/Caves_and_Doors/Dungeons/Level_1/Entrance"

			Level_2
				icon = 'Level2.dmi'

				Entrance
					icon_state = "Entrance"
					dest = "/turf/Caves_and_Doors/Dungeons/Level_2/Exit"

				Exit
					icon = 'Level1.dmi'
					icon_state = "Exit"
					dest = "/turf/Caves_and_Doors/Dungeons/Level_2/Entrance"

			Level_3
				Entrance
					dest = "/turf/Caves_and_Doors/Dungeons/Level_3/Exit"
				Exit
					icon = 'Level1.dmi'
					icon_state = "Exit"
					dest = "/turf/Caves_and_Doors/Dungeons/Level_3/Entrance"


			Level_4
				icon = 'Level4.dmi'

				Entrance
					icon_state = "Entrance"
					dest = "/turf/Caves_and_Doors/Dungeons/Level_4/Exit"

				Exit
					icon = 'Level1.dmi'
					icon_state = "Exit"
					dest = "/turf/Caves_and_Doors/Dungeons/Level_4/Entrance"


		Stairs
			icon='Stairs.dmi'

			Outside
				icon_state = "Outside"

			Inside
				Level_1
					Stair_a
						icon_state = "Inside"
						dest = "/turf/Caves_and_Doors/Stairs/Inside/Level_2/Stair_a_up"

					Stair_a_up
						icon_state = "Inside_up"
						dest = "/turf/Caves_and_Doors/Stairs/Inside/Level_2/Stair_a"

				Level_2
					Stair_a
						icon_state = "Inside"
						dest = "/turf/Caves_and_Doors/Stairs/Inside/Level_2/Stair_a_up"

					Stair_a_up
						icon_state = "Inside_up"
						dest = "/turf/Caves_and_Doors/Stairs/Inside/Level_2/Stair_a"

					Stair_b
						icon_state = "Inside"
						dest = "/turf/Caves_and_Doors/Stairs/Inside/Level_2/Stair_b_up"

					Stair_b_up
						icon_state = "Inside_up"
						dest = "/turf/Caves_and_Doors/Stairs/Inside/Level_2/Stair_b"

					Stair_c
						icon_state = "Inside"
						dest = "/turf/Caves_and_Doors/Stairs/Inside/Level_2/Stair_c_up"

					Stair_c_up
						icon_state = "Inside_up"
						dest = "/turf/Caves_and_Doors/Stairs/Inside/Level_2/Stair_c"

		Teleporters

		Caves
			icon = 'Caves.dmi'

			Cave1_a
				icon_state = "entrance"
				dest = "/turf/Caves_and_Doors/Caves/Exit1_a"

			Exit1_a
				icon_state = "exit"
				dest = "/turf/Caves_and_Doors/Caves/Cave1_a"

			Cave1_b
				icon = 'Stairs.dmi'
				icon_state = "Inside_up"
				dest = "/turf/Caves_and_Doors/Caves/Exit1_b"

			Exit1_b
				icon = 'Stairs.dmi'
				icon_state = "Outside"
				dest = "/turf/Caves_and_Doors/Caves/Cave1_b"

	Dungeon_Floors
		Level_1
			icon='Level1.dmi'
			Normal_Floor
				icon_state="floor"
			Boss_Floor
				icon_state="bossfloor"
			Entrance_Floor
				icon='DungeonEnter.dmi'
				layer = TURF_LAYER+1
		Level_2
			icon='Level2.dmi'
			Normal_Floor
				icon_state="floor"
			Boss_Floor
				icon_state="bossfloor"
			Black_Hole
				icon_state="hole"

				Enter(atom/movable/o)
					return ..(o) && ( istype(o, /mob/Link) || o.flying )

				Entered(atom/movable/o, atom/oldLoc)
					if( istype(o, /mob/Link) )
						var/mob/Link/u = o
						for( var/atom/m in src.contents )
							m.Click()
						u.icon_state = "Fall"
						sleep(10)
						u.hurt(1, false)
						u.loc = oldLoc
						u.icon_state = null

			Spikes
				icon_state="spikes"

				Enter(atom/movable/o)
					return ..(o) && ( istype(o, /mob/Link) || o.flying )

				Entered(atom/movable/o, atom/oldLoc)
					if( istype(o, /mob/Link) )
						var/mob/Link/m = o
						m.hurt(1, false)

		Level_3
			icon='Level3.dmi'
			Normal_Floor
				icon_state="floor"
			Boss_Floor
				icon_state="bossfloor"

		Level_4
			icon='Level4.dmi'
			Normal_Floor
				icon_state="floor"
			Boss_Floor
				icon_state="bossfloor"

	Black_Pit
		icon='Pit.dmi'

		Enter(atom/movable/o)
			return ..(o) && ( istype(o, /mob/Link) || o.flying )

		Entered(atom/movable/o, atom/oldLoc)
			if( istype(o, /mob/Link) )
				var/mob/Link/u = o
				for( var/atom/m in src.contents )
					m.Click()
				u.icon_state = "Fall"
				sleep(10)
				u.hurt(1, false)
				u.loc = oldLoc
				u.icon_state = null


