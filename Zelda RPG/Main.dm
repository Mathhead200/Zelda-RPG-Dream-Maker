/*
Direction Numbers:

     1
   9   5
 8       4
  10   6
     2
*/

var
	area/GRAVEYARD = new(null)
	NEWS = 16 //special dir (not compass)
	true = 1
	false = 0

proc
	floor(x)
		return round(x - 0.5, 1)

	isNorth(dir)
		return dir == NORTH || dir == NORTHWEST || dir == NORTHEAST
	isSouth(dir)
		return dir == SOUTH || dir == SOUTHWEST || dir == SOUTHEAST
	isWest(dir)
		return dir == WEST || dir == NORTHWEST || dir == SOUTHWEST
	isEast(dir)
		return dir == EAST || dir == NORTHWEST || dir == SOUTHEAST

	oppDir(dir)
		switch(dir)
			if(NORTH)
				return SOUTH
			if(NORTHEAST)
				return SOUTHWEST
			if(EAST)
				return WEST
			if(SOUTHEAST)
				return NORTHWEST
			if(SOUTH)
				return NORTH
			if(SOUTHWEST)
				return NORTHEAST
			if(WEST)
				return EAST
			if(NORTHWEST)
				return SOUTHEAST
			else
				return dir

world
	mob = /mob/Link
	view = 7

client
	//default_verb_category = "Actions"
	//command_text = ".alt "

	proc
		updateHUD()
			var
				mob/Link/u = src.mob
				fullHearts = round(u.hp / 4)

			for( var/i = 1, i <= fullHearts, i++ )
				var/obj/h = u.healthBar[i]
				h.icon_state = "4"
			if( u.hp != u.maxHP() )
				var/obj/h = u.healthBar[fullHearts + 1]
				h.icon_state = num2text( 4 * (u.hp / 4 - fullHearts) )
			for( var/i = fullHearts + 2, i < u.healthBar.len, i++ )
				var/obj/h = u.healthBar[i]
				h.icon_state = "0"

			for( var/atom/movable/m in u.contents )
				if( !(m in src.screen) )
					src.screen.Add(m)

		updateEye()
			var
				mob/Link/m = mob
				atom/l = m.getCenter()
				atom/e = eye
			if(l != e)
				m.isImmobile = 1
				for( var/i = e.x + 1, i <= l.x, i++ )
					eye = locate( i, e.y, e.z )
					sleep(1)
				for( var/i = e.x - 1, i >= l.x, i-- )
					eye = locate( i, e.y, e.z )
					sleep(1)
				for( var/i = e.y + 1, i <= l.y, i++ )
					eye = locate( e.x, i, e.z )
					sleep(1)
				for( var/i = e.y - 1, i >= l.y, i-- )
					eye = locate( e.x, i, e.z )
					sleep(1)
				var/otherLink = 0
				SEARCHING_ROOM:
					for( var/atom/a in e.getRoom() )
						for( var/mob/Link/aLink in a.contents )
							if( aLink != src.mob )
								otherLink = 1
								break SEARCHING_ROOM
				if( !otherLink )
					e.resetRoom()
				m.bringNavi()
				m.isImmobile = 0


mob
	var
		hp=1
		atk=0
		mobexp=0
		exp=0
		dying=0
		list/obj/Heart = list()

	proc
		gainExp(x)
			src.exp+=x

		attack(mob/target)
			target.hp-=src.atk
			src << sound('Slash.midi', 0, 0, 0, 100)
			if(target.hp<=0)
				src.gainExp(target.mobexp)
				target.die()
		hurt(x)
			src.hp -= x
			if( src.client != null )
				src.client.updateHUD()
			if( src.hp <= 0 )
				src.die()


