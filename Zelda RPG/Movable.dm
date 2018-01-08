
atom/movable
	var
		breakLabel = ""
		isImmobile = 0
		flying = 0

	proc
		reset()

		resetAtomVars()
			density = initial(density)
			dir = initial(dir)
			icon = initial(icon)
			icon_state = initial(icon_state)
			invisibility = initial(invisibility)
			infra_luminosity = initial(infra_luminosity)
			loc = initial(loc)
			layer = initial(layer)
			luminosity = initial(luminosity)
			opacity = initial(opacity)
			pixel_x = initial(pixel_x)
			pixel_y = initial(pixel_y)
			pixel_z = initial(pixel_z)

		die()
			del(src)

	Bump(atom/a)
		if( istype(a, /obj) )
			var/obj/o = a
			if( o.canBreak(src) )
				del(o)
		else
			..(a)

	Move(loc, dir)
		if( src.isImmobile )
			return 0
		return ..(loc, dir)
