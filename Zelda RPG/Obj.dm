obj
	var
		list/atom/movable/willBreak = list("*")

	proc
		canBreak(m)
			if( istype(m, /atom/movable) )
				var/atom/movable/mov = m
				for( var/lbl in src.willBreak )
					if( mov.breakLabel == lbl )
						return 1
				return 0
			//else m is text (hopefully)
			for( var/lbl in src.willBreak )
				if( m == lbl )
					return 1
			return 0

		cutGrass()
			var/mob/Link/u = usr
			if( src in view(1) )
				u<< sound('Slash.midi', 0, 0, 0, 100)
				density=0
				icon_state="Cutting2"
				sleep(5)
				u.gainExp(1)
				var
					r = rand(1, 100)
					atom/s = src.loc
				src.die()
				if( r <= 5 )
					new/obj/Rupees/Blue(s)
				else if( r <= 20 )
					new/obj/Rupees/Green(s)
				else if( r<= 20 )
					new/obj/Rupees/Blinking(s)
				else if( r<= 10 )
					new/obj/Hearts/Normal(s)

	Hearts
		icon = 'Hearts.dmi'

		Normal
			icon_state = "normal"

			var
				slowState = "normal slow"
				fastState = "normal fast"
				aliveTime = 40

			New(loc)
				..()
				sleep(src.aliveTime)
				icon_state = slowState
				sleep(20)
				icon_state = fastState
				sleep(10)
				src.die()

			Click()
				var/mob/Link/u = usr
				u.heal(4)
				src.die()
	Rupees
		icon = 'Rupee.dmi'

		var
			value = 1
			slowState = "green slow"
			fastState = "green fast"
			aliveTime = 40

		New(loc)
			..()
			sleep(src.aliveTime)
			icon_state = slowState
			sleep(20)
			icon_state = fastState
			sleep(10)
			src.die()

		Click()
			var/mob/Link/u = usr
			if( u.wallet != null )
				u.wallet.add(src)
				src.die()

		Green
			icon_state = "green"
			slowState = "green slow"
			fastState = "green fast"
			value = 1

		Blue
			icon_state = "blue"
			slowState = "blue slow"
			fastState = "blue fast"
			value = 5

		Yellow
			icon_state = "yellow"
			slowState = "yellow slow"
			fastState = "yellow fast"
			value = 10

		Red
			icon_state = "red"
			slowState = "red slow"
			fastState = "red fast"
			value = 20

		Purple
			icon_state = "purple"
			slowState = "purple slow"
			fastState = "purple fast"
			value = 50

		Silver
			icon_state = "silver"
			value = 100

		Orange
			icon_state = "orange"
			value = 200

		Blinking
			icon_state = "blinking"
			slowState = "blinking slow"
			fastState = "blinking fast"
			value = 0

			var
				obj/Rupees/realValue = null

			New(loc)
				var/r = rand(1, 1000)
				if( r <= 2 )
					src.realValue = new/obj/Rupees/Purple()
				else if( r <= 20 )
					src.realValue = new/obj/Rupees/Red()
				else if( r <= 50 )
					src.realValue = new/obj/Rupees/Yellow()
				else if( r <= 200 )
					src.realValue = new/obj/Rupees/Blue()
				else if( r <= 700 )
					src.realValue = new/obj/Rupees/Green()
				else
					src.realValue = null
				..()

			Click()
				var/mob/Link/u = usr
				if( u.walletB != null )
					u.walletB.add(src)
					src.die()

	Walls
		density=1
		Cliffs
			icon='Cliff.dmi'
			Down
				icon_state="1"
			Turns
				Right
					icon_state="3"
				Left
					icon_state="2"
			Corners
				LeftDown
					icon_state="4"
				RightDown
					icon_state="5"
				RightUp
					icon_state="6"
				LeftUp
					icon_state="7"
			Sides
				Up
					icon_state="8"
				Left
					icon_state="9"
				Right
					icon_state="10"
				Down
					icon_state="11"
				UpLeft
					icon_state="14"
				UpRight
					icon_state="15"
				UpMiddle
					icon_state="16"
			SidetoDown
				Left
					icon_state="12"
				Right
					icon_state="13"
		HouseWalls
			icon='HouseWalls.dmi'
			Corners_Inwards
				UpLeft
					icon_state="upleft"
				UpRight
					icon_state="upright"
				DownLeft
					icon_state="downleft"
				DownRight
					icon_state="downright"
			Corners_Outwards
				UpLeft
					icon_state="upleft2"
				UpRight
					icon_state="upright2"
				DownLeft
					icon_state="downleft2"
				DownRight
					icon_state="downright2"
			Sides
				Up
					icon_state="up"
				Down
					icon_state="down"
				Left
					icon_state="left"
				Right
					icon_state="right"

		CaveWalls
			icon='CaveWalls.dmi'
			Corners_Inwards
				UpLeft
					icon_state="upleft"
				UpRight
					icon_state="upright"
				DownLeft
					icon_state="downleft"
				DownRight
					icon_state="downright"
			Corners_Outwards
				UpLeft
					icon_state="upleft2"
				UpRight
					icon_state="upright2"
				DownLeft
					icon_state="downleft2"
				DownRight
					icon_state="downright2"
			Sides
				bumped(mob/Link/m)
					m.hopDown(src)

				Up
					icon_state="up"
					dir = NORTH
				Down
					icon_state="down"
					dir = SOUTH
				Left
					icon_state="left"
					dir = WEST
				Right
					icon_state="right"
					dir = EAST

	Fences
		icon = 'Fence.dmi'
		density=1
		Wood
			icon_state = "wood"
		Metal
			icon_state = "metal"

	House_Items
		icon = 'HouseItems.dmi'
		density=1
		Invis_Block
		Bed
			icon_state = "bed"
		Bookshelf
			icon_state = "bookshelf"
		Dresser
			icon_state = "dresser"
		Stool
			icon_state = "stool"
		Cash_Register
			icon_state = "register"
		Counter
			Left
				icon_state = "c1"
			Mid
				icon_state = "c2"
			Right
				icon_state = "c3"
		Table
			Left
				icon_state = "t1"
			Right
				icon_state = "t2"


	House
		density=1
		icon='House.dmi'
		Wall
			icon_state="wall"
		Roof
			LeftFront
				icon_state="roof1"
			RightFront
				icon_state="roof2"
			MidFront
				icon_state="roof3"
			MidBack
				icon_state="roof4"
			LeftBack
				icon_state="roof5"
			RightBack
				icon_state="roof6"
			ShopSign
				icon_state="roofshop"
			Chimney
				icon_state="Chim"

	KeyDoors
		icon='KeyDoors.dmi'
		density=1

		bumped(mob/Link/m)
			src.Click()
			return 1

		Normal
			Click()
				set src in oview(1)
				var/mob/Link/u = usr
				if(u.keys >= 1)
					u<< sound('Corect Sound.midi', 0, 0, 0, 100)
					u.keys--
					del(src)
				else
					alert("Damn, it's Locked!","","Ok")
			Up
				icon_state="up"
			Down
				icon_state="down"
			Left
				icon_state="left"
			Right
				icon_state="right"
			Block
				icon_state="block"
		Boss
			Click()
				set src in oview(1)
				var/mob/Link/u = usr
				if(u.bosskeys >= 1)
					u<< sound('Corect Sound.midi', 0, 0, 0, 100)
					u.bosskeys--
					del(src)
				else
					alert("Damn, it's Locked!","","Ok")
			Up
				icon_state="bossup"
			Down
				icon_state="bossdown"
			Left
				icon_state="bossleft"
			Right
				icon_state="bossright"


	Keys
		icon='Keys.dmi'
		Basic
			icon_state="Basic"
			Click()
				if(src in view(1))
					set src in oview(0)
					var/mob/Link/u = usr
					layer = MOB_LAYER+1
					sleep(3)
					u.keys++
					del(src)
		Boss
			icon_state="Boss"
			Click()
				if(src in oview(1))
					set src in oview(0)
					var/mob/Link/u = usr
					layer = MOB_LAYER+1
					sleep(3)
					u.bosskeys++
					del(src)

	Treasure_Chests
		icon='Chests.dmi'
		density=1
		name="Treasure Chest"
		icon_state="closed"

		proc
			giveKeyItem()
				usr.icon_state = "Get"
				while( src.contents.len != 0 )
					var/atom/movable/item = src.contents[1]
					item.Move(src.loc, 0)
					usr << sound('Get Item.midi', 0, 0, 0, 100)
					item.layer++
					for( var/j = 0, j < 16, j++ )
						item.pixel_y++
						sleep(1)
					if( item.Move(usr, null) )
						alert(usr, "You found [item]!","","")
				usr.icon_state = null

				if( usr.client != null )
					usr.client.updateHUD()

		Basic_Key_Chest
			Click()
				if(src in oview(1))
					if(src.icon_state=="closed")
						usr.icon_state = "Get"
						src.icon_state="open"
						var/mob/Link/u = usr
						u<< sound('Corect Sound.midi', 0, 0, 0, 100)
						var/obj/item=new/obj/Keys/Basic(src.loc)
						item.layer++
						for(var/i=0, i<16, i++)
							item.pixel_y++
							sleep(1)
						alert("You found a Basic Key!","","")
						u.keys++
						del(item)
						usr.icon_state = null

		Boss_Key_Chest
			Click()
				if(src in oview(1))
					if(src.icon_state=="closed")
						usr.icon_state = "Get"
						src.icon_state="open"
						var/mob/Link/u = usr
						u<< sound('Corect Sound.midi', 0, 0, 0, 100)
						var/obj/item = new/obj/Keys/Basic(src.loc)
						item.layer++
						for(var/i=0, i<16, i++)
							item.pixel_y++
							sleep(1)
						alert("You found the Boss Key!","","")
						u.bosskeys++
						del(item)
						usr.icon_state = null

		KeyItemChest
			Click()
				if(src in oview(1))
					if( src.icon_state == "closed" )
						src.icon_state = "open"
						src.giveKeyItem()

			RocsFeather_Chest
				New()
					new/obj/Key_Items/Feather(src)

			Hammer_Chest
				New()
					new/obj/Key_Items/Hammer(src)

			Flippers_Chest
				New()
					new/obj/Key_Items/Flippers(src)

			Bow_Chest
				New()
					new/obj/Key_Items/Bow(src)
					src.contents.Add( new/obj/Quiver(30) )

	Key_Items
		icon='Key Items.dmi'

		Flippers
			icon_state="Flippers"
			name = "The Flippers"
			screen_loc = "StatusMap:9,4"

		Hammer
			icon_state="Hammer"
			name = "Hammer"
			screen_loc = "StatusMap:1,4"
			breakLabel = "Hammer"
			Click()
				var/mob/Link/u = usr
				u.hammer()

		Feather
			icon_state="Feather"
			name = "Roc's Feather"
			screen_loc = "StatusMap:2,4"
			Click()
				var/mob/Link/u = usr
				u.feather()

		Bow
			icon_state = "Bow"
			name = "Fairy Bow"
			screen_loc = "StatusMap:3,4"
			Click()
				var/mob/Link/u = usr
				u.arrow()



	Trees
		icon='tree.dmi'
		density=1
		Normal
			LowerLeft
				icon_state="grass1"
			LowerRight
				icon_state="grass2"
			UpperLeft
				icon_state="grass3"
			UpperRight
				icon_state="grass4"
		Dark
			LowerLeft
				icon_state="dark1"
			LowerRight
				icon_state="dark2"
			UpperLeft
				icon_state="dark3"
			UpperRight
				icon_state="dark4"

		Dead
			LowerLeft
				icon_state="dead1"
			LowerRight
				icon_state="dead2"
			UpperLeft
				icon_state="dead3"
			UpperRight
				icon_state="dead4"


	Grass
		icon='Grass.dmi'
		icon_state="Cutting"
		density=1
		Click()
			cutGrass()
		die()
			src.Move(GRAVEYARD)
		reset()
			src.resetAtomVars()

	Grass_Low
		icon='Grass.dmi'
		icon_state="CuttingLow"
		icon='Grass.dmi'
		icon_state="CuttingLow"
		Click()
			cutGrass()
		die()
			src.Move(GRAVEYARD)
		reset()
			src.resetAtomVars()

	Flowers
		icon='Grass.dmi'
		icon_state="Flower Cutting"
		density=1
		Click()
			cutGrass()
		die()
			src.Move(GRAVEYARD)
		reset()
			src.resetAtomVars()

	Rocks
		icon='Rock.dmi'
		Rock
			icon_state="Rock"
			density=1

		Smash_Rock
			icon_state="Smash"
			density=1
			willBreak = list("*", "Hammer")

			Click()
				if( src in oview(1) )
					for(var/obj/Key_Items/Hammer/h in usr.contents)
						src.icon_state="Smash2"
						sleep(2)
						del(src)
						return
					//else
					alert("I can't break this!","","")

	Cactus
		icon='Cactus.dmi'
		density=1

		bumped(mob/Link/m)
			m.hurt(1)
			return 1

	Arrow
		icon = 'Arrow.dmi'
		density = 1
		flying = 1

		var
			mob/Link/link = null

		proc
			shoot(mob/Link/m)
				src.loc = m.loc
				src.link = m
				walk(src, m.dir, 1)

		Move(loc, dir)
			if( src.link == null || src.link.client != null && src in view(src.link.client.view, src.link.client.eye) )
				..(loc, dir)
			else
				del(src)

		Bump(atom/a)
			if( src.link != null )
				a.shot(src)
				del(src)
			else
				..(a)

	Dungeon_Objects

		Level_1
			icon='Level1.dmi'

			Statue
				icon_state="statue1"
				density=1

			Block
				icon_state="block"
				density=1

			Push_Block
				icon_state="block"
				density=1

				bumped(mob/Link/m)
					step(src, m.dir)
					return 1

				reset()
					src.resetAtomVars()

				Once
					var
						isPushed=0

					bumped(mob/Link/m)
						if( !src.isPushed && step(src, m.dir) )
							src.isPushed = 1
						return 1

					reset()
						..()
						src.isPushed = 0

					Directional
						bumped(mob/Link/m)
							var/atom/a = get_step( src, oppDir(src.dir) )
							if( !src.isPushed && (m in a.contents) && step(src, m.dir) )
								src.isPushed = 1
							return 1

			Torch
				icon_state="torch"
				density=1
			Walls
				density=1
				Pillar
					icon_state="Pillar"
					density=1
				Straight
					icon_state="wall1"

					bumped(mob/Link/m)
						m.hopDown(src)

				Coners_Inwards
					UpRight
						icon_state="wall8"
					UpLeft
						icon_state="wall7"
					DownRight
						icon_state="wall6"
					DownLeft
						icon_state="wall5"
				Coners_Outwards
					UpRight
						icon_state="wall12"
					UpLeft
						icon_state="wall11"
					DownRight
						icon_state="wall10"
					DownLeft
						icon_state="wall9"
			Outside
				density=1
				DownRight
					icon_state="Right"
				DownLeft
					icon_state="Left"
				MidRight
					icon_state="midright"
				MidMiddle
					icon_state="midmiddle"
				MidLeft
					icon_state="midleft"
				UpRight
					icon_state="upright"
				UpMiddle
					icon_state="upmiddle"
				UpLeft
					icon_state="upleft"
		Level_2
			icon='Level2.dmi'

			Statue
				icon_state="statue2"
				density=1
			Walls
				density=1
				Straight
					icon_state="wall1"

					bumped(mob/Link/m)
						m.hopDown(src)

				Coners_Inwards
					UpRight
						icon_state="wall8"
					UpLeft
						icon_state="wall7"
					DownRight
						icon_state="wall6"
					DownLeft
						icon_state="wall5"
				Coners_Outwards
					UpRight
						icon_state="wall12"
					UpLeft
						icon_state="wall11"
					DownRight
						icon_state="wall10"
					DownLeft
						icon_state="wall9"
			Outside
				density=1
				DownRight
					icon_state="right"
				DownLeft
					icon_state="left"
				UpRight
					icon_state="upright"
				UpMiddle
					icon_state="upmiddle"
				UpLeft
					icon_state="upleft"

		Level_3
			icon='Level3.dmi'
			Statue
				icon_state="statue"
				density=1
			Walls
				density=1
				Straight
					icon_state="wall1"
				Corner_in
					icon_state="wall2"
				Corner_out
					icon_state="wall3"

			Waterfall_Outside
				icon='Water.dmi'
				layer = OBJ_LAYER+1
				Top
					icon_state="Waterfall Half2"
				Bottom
					icon_state="Waterfall Half"

			Outside
				icon='Level3out.dmi'

				Density_Block
					density=1

					New()
						src.icon = new/icon()

				New()
					for( var/x = 0, x < 6, x++ )
						for( var/y = 0, y < 4, y++ )
							var/atom/l = locate(src.loc.x + x, src.loc.y + y, src.loc.z)
							if( y == 0 && (x == 2 || x == 3) )
								new/turf/Caves_and_Doors/Dungeons/Level_3/Entrance(l)
							else if( y == 2 && (x == 2 || x == 3) )
								new/obj/Dungeon_Objects/Level_3/Waterfall_Outside/Bottom(l)
							else
								new/obj/Dungeon_Objects/Level_3/Outside/Density_Block(l)

		Level_4
			icon='Level4.dmi'
			Walls
				density=1
				Straight
					icon_state="wall1"

					bumped(mob/Link/m)
						m.hopDown(src)

				Coners_Inwards
					UpRight
						icon_state="wall8"
					UpLeft
						icon_state="wall7"
					DownRight
						icon_state="wall6"
					DownLeft
						icon_state="wall5"
				Coners_Outwards
					UpRight
						icon_state="wall12"
					UpLeft
						icon_state="wall11"
					DownRight
						icon_state="wall10"
					DownLeft
						icon_state="wall9"
			Statue
				icon_state="statue"
			Outside
				Floor
					icon_state="outfloor"

				Gate
					icon='Level3gate.dmi'
					density=1
					layer = MOB_LAYER+1

					Gate
						icon_state="gate"

						shot(obj/Arrow/a)
							a.link.mobilizeRoom(0)
							a.link.shakeRoom(2, 2)
							a.link.mobilizeRoom(1)
							a.link << sound('Corect Sound.midi', 0, 0, 0, 100)
							del(src)

					Pole
						icon_state="pole"

					Del()
						src.icon='Explode.dmi'
						sleep(5)
						return ..()



	HealthHeart
		icon = 'health.dmi'
		icon_state = "4"

		New(n)
			screen_loc = "StatusMap:[(n - 1) % 10 + 1],[3 - round( (n - 1) / 10 )]"

	MapBackground
		icon = 'background.dmi'
		icon_state = "White"

		New(mapTitle, x, y)
			screen_loc = "[mapTitle]:1,1 to [x],[y]"

	MapNumber
		icon = 'number.dmi'

		New(n, x = n, y = 4, xOffset = 0, yOffset = 0)
			icon_state = "[n]"
			screen_loc = "StatusMap:[x]:[xOffset],[y]:[yOffset]"

	Wallet
		icon = 'Rupee.dmi'
		icon_state = "HUD green"
		name = "Wallet"
		screen_loc = "StatusMap:10,4"

		var
			capacity = 99
			rupees = 0
			list/obj/MapNumber/hudNums = list()

		proc
			add(r)
				if( istype( r, /obj/Rupees ) )
					var/obj/Rupees/rupee = r
					r = rupee.value
				src.rupees += r
				if( src.rupees > src.capacity )
					src.rupees = src.capacity
				else if( src.rupees < 0 )
					src.rupees = 0
				src.updateHUD()
				return r

			updateHUD()
				for( var/i = 1, i <= 4, i++ )
					var/obj/MapNumber/hudNum = hudNums[i]
					if( src.rupees < 10 ** (i - 1) && i != 1 )
						hudNum.icon_state = "blank"
					else
						hudNum.icon_state = "[round( (src.rupees % (10 ** i)) / (10 ** (i - 1)) )]"

			transfer(obj/Wallet/dest, amount = src.rupees)
				if( amount > src.rupees )
					amount = src.rupees
				if( amount + dest.rupees > dest.capacity )
					amount = dest.capacity
				src.add(-amount)
				dest.add(amount)
				return amount

		New(amount)
			..()
			if( amount <= 99 )
				src.capacity = 99
				src.icon_state = "HUD green"
				src.name = "Kid's Wallet"
			else if( amount <= 200 )
				src.capacity = 200
				src.icon_state = "HUD blue"
				src.name = "Adult's Wallet"
			else if( amount <= 500 )
				src.capacity = 500
				src.icon_state = "HUD blue"
				src.name = "Giant's Wallet"
			else if( amount <= 1000 )
				src.capacity = 1000
				src.icon_state = "HUD purple"
				src.name = "Hero's Wallet"
			else if( amount <= 9999 )
				src.capacity = 9999
				src.icon_state = "HUD orange"
				src.name = "King's Wallet"
			else
				src.capacity = amount
			for( var/i = 1, i <= 4, i++ )
				src.hudNums.Add( new/obj/MapNumber("blank", 10, 4, (i - 1) * -8, 0) )
			src.updateHUD()


	BlinkingWallet
		icon = 'Rupee.dmi'
		icon_state = "HUD blinking"
		screen_loc = "StatusMap:11,4"

		var
			capacity = 9999
			list/obj/Rupees/Blinking/rupees = list()
			list/obj/MapNumber/hudNums = list()

		proc
			add(obj/Rupees/Blinking/rupee)
				if( rupees.len >= src.capacity )
					return 0
				src.rupees.Add(rupee)
				src.updateHUD()
				return 1

			remove()
				if( rupees.len <= 0 )
					return null
				var/obj/Rupees/Blinking/rupee = src.rupees[1]
				src.rupees.Remove(rupee)
				return rupee

			updateHUD()
				for( var/i = 1, i <= 4, i++ )
					var/obj/MapNumber/hudNum = hudNums[i]
					if( src.rupees.len < 10 ** (i - 1) && i != 1 )
						hudNum.icon_state = "blank"
					else
						hudNum.icon_state = "[round( (src.rupees.len % (10 ** i)) / (10 ** (i - 1)) )]"

			transfer(obj/BlinkingWallet/dest, amount = src.rupees)
				if( amount > src.rupees.len )
					amount = src.rupees.len
				if( amount + dest.rupees.len > dest.capacity )
					amount = dest.capacity
				for( var/i = 0, i < amount, i++ )
					dest.add( src.remove() )
				return amount

		New()
			..()
			for( var/i = 1, i <= 4, i++ )
				hudNums.Add( new/obj/MapNumber("blank", 11, 4, (i - 1) * -8, 0) )
			src.updateHUD()
