mob
	People
		Navi
			icon = 'Navi.dmi'
			density = 0
			layer = MOB_LAYER+1
			pixel_x = -8
			pixel_y = 16
			flying = 1

			proc
				getLink()
					for( var/mob/Link/l in src.group )
						return l
					return null

			New(mob/Link/l)
				src.loc=l.loc
				src.group.Add(l)
				walk_towards(src,l,3)

		BankTeller
			icon = 'BankTeller.dmi'

			var
				obj/Wallet/bank = new(200)

			New()
				src.bank.name = "Bank Wallet"
				var/obj/Rupees/Purple/p = new(src.loc)
				src.bank.add(p)
				//p.die()

			Click()
				var/mob/Link/u = usr
				alert(u,"--[src]--\n[src.bank]: [src.bank.rupees]\n--[u]--\n[u.wallet]: [u.wallet.rupees]")
				switch( input(u, "What do you want to do?", "[src]") as null|anything in list("Widthdraw", "Deposit") )
					if("Widthdraw")
						var/amount = input(u, "Widthdraw how much?", "Widthdraw", 0) as null|num
						if( amount == 0 || amount == null )
							return
						src.bank.transfer(u.wallet, amount)
					if("Deposit")
						var/amount = input(u, "Deposit how much?", "Deposit", 0) as null|num
						if( amount == 0 || amount == null )
							return
						u.wallet.transfer(src.bank)

		BankTeller_2
			icon = 'BankTeller.dmi'
			icon_state = "crazy"

			Click()
				var/mob/Link/u = usr
				alert(u,"G-Get outta' here man.. the Bank is c-closed for now.")

		Mayor
			icon = 'Mayor.dmi'
			layer = MOB_LAYER+1

			Click()
				var/mob/Link/u = usr
				alert(u,"Enjoy your stay here at Layham City!")

		Hope
			icon = 'Hope.dmi'
			dir = SOUTH

			Click()
				var/mob/Link/u = usr
				alert(u, "Hello, Link")

		Townsfolk
			icon = 'People.dmi'
			Old_Man
				icon_state = "old"

				Click()
					var/mob/Link/u = usr
					alert(u,"If I was twenty years younger I could move out of this little house.")

			Old_Woman
				icon_state = "old2"

				Click()
					var/mob/Link/u = usr
					alert(u,"If I could only get some medicine for my lower back pain, Ohh it's killing me.")

			Yound_Man
				icon_state = "man"

				Click()
					var/mob/Link/u = usr
					alert(u,"Hey, Link! Make yourself at home.")

			Young_Woman
				icon_state = "woman"

				Click()
					var/mob/Link/u = usr
					alert(u,"I don't know why, but I love it here, these fences around me make me feel safe I guess.")


	Enemies
		var
			/**
			 * Only to be changed in subtypes for special reasons.
			 * Defines how close link must get to this mobs square before he starts moving.
			 */
			view = 0
			/**
			 * Can not be jumped over (or on top of)
			 */
			tall = 0

		Move(loc, dir)
			var/atom/center = src.getCenter()
			for( var/a in view(world.view + src.view, center) )
				if( istype(a, /mob/Link) )
					var/mob/Link/m = a
					if( m.isImmobile )
						return 0
					else if( loc in view(world.view, center) )
						return ..(loc, dir)
					else
						var/d = get_dir(src, center)
						return ..( get_step(src, d), d )
			return 0

		die()
			src.dying=1
			src.icon='Explode.dmi'
			sleep(5)
			. = ..()

		Bump(a)
			if( istype(a, /mob/Link) )
				var/mob/Link/m = a
				if(!src.dying)
					m.hurt(src.atk)
			else
				..(a)

		bumped(mob/Link/m)
			if(!src.dying)
				m.hurt(src.atk)
				return 1
			else
				return 0

		shot(obj/arrow/a)
			src.hurt(1, false)
			..()

		reset()
			src.resetAtomVars()
			src.hp = initial(src.hp)

		Octorok
			density=1
			icon='Octorok.dmi'
			mobexp=1
			atk=1
			hp=1
			Click()
				var/mob/Link/u = usr
				if(src in view(1))
					u.attack(src)
			New()
				walk_rand(src,30)
			Move(loc,dir)
				.=..(loc,dir)
				flick('Octorok.dmi',src)
				flick("Walk",src)

		Octorok_Blue
			density=1
			icon='Octorok.dmi'
			icon_state="Blue"
			mobexp=2
			atk=1
			hp=2
			Click()
				var/mob/Link/u = usr
				if(src in view(1))
					u.attack(src)
			New()
				walk_rand(src,30)
			Move(loc,dir)
				.=..(loc,dir)
				flick('Octorok.dmi',src)
				flick("BlueWalk",src)

		Waspa
			density=1
			icon = 'Waspa.dmi'
			atk=1
			hp=1
			flying=1
			tall=1
			Click()
				var/mob/Link/u = usr
				u.hurt(0,true)


		Keese
			density=1
			icon='Keese.dmi'
			mobexp=1
			atk=1
			hp=1
			flying=1
			Click()
				var/mob/Link/u = usr
				if(src in view(1))
					u.attack(src)
			New()
				while(1)
					src.icon_state="Move"
					for(var/t=0, t<=30, t++)
						walk_rand(src,5)
						sleep(1)
					sleep(30)


		Moblin
			density=1
			icon='Moblin.dmi'
			mobexp=2
			atk=1
			hp=4
			Click()
				var/mob/Link/u = usr
				if(src in view(1))
					u.attack(src)
			New()
				walk_rand(src,20)
			Move(loc,dir)
				.=..(loc,dir)
				flick('Moblin.dmi',src)
				flick("Walk",src)

		Moblin_Blue
			density=1
			icon='Moblin.dmi'
			icon_state="Blue"
			mobexp=4
			atk=2
			hp=8
			Click()
				var/mob/Link/u = usr
				if(src in view(1))
					u.attack(src)
			New()
				walk_rand(src,20)
			Move(loc,dir)
				.=..(loc,dir)
				flick('Moblin.dmi',src)
				flick("BlueWalk",src)

		Spridra
			density=1
			icon='Spridra.dmi'
			mobexp=1
			atk=1
			hp=4
			Click()
				var/mob/Link/u = usr
				if(src in view(1))
					u.attack(src)
			New()
				while(1)
					step_towards(src, locate(/mob/Link))
					sleep(35)

	Bosses

		Layham
			icon='Boss 1.dmi'
			mobexp=75
			atk=2
			hp=20
			Click()
				var/mob/Link/u = usr
				if(src in view(1))
					u.attack(src)

			New()
				while(1)
					for( var/i = 0, i < world.view - 1, i++ )
						var/dest = get_step(src, SOUTH)
						while( src.loc != dest )
							step_towards(src, dest)
							sleep(10)
					for( var/i = 0, i < world.view - 1, i++ )
						var/dest = get_step(src, WEST)
						while( src.loc != dest )
							step_towards(src, dest)
							sleep(10)
					for( var/i = 0, i < world.view - 1, i++ )
						var/dest = get_step(src, NORTH)
						while( src.loc != dest )
							step_towards(src, dest)
							sleep(10)
					for( var/i = 0, i < world.view - 1, i++ )
						var/dest = get_step(src, EAST)
						while( src.loc != dest )
							step_towards(src, dest)
							sleep(10)

			/*Move(atom/loc, dir)
				if(..(loc, dir))
					var/atom/center = src.getCenter()
					world << "dir=[dir] ([loc.x - center.x],[loc.y - center.y],[loc.z - center.z])"*/

		Stinger
			icon='Boss 2.dmi'
			density=1
			mobexp=100
			atk=1
			hp=40

			Click()
				var/mob/Link/u=usr
				if(src in view(1))
					u.attack(src)

			New()
				walk_rand(src, 5)
				for( var/mini = 0, mini < 5, mini++ )
					new/mob/Bosses/Stinger_Mini(src)

		Stinger_Mini
			icon='Boss 2.dmi'
			icon_state="Mini"
			density=1
			mobexp=0
			atk=1
			hp=1

			var
				boss

			Click()
				var/mob/Link/u=usr
				if(src in view(1))
					u.attack(src)

			New(mob/Bosses/Stinger/s)
				loc = s.loc
				boss = s
				walk(src, SOUTH, 3)

			die()
				new/mob/Bosses/Stinger_Mini(boss)
				..()

			Move(loc, dir)
				if( get_dist(src, boss) > 3 )
					step_towards(src, boss)
					return 1
				var/mob/Link/link = null
				OUTER_LOOP:
					for( var/atom/a in src.getRoom() )
						for( var/atom/c in a.contents )
							if( istype(c, /mob/Link) )
								link = c
								break OUTER_LOOP
				if( link == null )
					return 0
				loc = get_step(src, link)
				dir = get_dir(src, loc)
				if( get_dist(loc, boss) <= 3 )
					return ..(loc, dir)
				return 0