mob/Link
	//Start of Link's Data//

	icon='Link.dmi'
	icon_state = ""

	var
		//Exp Types/Amounts
		//exp is below
		hpexp=95
		mpexp=90
		atkexp=145
		//Attack Level/Amount
		//atk is below
		//Health Level/Amount
		//hp is below
		hplevel=1
		maxhp=10
		//Magic Level/Amount
		mp=5
		mplevel=1
		maxmp=5
		//Keys
		keys=0
		bosskeys=0
		//mics
		a=0
		obj/Wallet/wallet = null
		obj/BlinkingWallet/walletB = null

		//other vars "Chris was here!"
		list/obj/HealthHeart/healthBar = list( new/obj/HealthHeart(1), new/obj/HealthHeart(2), new/obj/HealthHeart(3) )
	exp=0
	hp=12
	atk=1
	a=0
	isImmobile = 1

	verb
		cheat()
			set hidden=1
			src.hp+=100
			src.atk+=10
			density=0
			src.client.updateHUD()

		uncheat()
			set hidden=1
			density=1
			src.client.updateHUD()

		/*LevelUp()
			switch(input(usr,"Pick a Stat to Upgrade.","Level Up") as null|anything in list("Health","Magic","Attack"))
				if("Health")
					switch(alert("This will cost [src.hpexp] exp.","Health","Ok","Cancel"))
						if("Ok")
							if(src.exp>=src.hpexp)
								src.maxhp+=15
								src.hplevel++
								src.hp=src.maxhp
								alert("Your Health has gone up!")
								src.exp-=src.hpexp
								src.hpexp*=1.5
							else
								alert("Not enough Exp")
				if("Magic")
					switch(alert("This will cost [src.mpexp] exp.","Magic","Ok","Cancel"))
						if("Ok")
							if(src.exp>=src.mpexp)
								src.maxmp+=10
								src.mplevel++
								src.mp=src.maxmp
								alert("Your Magic has gone up!")
								src.exp-=src.mpexp
								src.mpexp*=1.5
							else
								alert("Not enough Exp")
				if("Attack")
					switch(alert("This will cost [src.atkexp] exp.","Attack","Ok","Cancel"))
						if("Ok")
							if(src.exp>=src.atkexp)
								src.atk++
								alert("Your Attack has gone up by 1!")
								src.exp-=src.atkexp
								src.atkexp*=1.5
							else
								alert("Not enough exp")
		*/

		click()
			set hidden = 1
			var/turf/s = get_step(src, src.dir)
			if( s.contents.len )
				var/atom/movable/m = s.contents[1]
				m.Click()
			else
				s.Click()

		faceNorth()
			set hidden=1
			src.dir=NORTH
		faceSouth()
			set hidden=1
			src.dir=SOUTH
		faceWest()
			set hidden=1
			src.dir=WEST
		faceEast()
			set hidden=1
			src.dir=EAST

		sword()

			/*src.icon = 'LinkSword.dmi'
			var
				initialX = src.pixel_x
				initialY = src.pixel_y
			if( src.dir == WEST )
				src.pixel_x -= 32
			else if( src.dir==SOUTH )
				src.pixel_y -= 32
				src.pixel_x -= 32
			sleep(5)
			src.icon = 'Link.dmi'
			src.pixel_x = initialX
			src.pixel_y = initialY
			*/

		hammer()
			//NOT WORKING!!!
			for( var/obj/Key_Items/Hammer/hammer in usr.contents )
				var/turf/s = get_step(src, src.dir)
				if( !s.contents.len )
					return
				var/atom/movable/m = s.contents[1]
				if( istype(m, /obj) )
					var/obj/o = s
					hammer.Bump(o)
				else //m is mob (hopefully)
					m.Click()
				return

		feather()
			for( var/obj/Key_Items/Feather/f in usr.contents )
				src.jump()
				break

		arrow()
			for( var/obj/Key_Items/Bow/b in usr.contents )
				var/obj
					Quiver/quiver = src.quiver()
					Arrow/arrow = quiver.getArrow()
				if( arrow != null )
					arrow.shoot(src)
				break

	proc
		mobsInView()
			var/list/r = view( client.view, src.getCenter() )
			for( var/m in r )
				if( !istype(m, /mob) )
					r.Remove(m)
			return r

		mobsInOView()
			var/list/r = oview( client.view, src.getCenter() )
			for( var/m in r )
				if( !istype(m, /mob) )
					r.Remove(m)
			return r

		maxHP()
			return healthBar.len * 4

		navi()
			for( var/mob/People/Navi/n in src.group )
				return n

		bringNavi()
			var/mob/People/Navi/navi = src.navi()
			navi.loc = src.loc

		quiver()
			for( var/obj/Quiver/q in src.contents )
				return q
			return null

		jump()
			var/mob/Link/u = src

			if( u.isImmobile || u.icon_state == "Jump" )
				return 0

			var/turf
				inBetween = get_step(u, u.dir)
				dest = locate( u.x + (u.dir==WEST ? -2 : u.dir==EAST ? 2 : 0), u.y + (u.dir==SOUTH ? -2 : u.dir==NORTH ? 2 : 0), u.z )
			if( inBetween.density || dest.density )
				return 0
			for( var/atom/movable/o in inBetween.contents + dest.contents )
				if( istype(o, /mob/Enemies) )
					var/mob/Enemies/e = o
					if( e.tall )
						return 0
				else if( o.density )
					return 0

			u.icon_state="Jump"
			u.layer++
			for(var/a=0, a<2, a++) //2 spaces
				var/d = 16 //pixels
				for(var/b=0, b<32/d, b++) //loop though 1 square, 32 pixels
					u.pixel_x += u.dir==WEST ? -d : u.dir==EAST ? d : 0
					u.pixel_y += u.dir==SOUTH ? -d : u.dir==NORTH ? d : 0
					sleep(2)
			u.icon_state=null
			u.pixel_x=initial(u.pixel_x)
			u.pixel_y=initial(u.pixel_y)
			u.layer = initial(u.layer)
			if( !u.Move(dest, null) && u.client != null )
				u.client.updateEye()

		hopDown(obj/o)
			var/atom/s = get_step(o, o.dir)
			if( src in s.contents )
				o.density = 0
				src.dir = oppDir(o.dir)
				src.jump()
				o.density = 1

		giveWallet(obj/Wallet/w)
			var/obj/Wallet/oldWallet = src.wallet
			src.wallet = w
			if( src.client != null )
				//remove old Wallet's HUD
				if( oldWallet != null )
					src.client.screen.Remove(oldWallet)
					for( var/obj/o in oldWallet.hudNums )
						src.client.screen.Remove(o)
				//add new Wallet's HUD
				src.client.screen.Add(w)
				for( var/obj/o in w.hudNums )
					src.client.screen.Add(o)
			return oldWallet

		giveWalletB(obj/BlinkingWallet/w)
			var/obj/BlinkingWallet/oldWallet = src.walletB
			src.walletB = w
			if( src.client != null )
				if( oldWallet != null )
					src.client.screen.Remove(oldWallet)
					for( var/obj/o in oldWallet.hudNums )
						src.client.screen.Remove(o)
				src.client.screen.Add(w)
				for( var/obj/o in w.hudNums )
					src.client.screen.Add(o)
			return oldWallet

		heal(x)
			src.hp += x
			if( src.hp > src.maxHP() )
				src.hp = src.maxHP()
			if( src.client != null )
				src.client.updateHUD()

	Bump(atom/a)
		if( !a.bumped(src) )
			..(a)

	Login()
		client.lazy_eye = world.view
		src.loc = locate(/turf/Misc/Start)
		. = ..()
		client.eye = src.getCenter()
		src.loc.loc.Entered(src, null)
		src.isImmobile = 0
		//Initialize HUD
		src.client.screen.Add( new/obj/MapBackground("StatusMap", 11, 4) )
		src.client.screen.Add( src.healthBar )
		for( var/i = 1, i <= 8, i++ )
			src.client.screen.Add( new/obj/MapNumber(i) )
		src.client.updateHUD()
		src.group.Add( new/mob/People/Navi(src) )
		src.giveWallet( new/obj/Wallet(99) )
		src.giveWalletB( new/obj/BlinkingWallet() )

	New(loc)

	Move(loc, dir)
		if( !(src.icon_state == null || src.icon_state == "Swim") )
			return 0
		switch(src.icon_state)
			if("Swim")
				flick("Swim",src)
				flick("SwimMove",src)
			if(null)
				flick(null,src)
				flick("walk",src)

		. = ..(loc, dir)
		/*
		src.dir = dir
		src.pixel_x += isEast(dir) ? 8 : isWest(dir) ? -8 : 0
		if( src.pixel_x >= 32 )
			. = ..( loc, EAST )
			src.pixel_x = 0
		else if( src.pixel_x <= -32 )
			. = ..( loc, WEST )
			src.pixel_x = 0
		src.pixel_y += isNorth(dir) ? 8 : isSouth(dir) ? -8 : 0
		if( src.pixel_y >= 32 )
			. = ..( loc, NORTH )
			src.pixel_y = 0
		else if( src.pixel_y <= -32 )
			. = ..( loc, SOUTH )
			src.pixel_y = 0
		*/
		if( src.client != null )
			src.client.updateEye()
		for( var/obj/Keys/k in view(0) )
			k.Click()
		for( var/obj/Rupees/r in view(0) )
			r.Click()
		for( var/obj/Hearts/h in view(0) )
			h.Click()

	hurt(x, displayGraphics = true)
		flick("hurt", src)
		..(x)
		if(displayGraphics)
			src.isImmobile = 1
			for( var/i = 0, i < 2, i++ )
				src.pixel_x += src.dir == EAST ? -4 : src.dir == WEST ? 4 : 0
				src.pixel_y += src.dir == NORTH ? -4 : src.dir == SOUTH ? 4 : 0
				sleep(1)
			for( var/i = 0, i < 2, i++ )
				sleep(1)
				src.pixel_x -= src.dir == EAST ? -4 : src.dir == WEST ? 4 : 0
				src.pixel_y -= src.dir == NORTH ? -4 : src.dir == SOUTH ? 4 : 0
			src.isImmobile = 0

	bumped(mob/Link/m)
		src.loc = m.loc
		if( src.client != null )
			src.client.updateEye()
			src.bringNavi()
		return 1

	//End of Link's Data//

