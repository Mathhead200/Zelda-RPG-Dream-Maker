
atom
	proc
		bumped(mob/Link/m)
			return 0

		shot(obj/Arrow/a)

		getCenter()
			var
				v = world.view + 1
				w = world.view * 2 + 1
			return locate( floor((src.x-1) / w) * w + v, floor((src.y-1) / w) * w + v, src.z )

		getRoom()
			var
				atom/center = src.getCenter()
				atom/list/room = list()
			for( var/x = center.x - world.view, x <= center.x + world.view, x++ )
				for( var/y = center.y - world.view, y <= center.y + world.view, y++ )
					room.Add( locate( x, y, src.z ) )
			return room

		shakeRoom(offset, count, lagTime = 1)
			var/atom/list/room = src.getRoom()
			for( var/c = 0, c < count, c++ )
				for( var/i = 0, i < offset, i++ )
					for( var/atom/a in room )
						a.pixel_x -= 1
					sleep(lagTime)
				for( var/i = 0, i < offset, i++ )
					for( var/atom/a in room )
						a.pixel_x += 1
					sleep(lagTime)
				for( var/i = 0, i < offset, i++ )
					for( var/atom/a in room )
						a.pixel_x += 1
					sleep(lagTime)
				for( var/i = 0, i < offset, i++ )
					for( var/atom/a in room )
						a.pixel_x -= 1
					sleep(lagTime)

		mobilizeRoom(isMoble = 1)
			var/atom/list/room = src.getRoom()
			for( var/atom/a in room )
				for( var/atom/movable/m in a.contents )
					m.isImmobile = !isMoble

		resetRoom(u)
			var/atom/list/room = src.getRoom()
			for( var/atom/a in room )
				for( var/atom/movable/m in a.contents )
					m.reset()
			for( var/atom/movable/m in GRAVEYARD )
				m.reset()